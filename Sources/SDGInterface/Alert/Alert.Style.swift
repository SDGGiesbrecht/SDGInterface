/*
 Alert.Style.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit
#endif

extension Alert {

  /// A style of alert.
  public enum Style {

    // MARK: - Cases

    /// The default style.
    case critical

    /// The warning style.
    case warning

    /// The informational style.
    case informational

    // MARK: - AppKit

    #if canImport(AppKit)
      public func cocoa() -> NSAlert.Style {
        switch self {
        case .critical:
          return .critical
        case .warning:
          return .warning
        case .informational:
          return .informational
        }
      }
    #endif
  }
}
