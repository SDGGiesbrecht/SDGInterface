/*
 NSAttributedString.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
    private static var lineHeightTable: [String: [Double: Double]] = [:]
    private static func lineHeight(for font: Font) -> Double {
      return cached(in: &lineHeightTable[font.fontName, default: [:]][font.size]) {
        let markedUp = SemanticMarkup("_").richText(
          font: font.resized(to: font.size × htmlCorrection)
        )
        let paragraph =
          markedUp.attribute(.paragraphStyle, at: 0, effectiveRange: nil)
          as! NSParagraphStyle
        return Double(paragraph.minimumLineHeight)
      }
    }

    private static func reduceSizeForSuperscript(
      _ attributes: inout [NSAttributedString.Key: Any]
    ) {
      var font = attributes.font ?? Font.default
      let paragraphStyle =
        (attributes[.paragraphStyle] as? NSParagraphStyle ?? NSParagraphStyle.default)
        .mutableCopy() as! NSMutableParagraphStyle

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
      let paragraphStyle =
        (attributes[.paragraphStyle] as? NSParagraphStyle ?? NSParagraphStyle.default)
        .mutableCopy() as! NSMutableParagraphStyle

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
    private func applyChanges(
      to range: NSRange,
      modifySection: (_ sectionRange: NSRange, _ sectionAttributes: [NSAttributedString.Key: Any])
        -> Void
    ) {
      if range.length ≠ 0 {
        var index = range.lowerBound
        while index < range.upperBound {
          var sectionRange = NSRange(location: 0, length: 0)
          let sectionAttributes = attributes(at: index, effectiveRange: &sectionRange)
          var lowerBound = sectionRange.lowerBound
          var upperBound = sectionRange.upperBound
          lowerBound.increase(to: index)
          upperBound.decrease(to: range.upperBound)
          sectionRange = NSRange(lowerBound..<upperBound)

          modifySection(sectionRange, sectionAttributes)

          index = sectionRange.upperBound
        }
      }
    }

    private func applyUniformChanges(
      to range: NSRange,
      modifySection: (inout [NSAttributedString.Key: Any]) -> Void
    ) {
      applyChanges(to: range) { sectionRange, sectionAttributes in

        var sectionAttributes = sectionAttributes
        modifySection(&sectionAttributes)
        setAttributes(sectionAttributes, range: sectionRange)
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

  #if canImport(AppKit) || canImport(UIKit)
    // MARK: - Case

    /// Resets casing.
    ///
    /// - Parameters:
    ///     - range: The range to reset.
    public func resetCasing(of range: NSRange) {
      applyUniformChanges(to: range) { (attributes: inout [NSAttributedString.Key: Any]) in
        attributes.update(fontFeatures: [
          // See makeSmallCaps(_:).
          kLowerCaseType: kDefaultLowerCaseSelector,
          kLetterCaseType: kUpperAndLowerCaseSelector,
        ])
      }
    }

    /// Switches to an upper case font.
    ///
    /// - Parameters:
    ///     - range: The range to switch to upper case.
    public func makeUpperCase(_ range: NSRange) {
      resetCasing(of: range)
      applyUniformChanges(to: range) { (attributes: inout [NSAttributedString.Key: Any]) in
        attributes.update(fontFeatures: [
          // Deprecated, but still used by some fonts.
          kLetterCaseType: kAllCapsSelector
        ])
      }
    }

    /// Switches to a small caps font.
    ///
    /// - Parameters:
    ///     - range: The range to switch to small caps.
    public func makeSmallCaps(_ range: NSRange) {
      resetCasing(of: range)
      applyUniformChanges(to: range) { (attributes: inout [NSAttributedString.Key: Any]) in
        attributes.update(fontFeatures: [
          kLowerCaseType: kLowerCaseSmallCapsSelector,
          // Deprecated, but still used by some fonts.
          kLetterCaseType: kSmallCapsSelector,
        ])
      }
    }

    /// Switches to a lower case font.
    ///
    /// - Parameters:
    ///     - range: The range to switch to lower case.
    public func makeLowerCase(_ range: NSRange) {
      resetCasing(of: range)
      applyUniformChanges(to: range) { (attributes: inout [NSAttributedString.Key: Any]) in
        attributes.update(fontFeatures: [
          // Deprecated, but still used by some fonts.
          kLetterCaseType: kAllLowerCaseSelector
        ])
      }
    }
  #endif
}
