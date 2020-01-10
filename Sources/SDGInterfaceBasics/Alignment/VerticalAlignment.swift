/*
 VerticalAlignment.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI
#endif

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
  extension SwiftUI.VerticalAlignment {

    /// Unwraps an instance of a shimmed `SDGInterfaceBasics.VerticalAlignment`.
    ///
    /// - Parameters:
    ///   - shimmed: The shimmed instance.
    public init(_ shimmed: SDGInterfaceBasics.VerticalAlignment) {
      switch shimmed {
      case .top:
        self = .top
      case .centre:
        self = .center
      case .bottom:
        self = .bottom
      }
    }
  }
#endif

/// A shimmed version of `SwiftUI.VerticalAlignment` with no availability constraints.
public enum VerticalAlignment: Equatable {

  // MARK: - Cases

  /// A shimmed version of `SwiftUI.VerticalAlignment.top` with no availability constraints.
  case top
  /// A shimmed version of `SwiftUI.VerticalAlignment.center` with no availability constraints.
  case centre
  /// A shimmed version of `SwiftUI.VerticalAlignment.bottom` with no availability constraints.
  case bottom

  // MARK: - Initialization

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    /// Wraps an instance of a standard `SwiftUI.VerticalAlignment`.
    ///
    /// - Parameters:
    ///   - standard: The standard instance.
    @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
    public init?(_ standard: SwiftUI.VerticalAlignment) {
      switch standard {
      case .top:
        self = .top
      case .center:
        self = .centre
      case .bottom:
        self = .bottom
      default:  // @exempt(from: tests) Not sure how to create such an alignment.
        // @exempt(from: tests)
        return nil
      }
    }
  #endif
}
