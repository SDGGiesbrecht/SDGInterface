/*
 RichTextScalar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.2, Web doesn’t have Foundation yet.)
#if !os(WASI)
  import Foundation

  extension RichText {

    /// A single Unicode scalar of rich text.
    public struct Scalar {

      // MARK: - Initialization

      /// Creates a rich text scalar.
      ///
      /// - Parameters:
      ///     - rawScalar: The raw Unicode scalar.
      ///     - attributes: The rich text attributes.
      public init(_ rawScalar: Unicode.Scalar, attributes: [NSAttributedString.Key: Any] = [:]) {
        self.rawScalar = rawScalar
        self.attributes = attributes
      }

      // MARK: - Properties

      /// The raw text scalar.
      public var rawScalar: Unicode.Scalar
      /// The attributes applied to the scalar.
      public var attributes: [NSAttributedString.Key: Any]
    }
  }
#endif
