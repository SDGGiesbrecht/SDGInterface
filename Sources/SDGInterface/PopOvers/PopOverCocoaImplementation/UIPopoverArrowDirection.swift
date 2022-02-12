/*
 UIPopoverArrowDirection.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit) && !os(watchOS)
  import UIKit

  extension UIPopoverArrowDirection {

    /// Creates a UIKit arrow direction from an edge.
    ///
    /// - Parameters:
    ///   - edge: The edge.
    public init(_ edge: Edge) {
      switch edge {
      case .top:
        self = .down
      case .leading:
        self = .right
      case .trailing:
        self = .left
      case .bottom:
        self = .up
      }
    }
  }
#endif
