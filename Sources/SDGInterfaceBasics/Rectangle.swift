/*
 Rectangle.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)
  import CoreGraphics
#endif

/// A rectangle.
public struct Rectangle {

  /// Creates a rectangle.
  ///
  /// - Parameters:
  ///     - origin: The origin.
  ///     - size: The size.
  public init(origin: Point = Point(0, 0), size: Size = Size()) {
    self.origin = origin
    self.size = size
  }

  #if canImport(CoreGraphics)
    /// Creates a rectangle from a CoreGraphics rectangle.
    ///
    /// - Parameters:
    ///     - coreGraphics: The CoreGraphics rectangle.
    public init(_ coreGraphics: CGRect) {
      origin = Point(coreGraphics.origin)
      size = Size(coreGraphics.size)
    }
  #endif

  // MARK: - Properties

  /// The origin.
  public var origin: Point

  /// The size.
  public var size: Size

  #if canImport(CoreGraphics)
    /// The CoreGraphics rectangle.
    public var coreGraphics: CGRect {
      return CGRect(origin: origin.coreGraphics, size: size.coreGraphics)
    }
  #endif
}
