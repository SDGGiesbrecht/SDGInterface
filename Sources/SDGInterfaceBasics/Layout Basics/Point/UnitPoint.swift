/*
 UnitPoint.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension UnitPoint {

    // MARK: - Initialization

    /// Creates a SwiftUI point from a point.
    ///
    /// - Parameters:
    ///   - point: The point.
    public init(_ point: SDGInterfaceBasics.Point) {
      self.init(x: CGFloat(point.x), y: CGFloat(point.y))
    }
  }
#endif
