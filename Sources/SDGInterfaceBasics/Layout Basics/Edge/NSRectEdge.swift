/*
 NSRectEdge.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  extension NSRectEdge {

    /// Creates an AppKit edge from an edge.
    ///
    /// - Parameters:
    ///   - edge: The edge.
    public init(_ edge: Edge) {
      switch edge {
      case .top:
        self = .maxY
      case .leading:
        self = .minX
      case .trailing:
        self = .minY
      case .bottom:
        self = .minY
      }
    }
  }
#endif
