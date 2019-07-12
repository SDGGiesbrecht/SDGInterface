/*
 NSAttributedString.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGText

extension NSAttributedString {

    // MARK: - Initialization

    /// Creates an attributed string from rich text.
    ///
    /// - Parameters:
    ///     - richText: The rich text.
    public convenience init(_ richText: RichText) {
        self.init(attributedString: richText.attributedString())
    }

    // MARK: - Superscript & Subscript

    #if canImport(CoreGraphics)
    private static func superscriptPointSize(forBasePointSize baseSize: Double) -> Double {
        return baseSize × 5 ÷ 6
    }
    private static func basePointSize(forSuperscriptPointSize superscriptSize: Double) -> Double {
        return superscriptSize × 6 ÷ 5
    }

    internal static let htmlCorrection: Double = 3 ÷ 4
    #if canImport(AppKit)
    private static var lineHeightTable: [NSFont: [Double: Double]] = [:]
    #elseif canImport(UIKit)
    private static var lineHeightTable: [UIFont: [Double: Double]] = [:]
    #endif
    private static func lineHeight(for font: Font) -> Double {
        return cached(in: &lineHeightTable[font.native, default: [:]][font.size]) {
            let markedUp = SemanticMarkup("_").richText(font: font.resized(to: font.size × htmlCorrection))
            let paragraph = markedUp.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as! NSParagraphStyle
            return Double(paragraph.minimumLineHeight)
        }
    }

    private static func reduceSizeForSuperscript(_ attributes: inout [NSAttributedString.Key: Any]) {
        var font = attributes.font ?? Font.default
        let paragraphStyle = (attributes[.paragraphStyle] as? NSParagraphStyle ?? NSParagraphStyle.default).mutableCopy() as! NSMutableParagraphStyle

        font = font.resized(to: superscriptPointSize(forBasePointSize: font.size))
        paragraphStyle.minimumLineHeight = CGFloat(lineHeight(for: font))

        attributes.font = font
        attributes[.paragraphStyle] = paragraphStyle.copy()
    }

    internal static func addSuperscript(to attributes: inout [NSAttributedString.Key: Any]) {
        reduceSizeForSuperscript(&attributes)

        var baseline = attributes[.superscript] as? Int ?? 0
        baseline += 1
        attributes[.superscript] = baseline
    }

    internal static func addSubscript(to attributes: inout [NSAttributedString.Key: Any]) {
        reduceSizeForSuperscript(&attributes)

        var baseline = attributes[.superscript] as? Int ?? 0
        baseline −= 1
        attributes[.superscript] = baseline
    }

    fileprivate static func resetBaseline(for attributes: inout [NSAttributedString.Key: Any]) {
        var level = |(attributes[.superscript] as? Int ?? 0)|
        var font = attributes.font ?? Font.default
        let paragraphStyle = (attributes[.paragraphStyle] as? NSParagraphStyle ?? NSParagraphStyle.default).mutableCopy() as! NSMutableParagraphStyle

        while level ≠ 0 {
            defer { level −= 1 }

            font = font.resized(to: basePointSize(forSuperscriptPointSize: font.size))
            paragraphStyle.minimumLineHeight = CGFloat(lineHeight(for: font))
        }

        attributes.font = font
        attributes[.paragraphStyle] = paragraphStyle.copy() as! NSParagraphStyle
        attributes[.superscript] = nil
    }
    #endif
}

extension NSMutableAttributedString {

    #if canImport(AppKit) || canImport(UIKit)
    private func applyChanges(to range: NSRange, modifySection: (_ sectionRange: NSRange, _ sectionAttributes: [NSAttributedString.Key: Any]) -> Void) {
        if range.length ≠ 0 {
            var index = range.lowerBound
            while index < range.upperBound {
                var sectionRange = NSRange(location: 0, length: 0)
                let sectionAttributes = attributes(at: index, effectiveRange: &sectionRange)
                var lowerBound = sectionRange.lowerBound
                var upperBound = sectionRange.upperBound
                lowerBound.increase(to: index)
                upperBound.decrease(to: range.upperBound)
                sectionRange = NSRange(lowerBound ..< upperBound)

                modifySection(sectionRange, sectionAttributes)

                index = sectionRange.upperBound
            }
        }
    }

    private func applyUniformChanges(to range: NSRange, modifySection: (inout [NSAttributedString.Key: Any]) -> Void) {
        applyChanges(to: range) { (sectionRange: NSRange, sectionAttributes: [NSAttributedString.Key: Any]) in

            var sectionAttributes = sectionAttributes
            modifySection(&sectionAttributes)
            setAttributes(sectionAttributes, range: sectionRange)
        }
    }
    #endif

    #if canImport(AppKit)
    private func swapGlyphs(in range: NSRange, mapping performMap: (String) -> String, additionalChangesWhenTriggered makeAdditionalChanges: (inout [NSAttributedString.Key: Any]) -> Void) {

        applyChanges(to: range) { (sectionRange: NSRange, sectionAttributes: [NSAttributedString.Key: Any]) in

            let section = attributedSubstring(from: sectionRange).string
            let font = sectionAttributes.font ?? Font.default

            let prototypeAttributes: [NSAttributedString.Key: Any] = [.font: font.native]

            // ===== ===== NOTE ===== =====
            // Glyph interaction after substitution does not work, so glyphs must be as precomposed as possible to begin with. (The base string does not matter.)
            // ===== ===== ===== =====

            var scalarStart = section.scalars.startIndex
            while scalarStart ≠ section.scalars.endIndex {
                var scalarEnd = section.scalars.index(after: scalarStart)
                var tryLonger = true
                while tryLonger ∧ scalarEnd ≠ section.unicodeScalars.endIndex {
                    let character = String(section.unicodeScalars[scalarStart ..< section.scalars.index(after: scalarEnd)])
                    let replacement = performMap(character).precomposedStringWithCanonicalMapping
                    if replacement.unicodeScalars.count == 1 {
                        scalarEnd = section.scalars.index(after: scalarEnd)
                    } else {
                        tryLonger = false
                    }
                }

                let character = String(section.scalars[scalarStart ..< scalarEnd])
                let replacement = performMap(character).precomposedStringWithCanonicalMapping

                if character == replacement {
                    // No change.
                } else {
                    // Swap glyph(s).

                    let replacementStorage = NSTextStorage(string: replacement, attributes: prototypeAttributes)
                    let replacementLayout = NSLayoutManager()
                    replacementLayout.replaceTextStorage(replacementStorage)

                    let glyph = replacementLayout.glyph(at: 0)
                    let baseString = character
                    if let glyphInfo = NSGlyphInfo(glyph: glyph, for: font.native, baseString: baseString) {
                        let characterRange = NSRange(scalarStart ..< scalarEnd, in: section)
                        let charactersRangeInContext = NSRange((characterRange.lowerBound + sectionRange.lowerBound) ..< (characterRange.upperBound + sectionRange.lowerBound))
                        addAttribute(.glyphInfo, value: glyphInfo, range: charactersRangeInContext)

                        var mutableSelection = sectionAttributes
                        makeAdditionalChanges(&mutableSelection)
                        addAttributes(mutableSelection, range: charactersRangeInContext)
                    }
                }

                scalarStart = scalarEnd
            }
        }
    }
    #endif

    // MARK: - Superscript & Subscript

    #if canImport(CoreGraphics)
    /// Superscripts a subrange.
    ///
    /// - Parameters:
    ///     - range: The range to superscript.
    public func superscript(_ range: NSRange) {
        applyUniformChanges(to: range) { NSAttributedString.addSuperscript(to: &$0) }
    }

    /// Subscripts a subrange.
    ///
    /// - Parameters:
    ///     - range: The range to subscript.
    public func `subscript`(_ range: NSRange) {
        applyUniformChanges(to: range) { NSAttributedString.addSubscript(to: &$0) }
    }

    /// Resets the baseline of a subrange.
    ///
    /// - Parameters:
    ///     - range: The range to reset.
    public func resetBaseline(for range: NSRange) {
        applyUniformChanges(to: range) { NSAttributedString.resetBaseline(for: &$0) }
    }
    #endif

    #if canImport(AppKit)
    // MARK: - Case

    private static var smallCapsSizeReduction: [String: [Int: Int]] = [:]
    private static func smallCapsMetrics(for font: Font, baseSize: Int) -> Int {
        return cached(in: &smallCapsSizeReduction[font.fontName, default: [:]][baseSize]) {
            return findLocalMinimum(near: baseSize) { (attemptedFontSize: Int) -> CGFloat in
                let attemptedFont = font.resized(to: Double(attemptedFontSize))
                return |(font.native.xHeight − attemptedFont.native.capHeight)|
            }
        }
    }

    /// Resets casing.
    ///
    /// - Parameters:
    ///     - range: The range to reset.
    public func resetCasing(of range: NSRange) {
        applyUniformChanges(to: range) { ( attributes: inout [NSAttributedString.Key: Any]) in

            attributes[.glyphInfo] = nil

            if attributes[.smallCaps] as? Bool == true {
                attributes[.smallCaps] = nil

                let font = attributes.font ?? Font.default // @exempt(from: tests) Never nil.
                let actualSmallCapsSize = Int(font.native.pointSize.rounded(.toNearestOrEven))

                let baseSize = findLocalMinimum(near: actualSmallCapsSize) { (attemptedBaseSize: Int) -> Int in

                    let attemptedSmallCapsSize = NSMutableAttributedString.smallCapsMetrics(for: font, baseSize: attemptedBaseSize)

                    return |(attemptedSmallCapsSize − actualSmallCapsSize)|
                }
                attributes.font = font.resized(to: Double(baseSize))
            }
        }
    }

    private func modifyCasing(of range: NSRange, caseMapping: (String) -> String) {
        resetCasing(of: range)
        swapGlyphs(in: range, mapping: { caseMapping($0) }, additionalChangesWhenTriggered: { _ in })
    }

    private func makeSmallCaps(_ range: NSRange, caseMapping: (String) -> String) {
        resetCasing(of: range)
        swapGlyphs(in: range, mapping: { caseMapping($0) }, additionalChangesWhenTriggered: { (attributes: inout [NSAttributedString.Key: Any]) in

            attributes[.smallCaps] = true

            let font = attributes.font ?? Font.default
            let smallCapsSize = NSMutableAttributedString.smallCapsMetrics(for: font, baseSize: Int(font.native.pointSize.rounded(.toNearestOrEven)))

            attributes.font = font.resized(to: Double(smallCapsSize))
        })
    }

    private static func turkicUpperCase(_ string: String) -> String {
        var string = string
        string.scalars.replaceMatches(for: "ı".scalars, with: "I".scalars)
        string.scalars.replaceMatches(for: "i\u{302}".scalars, with: "Î".scalars)
        string.scalars.replaceMatches(for: "\u{EE}".scalars, with: "Î".scalars)
        string.scalars.replaceMatches(for: "i".scalars, with: "İ".scalars)
        return string.uppercased()
    }

    /// Switches to a Latinate upper case font.
    ///
    /// - Parameters:
    ///     - range: The range to switch to upper case.
    public func makeLatinateUpperCase(_ range: NSRange) {
        modifyCasing(of: range, caseMapping: { $0.uppercased() })
    }
    /// Switches to a Turkic upper case font.
    ///
    /// - Parameters:
    ///     - range: The range to switch to upper case.
    public func makeTurkicUpperCase(_ range: NSRange) {
        modifyCasing(of: range, caseMapping: { NSMutableAttributedString.turkicUpperCase($0) })
    }

    /// Switches to a Latinate small caps font.
    ///
    /// - Parameters:
    ///     - range: The range to switch to small caps.
    public func makeLatinateSmallCaps(_ range: NSRange) {
        makeSmallCaps(range, caseMapping: { $0.uppercased() })
    }
    /// Switches to a Turkic small caps font.
    ///
    /// - Parameters:
    ///     - range: The range to switch to small caps.
    public func makeTurkicSmallCaps(_ range: NSRange) {
        makeSmallCaps(range, caseMapping: { NSMutableAttributedString.turkicUpperCase($0) })
    }

    /// Switches to a Latinate lower case font.
    ///
    /// - Parameters:
    ///     - range: The range to switch to lower case.
    public func makeLatinateLowerCase(_ range: NSRange) {
        modifyCasing(of: range, caseMapping: {
            var string = $0
            string.scalars.replaceMatches(for: "I\u{307}".scalars, with: "i".scalars)
            return string.lowercased()
        })
    }
    /// Switches to a Turkic lower case font.
    ///
    /// - Parameters:
    ///     - range: The range to switch to lower case.
    public func makeTurkicLowerCase(_ range: NSRange) {
        modifyCasing(of: range, caseMapping: {
            var string = $0
            string.scalars.replaceMatches(for: "I\u{307}".scalars, with: "i".scalars)
            string.scalars.replaceMatches(for: "\u{130}".scalars, with: "i".scalars)
            string.scalars.replaceMatches(for: "I\u{302}".scalars, with: "î".scalars)
            string.scalars.replaceMatches(for: "\u{CE}".scalars, with: "î".scalars)
            string.scalars.replaceMatches(for: "I".scalars, with: "ı".scalars)
            return string.lowercased()
        })
    }
    #endif
}
