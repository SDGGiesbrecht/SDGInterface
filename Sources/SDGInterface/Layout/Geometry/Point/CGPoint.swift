/*
 CGPoint.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)
  import CoreGraphics

  extension CGPoint {

    /// Creates a CoreGraphics point from a point.
    ///
    /// - Parameters:
    ///   - point: The point.
    public init(_ point: SDGInterface.Point) {
      self.init(x: point.x, y: point.y)
    }
  }
#endif
