/*
 RichText.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGMathematics
import SDGText

#warning("Consider common protocols.")

/// Rich text.
///
/// Rich text is built on `StrictString` and maintains normalization form NFKD, except where canonical reordering would cause scalars to cross attribute boundaries.
public struct RichText: Addable, Comparable, Decodable, Encodable, BidirectionalCollection, Equatable, Hashable, RangeReplaceableCollection {

    // MARK: - Initialization

    /// Creates rich text from raw text.
    ///
    /// - Parameters:
    ///     - rawText: The raw text.
    ///     - attributes: The rich text attributes.
    public init(rawText: StrictString, attributes: [NSAttributedString.Key : Any] = [:]) {
        self.init(unsafeSegments: [Segment(rawText: rawText, attributes: attributes)])
    }

    @usableFromInline internal init(segments: [Segment]) {
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
            let actualRange = NSRange(index ..< range.upperBound)
            let existingSegment = attributedString.attributedSubstring(from: actualRange).string

            var segmentString = ""
            for element in existingSegment.scalars {

                if let format = RichText.NormalizationAttribute.mapping[element] {

                    segments.append(Segment(rawText: StrictString(segmentString), attributes: attributes))
                    segmentString = ""

                    var modified = attributes
                    switch format {
                    case .superscript:
                        #warning("Needs to apply superscript.")
                        //NSAttributedString.addSuperscriptToAttributes(&modified)
                    case .subscript:
                        #warning("Needs to apply subscript.")
                        //NSAttributedString.addSubscriptToAttributes(&modified)
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
    @usableFromInline internal var segments: [Segment] {
        get {
            return _segments
        }
        set {
            cache = Cache()
            var new: [Segment] = []
            for segment in newValue where ¬segment.rawText.isEmpty { // Ignore empty segments.
                if let previous = new.last {
                    if previous.attributesEqual(segment) {
                        // Matches previous, so combine.

                        new.removeLast()
                        let replacement = Segment(rawText: previous.rawText + segment.rawText, attributes: segment.attributes)
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

    private class Cache {
        fileprivate init() {}
        fileprivate var rawText: StrictString?
        fileprivate var scalars: String.UnicodeScalarView?
        fileprivate var attributedString: NSAttributedString?
    }
    private var cache = Cache()

    // Computed

    /// Returns the raw text version of the text.
    ///
    /// Raw text offsets may not match rich text offsets because normalization can cause scalars to cross over where attribute boundaries had been. The `scalars` property is provided for when matching offsets are necessary.
    public func rawText() -> StrictString {
        return cached(in: &cache.rawText) {
            var string: StrictString = ""
            for segment in segments {
                string.append(contentsOf: segment.rawText)
            }
            return string
        }
    }

    /// Returns the text as a sequence of raw text Unicode scalars.
    ///
    /// Offsets are guaranteed to match those of the rich string because no normalization is performed that would cause scalars to cross attribute boundaries.
    public func scalars() -> String.UnicodeScalarView {
        return cached(in: &cache.scalars) {
            var string = String.UnicodeScalarView()
            for segment in segments {
                string.append(contentsOf: segment.rawText.scalars)
            }
            return string
        }
    }

    internal func attributedString() -> NSAttributedString {
        return cached(in: &cache.attributedString) {
            let mutable = NSMutableAttributedString()
            for segment in segments {
                mutable.append(NSAttributedString(string: String(segment.rawText), attributes: segment.attributes))
            }
            return mutable.copy() as! NSAttributedString
        }
    }

    // MARK: - Attributes

    private func attributes(at position: Index) -> [NSAttributedString.Key: Any] {
        return self[position].attributes
    }

    private func attribute(_ key: NSAttributedString.Key, at position: Index) -> Any? {
        return attributes(at: position)[key]
    }

    @inlinable internal mutating func set<R>(attribute key: NSAttributedString.Key, to value: Any?, forRange range: R) where R : RangeExpression, R.Bound == Index {
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
            #warning("Needs to superscript.")
            //NSAttributedString.addSuperscriptToAttributes(&mutable.attributes)
            return mutable
        }
    }

    /// Superscripts a particular range.
    @inlinable public mutating func superscript<R>(range: R) where R : RangeExpression, R.Bound == Index {
        var change = RichText(self[range])
        change.superscript()
        replaceSubrange(range, with: change)
    }

    /// Subscripts the entire string.
    public mutating func `subscript`() {
        segments = segments.map { segment in
            var mutable = segment
            #warning("Needs to subscript.")
            //NSAttributedString.addSubscriptToAttributes(&mutable.attributes)
            return mutable
        }
    }

    /// Subscripts a particular range.
    @inlinable public mutating func `subscript`<R>(range: R) where R : RangeExpression, R.Bound == Index {
        var change = RichText(self[range])
        change.`subscript`()
        replaceSubrange(range, with: change)
    }

    /// Sets the font for the entire string.
    public mutating func set(font: Font) {
        set(font: font, forRange: bounds)
    }
    /// Sets the font for a particular range.
    @inlinable public mutating func set<R>(font: Font, forRange range: R) where R : RangeExpression, R.Bound == Index {
        set(attribute: NSAttributedString.Key.font, to: font, forRange: range)
    }

    /// Sets the font colour for the entire string.
    public mutating func set(colour: NSColor) {
        set(colour: colour, forRange: bounds)
    }
    /// Sets the font colour for a particular range.
    @inlinable public mutating func set<R>(colour: NSColor, forRange range: R) where R : RangeExpression, R.Bound == Index {
        set(attribute: NSAttributedString.Key.foregroundColor, to: colour, forRange: range)
    }

    /// Sets the paragraph style for the entire string.
    public mutating func set(paragraphStyle: NSParagraphStyle) {
        set(paragraphStyle: paragraphStyle, forRange: bounds)
    }
    /// Sets the paragraph style for a particular range.
    @inlinable public mutating func set<R>(paragraphStyle: NSParagraphStyle, forRange range: R) where R : RangeExpression, R.Bound == Index {
        set(attribute: NSAttributedString.Key.paragraphStyle, to: paragraphStyle, forRange: range)
    }

    // MARK: - BidirectionalCollection

    public func index(before i: RichText.Index) -> RichText.Index {
        let segment = segments[i.segment]
        if i.scalar == segment.rawText.startIndex {
            let previous = i.segment − 1
            return Index(segment: previous, scalar: segments[previous].rawText.startIndex)
        } else {
            return Index(segment: i.segment, scalar: segment.rawText.index(before: i.scalar))
        }
    }

    // MARK: - Collection

    public var startIndex: Index {
        return Index(segment: segments.startIndex, scalar: segments.first?.rawText.startIndex ?? "".scalars.endIndex)
    }

    public var endIndex: Index {
        return Index(segment: segments.endIndex, scalar: "".scalars.endIndex)
    }

    public func index(after i: Index) -> Index {
        let segment = segments[i.segment]
        if i.scalar == segment.rawText.endIndex {
            let next = i.segment + 1
            if next == segments.endIndex {
                return endIndex
            } else {
                return Index(segment: next, scalar: segments[next].rawText.startIndex)
            }
        } else {
            return Index(segment: i.segment, scalar: segment.rawText.index(after: i.scalar))
        }
    }

    public subscript(position: Index) -> Scalar {
        let segment = segments[position.segment]
        let scalar = segment.rawText.scalars[position.scalar]
        return Scalar(scalar, attributes: segment.attributes)
    }

    // MARK: - Comparable

    public static func <(precedingValue: RichText, followingValue: RichText) -> Bool {
        return precedingValue.attributedString() < followingValue.attributedString()
    }

    // MARK: - Decodable

    public init(from decoder: Decoder) throws {
        let data = try decoder.singleValueContainer().decode(Data.self)
        let attributed = try NSAttributedString(data: data, options: [:], documentAttributes: nil)
        self = RichText(attributed)
    }

    // MARK: - Encodable

    public func encode(to encoder: Encoder) throws {
        let attributed = NSAttributedString(self)
        let data = try attributed.data(from: NSRange(location: 0, length: attributed.length), documentAttributes: [:])
        var container = encoder.singleValueContainer()
        try container.encode(data)
    }

    // MARK: - Equatable

    public static func == (precedingValue: RichText, followingValue: RichText) -> Bool {
        return precedingValue.segments == followingValue.segments
    }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(segments)
    }

    // MARK: - RangeReplaceableCollection

    public init() {

    }

    @inlinable public init<S>(_ elements: S) where S : Sequence, S.Element == RichText.Scalar {
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
                        segments.append(Segment(rawText: StrictString(rawSlice), attributes: segment.attributes))
                    }
                } else if segmentIndex == slice.startIndex.segment {
                    if segmentIndex < slice.endIndex.segment {
                        // Same segment as start.
                        let segment = slice.base.segments[segmentIndex]
                        let rawSlice = segment.rawText[slice.endIndex.scalar...]
                        segments.append(Segment(rawText: StrictString(rawSlice), attributes: segment.attributes))
                    } else if segmentIndex == slice.endIndex.segment {
                        // Same segment as both start and end.
                        let segment = slice.base.segments[segmentIndex]
                        let rawSlice = segment.rawText[slice.startIndex.scalar ..< slice.endIndex.scalar]
                        segments.append(Segment(rawText: StrictString(rawSlice), attributes: segment.attributes))
                    }
                }
            }
            self.segments = segments
        } else {
            segments = elements.map { Segment(rawText: StrictString($0.rawScalar), attributes: $0.attributes) }
        }
    }

    @usableFromInline internal static func concatenateRichText(_ first: RichText, _ second: RichText) -> RichText {
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

    @inlinable public mutating func append<S>(contentsOf newElements: S) where S : Sequence, S.Element == RichText.Scalar {
        self = RichText.concatenateRichText(self, RichText(newElements))
    }

    @inlinable public mutating func insert<S>(contentsOf newElements: S, at i: Index) where S : Sequence, S.Element == RichText.Scalar {
        replaceSubrange(i ..< i, with: newElements)
    }

    @inlinable public mutating func replaceSubrange<S>(_ subrange: Range<RichText.Index>, with newElements: S) where S : Sequence, S.Element == RichText.Scalar {
        let preceding = RichText(self[..<subrange.lowerBound])
        let following = RichText(self[subrange.upperBound...])
        var result = RichText.concatenateRichText(preceding, RichText(newElements))
        result = RichText.concatenateRichText(result, following)
        self = result
    }
}
