/*
 Point.swift

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

import SDGGeometry

/// A point.
public typealias Point = TwoDimensionalPoint<Double>

extension Point {

  // MARK: - Initialization

  #if canImport(CoreGraphics)
    /// Creates a size from a CoreGraphics point.
    ///
    /// - Parameters:
    ///     - coreGraphics: The CoreGraphics point.
    public init(_ coreGraphics: CGPoint) {
      self.init(Double(coreGraphics.x), Double(coreGraphics.y))
    }
  #endif

  // MARK: - Properties

  #if canImport(CoreGraphics)
    /// The CoreGraphics point.
    public var coreGraphics: CGPoint {
      return CGPoint(x: CGFloat(x), y: CGFloat(y))
    }
  #endif
}
