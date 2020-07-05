/*
 Point.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(CoreGraphics)
  import CoreGraphics
#endif

import SDGGeometry

/// A point.
public typealias Point = TwoDimensionalPoint<Double>

extension Point {

  // MARK: - Initialization

  #if canImport(CoreGraphics)
    /// Creates a point from a CoreGraphics point.
    ///
    /// - Parameters:
    ///     - point: The CoreGraphics point.
    public init(_ point: CGPoint) {
      self.init(Double(point.x), Double(point.y))
    }
  #endif
}
