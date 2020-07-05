/*
 Size.swift

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

/// A window size.
public struct Size: Equatable, Hashable {

  // MARK: - Initialization

  /// Creates a size.
  ///
  /// - Parameters:
  ///     - width: The width.
  ///     - height: The height.
  public init(width: Double, height: Double) {
    self.width = width
    self.height = height
  }

  /// Creates an empty size.
  public init() {
    width = 0
    height = 0
  }

  #if canImport(CoreGraphics)
    /// Creates a size from a CoreGraphics size.
    ///
    /// - Parameters:
    ///     - coreGraphics: The CoreGraphics size.
    public init(_ coreGraphics: CGSize) {
      self.init(width: Double(coreGraphics.width), height: Double(coreGraphics.height))
    }
  #endif

  // MARK: - Properties

  /// The width.
  public var width: Double

  /// The height.
  public var height: Double

  #if canImport(CoreGraphics)
    /// The CoreGraphics size.
    public var coreGraphics: CGSize {
      return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
  #endif
}
