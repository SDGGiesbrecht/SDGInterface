/*
 CGRect.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)
  import CoreGraphics

  extension CGRect {

    /// Creates a CoreGraphics rectangle from a rectangle.
    ///
    /// - Parameters:
    ///   - rectangle: The rectangle.
    public init(_ rectangle: SDGInterface.Rectangle) {
      self.init(origin: CGPoint(rectangle.origin), size: CGSize(rectangle.size))
    }
  }
#endif
