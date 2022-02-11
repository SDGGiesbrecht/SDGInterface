/*
 ContentMode.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI
#endif

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension SwiftUI.ContentMode {

    /// Unwraps an instance of a shimmed `SDGInterface.ContentMode`.
    ///
    /// - Parameters:
    ///   - shimmed: The shimmed instance.
    public init(_ shimmed: SDGInterface.ContentMode) {
      switch shimmed {
      case .fill:
        self = .fill
      case .fit:
        self = .fit
      }
    }
  }
#endif

/// A shimmed version of `SwiftUI.ContentMode` with no availability constraints.
public enum ContentMode: CaseIterable {

  // MARK: - Cases

  /// A shimmed version of `SwiftUI.ContentMode.fill` with no availability constraints.
  case fill

  /// A shimmed version of `SwiftUI.ContentMode.fit` with no availability constraints.
  case fit

  // MARK: - Initialization

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    /// Wraps an instance of a standard `SwiftUI.ContentMode`.
    ///
    /// - Parameters:
    ///   - standard: The standard instance.
    @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
    public init(_ standard: SwiftUI.ContentMode) {
      switch standard {
      case .fill:
        self = .fill
      case .fit:
        self = .fit
      }
    }
  #endif
}
