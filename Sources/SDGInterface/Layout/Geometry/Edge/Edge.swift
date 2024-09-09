/*
 Edge.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

#if canImport(SwiftUI)
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension SwiftUI.Edge {

    /// Unwraps an instance of a shimmed `SDGInterface.Edge`.
    ///
    /// - Parameters:
    ///   - shimmed: The shimmed instance.
    public init(_ shimmed: SDGInterface.Edge) {
      switch shimmed {
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
  }
#endif

/// A shimmed version of `SwiftUI.Edge` with no availability constraints.
public enum Edge: CaseIterable {

  // MARK: - Cases

  /// A shimmed version of `SwiftUI.Edge.top` with no availability constraints.
  case top

  /// A shimmed version of `SwiftUI.Edge.leading` with no availability constraints.
  case leading

  /// A shimmed version of `SwiftUI.Edge.trailing` with no availability constraints.
  case trailing

  /// A shimmed version of `SwiftUI.Edge.bottom` with no availability constraints.
  case bottom

  // MARK: - Initialization

  #if canImport(SwiftUI)
    /// Wraps an instance of a standard `SwiftUI.Edge`.
    ///
    /// - Parameters:
    ///   - standard: The standard instance.
    @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
    public init(_ standard: SwiftUI.Edge) {
      switch standard {
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
  #endif
}
