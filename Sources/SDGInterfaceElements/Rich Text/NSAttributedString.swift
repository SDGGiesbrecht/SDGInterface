/*
 NSAttributedString.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGText

extension NSAttributedString.Key {
    internal static let smallCaps = NSAttributedString.Key(rawValue: "SDGSmallCaps")
}

extension NSAttributedString : Comparable {

    // MARK: - Initialization

    /// Creates an attributed string from rich text.
    public convenience init(_ richText: RichText) {
        self.init(attributedString: richText.attributedString())
    }

    // MARK: - Superscript & Subscript

    private static var superscriptSizeReduction: [String: [Int: (size: Int, lineHeight: Int)]] = [:]
    private static func superscriptMetrics(for font: Font) -> (size: Int, lineHeight: Int) {
        return cached(in: &superscriptSizeReduction[font.fontName, default: [:]][Int(font.pointSize)]) { () -> (size: Int, lineHeight: Int) in

            let superscripted = SemanticMarkup("_").superscripted().richText(font: font)
            let newAttributes = superscripted.attributes(at: 0, effectiveRange: nil)

            let superscriptFont = newAttributes[NSAttributedString.Key.font] as! Font
            let paragraphStyle = newAttributes[NSAttributedString.Key.paragraphStyle] as! NSParagraphStyle
            return (Int(superscriptFont.pointSize), Int(paragraphStyle.minimumLineHeight))
        }
    }

    private static func reduceSizeForSuperscript(_ attributes: inout [NSAttributedString.Key: Any]) {
        var font = attributes[NSAttributedString.Key.font] as? Font ?? Font.default
        let paragraphStyle = (attributes[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle ?? NSParagraphStyle.default).mutableCopy() as! NSMutableParagraphStyle

        let newSizes = superscriptMetrics(for: font)

        font = font.resized(to: CGFloat(newSizes.size))
        paragraphStyle.minimumLineHeight = CGFloat(newSizes.lineHeight)

        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle.copy()
    }

    internal static func addSuperscript(to attributes: inout [NSAttributedString.Key: Any]) {
        reduceSizeForSuperscript(&attributes)

        var baseline = attributes[NSAttributedString.Key.superscript] as? Int ?? 0
        baseline += 1
        attributes[NSAttributedString.Key.superscript] = baseline
    }

    internal static func addSubscript(to attributes: inout [NSAttributedString.Key: Any]) {
        reduceSizeForSuperscript(&attributes)

        var baseline = attributes[NSAttributedString.Key.superscript] as? Int ?? 0
        baseline −= 1
        attributes[NSAttributedString.Key.superscript] = baseline
    }

    fileprivate static func resetBaseline(for attributes: inout [NSAttributedString.Key: Any]) {
        let level = |(attributes[NSAttributedString.Key.superscript] as? Int ?? 0)|
        var font = attributes[NSAttributedString.Key.font] as? Font ?? Font.default
        let superscriptSize = Int(font.pointSize)
        let paragraphStyle = (attributes[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle ?? NSParagraphStyle.default).mutableCopy() as! NSMutableParagraphStyle
        let superscriptHeight = Int(paragraphStyle.minimumLineHeight)

        let baseSize = findLocalMinimum(near: Int(Font.systemSize)) { (base: Int) -> Int in
            var resultingSize = base
            for _ in 0 ..< level {
                resultingSize = superscriptMetrics(for: font.resized(to: CGFloat(resultingSize))).size
            }
            return |(resultingSize − superscriptSize)|
        }
        let baseHeight = findLocalMinimum(near: Int(Font.systemSize)) { (base: Int) -> Int in
            var resultingHeight = base
            for _ in 0 ..< level {
                resultingHeight = superscriptMetrics(for: font.resized(to: CGFloat(resultingHeight))).lineHeight
            }
            return |(resultingHeight − superscriptHeight)|
        }

        font = font.resized(to: CGFloat(baseSize))
        paragraphStyle.minimumLineHeight = CGFloat(baseHeight)

        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle.copy() as! NSParagraphStyle
        attributes[NSAttributedString.Key.superscript] = 0
    }

    // MARK: - Comparable

    public static func < (precedingValue: NSAttributedString, followingValue: NSAttributedString) -> Bool {
        let precedingRaw = precedingValue.string
        let followingRaw = followingValue.string
        if precedingRaw < followingRaw {
            return true
        } else if precedingRaw > followingRaw {
            return false
        } else {
            return precedingValue.isLessThanOrEqual(to: followingValue)
        }
    }
}

extension NSMutableAttributedString {

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

    private func swapGlyphs(in range: NSRange, mapping performMap: (String) -> String, additionalChangesWhenTriggered makeAdditionalChanges: (inout [NSAttributedString.Key: Any]) -> Void) {

        applyChanges(to: range) { (sectionRange: NSRange, sectionAttributes: [NSAttributedString.Key: Any]) in

            let section = attributedSubstring(from: sectionRange).string
            let font = sectionAttributes[NSAttributedString.Key.font] as? Font ?? Font.default

            let prototypeAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]

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
                    if let glyphInfo = NSGlyphInfo(glyph: glyph, for: font, baseString: baseString) {
                        let characterRange = NSRange(scalarStart ..< scalarEnd, in: section)
                        let charactersRangeInContext = NSRange((characterRange.lowerBound + sectionRange.lowerBound) ..< (characterRange.upperBound + sectionRange.lowerBound))
                        addAttribute(NSAttributedString.Key.glyphInfo, value: glyphInfo, range: charactersRangeInContext)

                        var mutableSelection = sectionAttributes
                        makeAdditionalChanges(&mutableSelection)
                        addAttributes(mutableSelection, range: charactersRangeInContext)
                    }
                }

                scalarStart = scalarEnd
            }
        }
    }

    // MARK: - Superscript & Subscript

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

    // MARK: - Case

    private static var smallCapsSizeReduction: [String: [Int: Int]] = [:]
    private static func smallCapsMetrics(for font: Font, baseSize: Int) -> Int {
        return cached(in: &smallCapsSizeReduction[font.fontName, default: [:]][baseSize]) {
            return findLocalMinimum(near: baseSize) { (attemptedFontSize: Int) -> CGFloat in
                let attemptedFont = font.resized(to: CGFloat(attemptedFontSize))
                return |(font.xHeight − attemptedFont.capHeight)|
            }
        }
    }

    /// Resets casing.
    ///
    /// - Parameters:
    ///     - range: The range to reset.
    public func resetCasing(of range: NSRange) {
        applyUniformChanges(to: range) { ( attributes: inout [NSAttributedString.Key: Any]) in

            attributes[NSAttributedString.Key.glyphInfo] = nil

            if attributes[NSAttributedString.Key.smallCaps] as? Bool == true {
                attributes[NSAttributedString.Key.smallCaps] = nil

                let font = attributes[NSAttributedString.Key.font] as? Font ?? Font.default
                let actualSmallCapsSize = Int(font.pointSize)

                let baseSize = findLocalMinimum(near: actualSmallCapsSize) { (attemptedBaseSize: Int) -> Int in

                    let attemptedSmallCapsSize = NSMutableAttributedString.smallCapsMetrics(for: font, baseSize: attemptedBaseSize)

                    return |(attemptedSmallCapsSize − actualSmallCapsSize)|
                }
                attributes[NSAttributedString.Key.font] = font.resized(to: CGFloat(baseSize))
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

            attributes[NSAttributedString.Key.smallCaps] = true

            let font = attributes[NSAttributedString.Key.font] as? Font ?? Font.default
            let smallCapsSize = NSMutableAttributedString.smallCapsMetrics(for: font, baseSize: Int(font.pointSize))

            attributes[NSAttributedString.Key.font] = font.resized(to: CGFloat(smallCapsSize))
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
}
