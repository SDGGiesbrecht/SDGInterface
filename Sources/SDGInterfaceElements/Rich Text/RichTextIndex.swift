/*
 RichTextIndex.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension RichText {

    public struct Index : Comparable {

        // MARK: - Initialization

        internal init(segment: Array<Segment>.Index, scalar: StrictString.Index) {
            self.segment = segment
            self.scalar = scalar
        }

        // MARK: - Properties

        private var segment: Array<Segment>.Index
        private var scalar: StrictString.Index

        // MARK: - Comparable

        public static func < (precedingValue: Index, followingValue: Index) -> Bool {
            return (precedingValue.segment, precedingValue.scalar) < (followingValue.segment, followingValue.scalar)
        }
    }
}
