/*
 HorizontalAlignment.swift

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
  extension SwiftUI.HorizontalAlignment {

    /// Unwraps an instance of a shimmed `SDGInterfaceBasics.HorizontalAlignment`.
    ///
    /// - Parameters:
    ///   - shimmed: The shimmed instance.
    public init(_ shimmed: SDGInterfaceBasics.HorizontalAlignment) {
      switch shimmed {
      case .leading:
        self = .leading
      case .centre:
        self = .center
      case .trailing:
        self = .trailing
      }
    }
  }
#endif

/// A shimmed version of `SwiftUI.HorizontalAlignment` with no availability constraints.
public enum HorizontalAlignment: Equatable {

  // MARK: - Cases

  /// A shimmed version of `SwiftUI.HorizontalAlignment.leading` with no availability constraints.
  case leading
  /// A shimmed version of `SwiftUI.HorizontalAlignment.center` with no availability constraints.
  case centre
  /// A shimmed version of `SwiftUI.HorizontalAlignment.trailing` with no availability constraints.
  case trailing

  // MARK: - Initialization

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    /// Wraps an instance of a standard `SwiftUI.HorizontalAlignment`.
    ///
    /// - Parameters:
    ///   - standard: The standard instance.
    @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
    public init?(_ standard: SwiftUI.HorizontalAlignment) {
      switch standard {
      case .leading:
        self = .leading
      case .center:
        self = .centre
      case .trailing:
        self = .trailing
      default:  // @exempt(from: tests) Not sure how to create such an alignment.
        // @exempt(from: tests)
        return nil
      }
    }
  #endif
}
