/*
 RichTextIndex.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.2, Web doesn’t have Foundation yet.)
#if !os(WASI)
  import SDGLogic
  import SDGText

  extension RichText {

    public struct Index: Comparable {

      // MARK: - Initialization

      internal init(segment: Array<Segment>.Index, scalar: StrictString.Index) {
        self.segment = segment
        self.scalar = scalar
      }

      // MARK: - Properties

      internal var segment: Array<Segment>.Index
      internal var scalar: StrictString.Index

      // MARK: - Comparable

      public static func < (precedingValue: Index, followingValue: Index) -> Bool {
        return (precedingValue.segment, precedingValue.scalar) < (
          followingValue.segment, followingValue.scalar
        )
      }
    }
  }
#endif
