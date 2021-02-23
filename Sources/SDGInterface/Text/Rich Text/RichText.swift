/*
 RichText.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(SwiftUI)
  import SwiftUI
#endif
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
import SDGLocalization

import SDGInterfaceLocalizations

/// Rich text.
///
/// Rich text is built on `StrictString` and maintains normalization form NFKD, except where canonical reordering would cause scalars to cross attribute boundaries.
public struct RichText: Addable, CustomPlaygroundDisplayConvertible, CustomStringConvertible,
  BidirectionalCollection, Equatable, ExpressibleByStringInterpolation,
  ExpressibleByStringLiteral,
  Hashable, RangeReplaceableCollection
{

  // MARK: - Initialization

  /// Creates rich text from raw text.
  ///
  /// - Parameters:
  ///     - rawText: The raw text.
  ///     - attributes: The rich text attributes.
  public init(rawText: StrictString, attributes: [NSAttributedString.Key: Any] = [:]) {
    let segments: [Segment] =
      rawText.isEmpty
      ? [] : [Segment(rawText: rawText, attributes: attributes)]
    self.init(unsafeSegments: segments)
  }

  #if canImport(AppKit) || canImport(UIKit)
    /// Creates rich text from semantic markup.
    ///
    /// - Parameters:
    ///     - semanticMarkup: The semantic markup.
    ///     - attributes: The rich text attributes.
    public init(semanticMarkup: SemanticMarkup, attributes: [NSAttributedString.Key: Any] = [:]) {
      let font = attributes.font ?? Font.default
      self.init(semanticMarkup.richText(font: font))
    }
  #endif

  private init(segments: [Segment]) {
    self.segments = segments
  }

  private init(unsafeSegments: [Segment]) {
    _segments = unsafeSegments
  }

  /// Creates rich text from an attributed string.
  public init(_ attributedString: NSAttributedString) {
    var index = 0
    var segments: [Segment] = []
    while index < attributedString.length {

      var range = NSRange()
      let attributes = attributedString.attributes(at: index, effectiveRange: &range)
      let actualRange = NSRange(index..<range.upperBound)
      let existingSegment = attributedString.attributedSubstring(from: actualRange).string

      var segmentString = ""
      for element in existingSegment.scalars {

        if let format = RichText.NormalizationAttribute.mapping[element] {

          segments.append(Segment(rawText: StrictString(segmentString), attributes: attributes))
          segmentString = ""

          var modified = attributes
          switch format {
          case .superscript:
            #if canImport(AppKit) || canImport(UIKit)
              NSAttributedString.addSuperscript(to: &modified)
            #else
              break
            #endif
          case .subscript:
            #if canImport(AppKit) || canImport(UIKit)
              NSAttributedString.addSubscript(to: &modified)
            #else
              break
            #endif
          }
          segments.append(Segment(rawText: StrictString(element), attributes: modified))

        } else {
          segmentString.scalars.append(element)
        }
      }
      segments.append(Segment(rawText: StrictString(segmentString), attributes: attributes))

      index = range.upperBound
    }
    self.segments = segments
  }

  // MARK: - Properties

  private var _segments: [Segment] = []
  private var segments: [Segment] {
    get {
      return _segments
    }
    set {
      // #workaround(Swift 5.3.2, Declaration may not be in a Comdat!)
      #if !os(Windows)
        cache = Cache()
      #endif
      var new: [Segment] = []
      for segment in newValue where ¬segment.rawText.isEmpty {  // Ignore empty segments.
        if let previous = new.last {
          if previous
            .attributesEqual(segment)
          {  // @exempt(from: tests) Linux unreliable.
            // Matches previous, so combine.

            new.removeLast()
            let replacement = Segment(
              rawText: previous.rawText + segment.rawText,
              attributes: segment.attributes
            )
            new.append(replacement)

          } else {
            // Differs from previous
            new.append(segment)
          }
        } else {
          // First
          new.append(segment)
        }
      }
      _segments = new
    }
  }

  // #workaround(Swift 5.3.2, Declaration may not be in a Comdat!)
  #if !os(Windows)
    private class Cache {
      fileprivate init() {}
      fileprivate var rawText: StrictString?
      fileprivate var scalars: String.UnicodeScalarView?
      fileprivate var attributedString: NSAttributedString?
    }
    private var cache = Cache()
  #endif

  // Computed

  /// Returns the raw text version of the text.
  ///
  /// Raw text offsets may not match rich text offsets because normalization can cause scalars to cross over where attribute boundaries had been. The `scalars` property is provided for when matching offsets are necessary.
  public func rawText() -> StrictString {
    let closure: () -> StrictString = {
      var string: StrictString = ""
      for segment in self.segments {
        string.append(contentsOf: segment.rawText)
      }
      return string
    }
    // #workaround(Swift 5.3.2, Declaration may not be in a Comdat!)
    #if os(Windows)
      return closure()
    #else
      return cached(in: &cache.rawText, closure)
    #endif
  }

  /// Returns the text as a sequence of raw text Unicode scalars.
  ///
  /// Offsets are guaranteed to match those of the rich string because no normalization is performed that would cause scalars to cross attribute boundaries.
  public func scalars() -> String.UnicodeScalarView {
    let closure: () -> String.UnicodeScalarView = {
      var string = String.UnicodeScalarView()
      for segment in self.segments {
        string.append(contentsOf: segment.rawText.scalars)
      }
      return string
    }
    // #workaround(Swift 5.3.2, Declaration may not be in a Comdat!)
    #if os(Windows)
      return closure()
    #else
      return cached(in: &cache.scalars, closure)
    #endif
  }

  internal func attributedString() -> NSAttributedString {
    let closure: () -> NSAttributedString = {
      let mutable = NSMutableAttributedString(string: "")
      for segment in self.segments {
        mutable.append(
          NSAttributedString(string: String(segment.rawText), attributes: segment.attributes)
        )
      }
      return mutable.copy() as! NSAttributedString
    }
    // #workaround(Swift 5.3.2, Declaration may not be in a Comdat!)
    #if os(Windows)
      return closure()
    #else
      return cached(in: &cache.attributedString, closure)
    #endif
  }

  // MARK: - Attributes

  #if canImport(AppKit) || canImport(UIKit)
    internal mutating func set<R>(
      attribute key: NSAttributedString.Key,
      to value: Any?,
      forRange range: R
    ) where R: RangeExpression, R.Bound == Index {
      var changedSegments: [Segment] = []
      for segment in RichText(self[range]).segments {
        var copy = segment
        copy.attributes[key] = value
        changedSegments.append(copy)
      }
      replaceSubrange(range, with: RichText(segments: changedSegments))
    }

    /// Superscripts the entire string.
    public mutating func superscript() {
      segments = segments.map { segment in
        var mutable = segment
        NSAttributedString.addSuperscript(to: &mutable.attributes)
        return mutable
      }
    }

    /// Superscripts a particular range.
    ///
    /// - Parameters:
    ///     - range: The range.
    public mutating func superscript<R>(range: R) where R: RangeExpression, R.Bound == Index {
      var change = RichText(self[range])
      change.superscript()
      replaceSubrange(range, with: change)
    }

    /// Subscripts the entire string.
    public mutating func `subscript`() {
      segments = segments.map { segment in
        var mutable = segment
        NSAttributedString.addSubscript(to: &mutable.attributes)
        return mutable
      }
    }

    /// Subscripts a particular range.
    ///
    /// - Parameters:
    ///     - range: The range.
    public mutating func `subscript`<R>(range: R) where R: RangeExpression, R.Bound == Index {
      var change = RichText(self[range])
      change.`subscript`()
      replaceSubrange(range, with: change)
    }

    /// Sets the font for the entire string.
    ///
    /// - Parameters:
    ///     - font: The font.
    public mutating func set(font: SDGText.Font?) {
      set(font: font, forRange: bounds)
    }
    /// Sets the font for a particular range.
    ///
    /// - Parameters:
    ///     - font: The font.
    ///     - range: The range.
    public mutating func set<R>(font: SDGText.Font?, forRange range: R)
    where R: RangeExpression, R.Bound == Index {
      #if canImport(AppKit)
        let native: NSFont? = font.flatMap({ NSFont.from($0) })
      #elseif canImport(UIKit)
        let native: UIFont? = font.flatMap({ UIFont.from($0) })
      #else
        native = font  // No platform recognition anyway.
      #endif
      set(attribute: NSAttributedString.Key.font, to: native, forRange: range)
    }

    /// Italicizes the entire string.
    public mutating func italicize() {
      segments = segments.map { segment in
        var mutable = segment
        mutable.attributes.font = mutable.attributes.font?.italic
        return mutable
      }
    }
    /// Italicizes a particular range.
    ///
    /// - Parameters:
    ///     - range: The range.
    public mutating func italicize<R>(range: R)
    where R: RangeExpression, R.Bound == Index {
      var change = RichText(self[range])
      change.italicize()
      replaceSubrange(range, with: change)
    }

    /// Emboldens the entire string.
    public mutating func embolden() {
      segments = segments.map { segment in
        var mutable = segment
        mutable.attributes.font = mutable.attributes.font?.bold
        return mutable
      }
    }
    /// Emboldens a particular range.
    ///
    /// - Parameters:
    ///     - range: The range.
    public mutating func embolden<R>(range: R)
    where R: RangeExpression, R.Bound == Index {
      var change = RichText(self[range])
      change.embolden()
      replaceSubrange(range, with: change)
    }

    /// Sets the font colour for the entire string.
    ///
    /// - Parameters:
    ///     - colour: The colour.
    public mutating func set(colour: Colour?) {
      set(colour: colour, forRange: bounds)
    }
    /// Sets the font colour for a particular range.
    ///
    /// - Parameters:
    ///     - colour: The colour.
    /// 	- range: The range.
    public mutating func set<R>(colour: Colour?, forRange range: R)
    where R: RangeExpression, R.Bound == Index {
      set(attribute: NSAttributedString.Key.foregroundColor, to: colour, forRange: range)
    }

    /// Sets the paragraph style for the entire string.
    ///
    /// - Parameters:
    ///     - paragraphStyle: The paragraph style.
    public mutating func set(paragraphStyle: NSParagraphStyle?) {
      set(paragraphStyle: paragraphStyle, forRange: bounds)
    }
    /// Sets the paragraph style for a particular range.
    ///
    /// - Parameters:
    ///     - paragraphStyle: The paragraph style.
    ///     - range: The range.
    public mutating func set<R>(paragraphStyle: NSParagraphStyle?, forRange range: R)
    where R: RangeExpression, R.Bound == Index {
      set(attribute: NSAttributedString.Key.paragraphStyle, to: paragraphStyle, forRange: range)
    }
  #endif

  // MARK: - BidirectionalCollection

  public func index(before i: RichText.Index) -> RichText.Index {
    func endOfPrevious() -> Index {
      let previousSegment = segments.index(before: i.segment)
      let previous = segments[previousSegment].rawText
      return Index(segment: previousSegment, scalar: previous.index(before: previous.endIndex))
    }
    if i == endIndex {
      return endOfPrevious()
    } else {
      let segment = segments[i.segment]
      if i.scalar == segment.rawText.startIndex {
        return endOfPrevious()
      } else {
        return Index(segment: i.segment, scalar: segment.rawText.index(before: i.scalar))
      }
    }
  }

  // MARK: - Collection

  public var startIndex: Index {
    return Index(
      segment: segments.startIndex,
      scalar: segments.first?.rawText.startIndex ?? "".scalars.endIndex
    )
  }

  public var endIndex: Index {
    return Index(segment: segments.endIndex, scalar: "".scalars.endIndex)
  }

  public func index(after i: Index) -> Index {
    let segment = segments[i.segment]
    let nextScalar = segment.rawText.index(after: i.scalar)
    if nextScalar == segment.rawText.endIndex {
      let nextSegment = segments.index(after: i.segment)
      if nextSegment == segments.endIndex {
        return endIndex
      } else {
        return Index(segment: nextSegment, scalar: segments[nextSegment].rawText.startIndex)
      }
    } else {
      return Index(segment: i.segment, scalar: nextScalar)
    }
  }

  public subscript(position: Index) -> Scalar {
    let segment = segments[position.segment]
    let scalar = segment.rawText.scalars[position.scalar]
    return Scalar(scalar, attributes: segment.attributes)
  }

  // MARK: - CustomPlaygroundDisplayConvertible

  public var playgroundDescription: Any {
    return attributedString()
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return String(rawText())
  }

  // MARK: - Equatable

  public static func == (precedingValue: RichText, followingValue: RichText) -> Bool {
    return precedingValue.segments == followingValue.segments
  }

  // MARK: - ExpressiblyByStringInterpolation

  public init(stringInterpolation: SemanticMarkup.StringInterpolation) {
    #if canImport(AppKit) || canImport(UIKit)
      self.init(semanticMarkup: stringInterpolation.semanticMarkup)
    #else
      self.init(rawText: stringInterpolation.semanticMarkup.rawTextApproximation())
    #endif
  }

  // MARK: - ExpressibleByStringLiteral

  public init(stringLiteral value: String) {
    self.init(rawText: StrictString(value))
  }

  // MARK: - Hashable

  public func hash(into hasher: inout Hasher) {
    hasher.combine(segments)
  }

  // MARK: - RangeReplaceableCollection

  public init() {}

  public init<S>(_ elements: S) where S: Sequence, S.Element == RichText.Scalar {
    if let rich = elements as? RichText {
      self = rich
    } else if let slice = elements as? RichText.SubSequence {
      var segments: [Segment] = []
      for segmentIndex in slice.base.segments.indices {
        if segmentIndex > slice.startIndex.segment {
          if segmentIndex < slice.endIndex.segment {
            // Between
            segments.append(slice.base.segments[segmentIndex])
          } else if segmentIndex == slice.endIndex.segment {
            // Same segment as end.
            let segment = slice.base.segments[segmentIndex]
            let rawSlice = segment.rawText[..<slice.endIndex.scalar]
            segments.append(
              Segment(rawText: StrictString(rawSlice), attributes: segment.attributes)
            )
          }
        } else if segmentIndex == slice.startIndex.segment {
          if segmentIndex < slice.endIndex.segment {
            // Same segment as start.
            let segment = slice.base.segments[segmentIndex]
            let rawSlice = segment.rawText[slice.startIndex.scalar...]
            segments.append(
              Segment(rawText: StrictString(rawSlice), attributes: segment.attributes)
            )
          } else if segmentIndex == slice.endIndex.segment {
            // Same segment as both start and end.
            let segment = slice.base.segments[segmentIndex]
            let rawSlice = segment.rawText[slice.startIndex.scalar..<slice.endIndex.scalar]
            segments.append(
              Segment(rawText: StrictString(rawSlice), attributes: segment.attributes)
            )
          }
        }
      }
      self.segments = segments
    } else {
      segments = elements.map {
        Segment(rawText: StrictString($0.rawScalar), attributes: $0.attributes)
      }
    }
  }

  private static func concatenateRichText(_ first: RichText, _ second: RichText) -> RichText {
    if first.isEmpty {
      return second
    } else if second.isEmpty {
      return first
    } else {
      var firstSegments = first.segments
      var secondSegments = second.segments

      let preceding = firstSegments.removeLast()
      let next = secondSegments.removeFirst()
      let nearbySegments = RichText(segments: [preceding, next]).segments

      return RichText(unsafeSegments: firstSegments + nearbySegments + secondSegments)
    }
  }

  public mutating func append<S>(contentsOf newElements: S)
  where S: Sequence, S.Element == RichText.Scalar {
    self = RichText.concatenateRichText(self, RichText(newElements))
  }

  public mutating func insert<S>(contentsOf newElements: S, at i: Index)
  where S: Sequence, S.Element == RichText.Scalar {
    replaceSubrange(i..<i, with: newElements)
  }

  public mutating func replaceSubrange<S>(_ subrange: Range<RichText.Index>, with newElements: S)
  where S: Sequence, S.Element == RichText.Scalar {
    let preceding = RichText(self[..<subrange.lowerBound])
    let following = RichText(self[subrange.upperBound...])
    var result = RichText.concatenateRichText(preceding, RichText(newElements))
    result = RichText.concatenateRichText(result, following)
    self = result
  }
}

#if canImport(SwiftUI) && !(os(iOS) && arch(arm)) && !os(watchOS)
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct RichTextPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      func preview(
        text: UserFacing<StrictString, InterfaceLocalization>,
        transformation transform: @escaping (NSMutableAttributedString) -> Void
      ) -> some SwiftUI.View {
        return previewBothModes(
          TextView(
            contents: UserFacing<RichText, InterfaceLocalization>({ localization in
              let text: StrictString = text.resolved()
              var rich = RichText(rawText: text)
              rich.set(font: Font.forLabels.resized(to: 32))
              let attributed = NSMutableAttributedString(rich)
              transform(attributed)
              return RichText(attributed)
            })
          ).adjustForLegacyMode()
            .frame(
              width: 250,
              height: /*@START_MENU_TOKEN@*/ 100 /*@END_MENU_TOKEN@*/,
              alignment: /*@START_MENU_TOKEN@*/ .center /*@END_MENU_TOKEN@*/
            ),
          name: String(text.resolved())
        )
      }

      return Group {

        preview(
          text: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Upper Case"
            case .deutschDeutschland:
              return "Großbuchstaben"
            }
          }),
          transformation: { attributed in
            attributed.makeUpperCase(NSRange(location: 0, length: attributed.length))
          }
        )
        preview(
          text: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Small Upper Case"
            case .deutschDeutschland:
              return "Kapitälchen"
            }
          }),
          transformation: { attributed in
            attributed.makeSmallCaps(NSRange(location: 0, length: attributed.length))
          }
        )
        preview(
          text: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Lower Case"
            case .deutschDeutschland:
              return "Kleinbuchstaben"
            }
          }),
          transformation: { attributed in
            attributed.makeLowerCase(NSRange(location: 0, length: attributed.length))
          }
        )
      }
    }
  }
#endif
