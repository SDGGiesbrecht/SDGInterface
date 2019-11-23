/*
 Rectangle.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
    /// Creates a rectangle from a native rectangle.
    ///
    /// - Parameters:
    ///     - native: The native rectangle.
    public init(_ native: CGRect) {
      origin = Point(native.origin)
      size = Size(native.size)
    }
  #endif

  // MARK: - Properties

  /// The origin.
  public var origin: Point

  /// The size.
  public var size: Size

  #if canImport(CoreGraphics)
    /// The native rectangle.
    public var native: CGRect {
      return CGRect(origin: origin.native, size: size.native)
    }
  #endif
}
