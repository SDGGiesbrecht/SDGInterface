/*
 EdgeSet.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI
#endif

import SDGCollections

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension SwiftUI.Edge.Set {

    /// Unwraps an instance of a shimmed `SDGInterfaceBasics.Edge`.
    ///
    /// - Parameters:
    ///   - shimmed: The shimmed instance.
    public init(_ shimmed: SDGInterfaceBasics.Edge.Set) {
      self.init(rawValue: shimmed.rawValue)
    }
  }
#endif

extension Edge {

  /// A shimmed version of `SwiftUI.Edge.Set` with no availability constraints.
  public struct Set: OptionSet {

    // MARK: - Static Properties

    /// A shimmed version of `SwiftUI.Edge.Set.top` with no availability constraints.
    public static let top = Set(rawValue: 1 << 0)
    /// A shimmed version of `SwiftUI.Edge.Set.leading` with no availability constraints.
    public static let leading = Set(rawValue: 1 << 1)
    /// A shimmed version of `SwiftUI.Edge.Set.bottom` with no availability constraints.
    public static let bottom = Set(rawValue: 1 << 2)
    /// A shimmed version of `SwiftUI.Edge.Set.trailing` with no availability constraints.
    public static let trailing = Set(rawValue: 1 << 3)

    /// A shimmed version of `SwiftUI.Edge.Set.horizontal` with no availability constraints.
    public static let horizontal: Set = [.leading, .trailing]
    /// A shimmed version of `SwiftUI.Edge.Set.vertical` with no availability constraints.
    public static let vertical: Set = [.top, .bottom]

    /// A shimmed version of `SwiftUI.Edge.Set.all` with no availability constraints.
    public static let all: Set = [.horizontal, .vertical]

    // MARK: - Initialization

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      /// Wraps an instance of a standard `SwiftUI.Edge.Set`.
      ///
      /// - Parameters:
      ///   - standard: The standard instance.
      @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
      public init(_ standard: SwiftUI.Edge.Set) {
        self.init(rawValue: standard.rawValue)
      }
    #endif

    /// A shimmed version of `SwiftUI.Edge.Set.init` with no availability constraints.
    public init(_ edge: Edge) {
      switch edge {
      case .top:
        self = .top
      case .leading:
        self = .leading
      case .trailing:
        self = .trailing
      case .bottom:
        self = .bottom
      }
    }

    // MARK: - RawRepresentable

    public init(rawValue: Int8) {
      self.rawValue = rawValue
    }

    public let rawValue: Int8
  }
}
