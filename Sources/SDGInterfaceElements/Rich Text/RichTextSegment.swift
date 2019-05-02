/*
 RichTextSegment.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic

extension RichText {

    @usableFromInline internal struct Segment : Equatable, Hashable {

        // MARK: - Initialization

        @usableFromInline internal init(rawText: StrictString, attributes: [NSAttributedString.Key: Any] = [:]) {
            self.rawText = rawText
            self.attributes = attributes
        }

        // MARK: - Properties

        @usableFromInline internal var rawText: StrictString
        @usableFromInline internal var attributes: [NSAttributedString.Key: Any]

        private var attributesProxy: NSAttributedString {
            return NSAttributedString(string: " ", attributes: attributes)
        }

        // MARK: - Attributes

        internal func attributesEqual(_ other: Segment) -> Bool {
            return attributesProxy == other.attributesProxy
        }

        // MARK: - Equatable

        @usableFromInline internal static func == (precedingValue: Segment, followingValue: Segment) -> Bool {
            return precedingValue.rawText == followingValue.rawText ∧ precedingValue.attributesEqual(followingValue)
        }

        // MARK: - Hashable

        @usableFromInline internal func hash(into hasher: inout Hasher) {
            hasher.combine(rawText)
            hasher.combine(attributesProxy)
        }
    }
}
