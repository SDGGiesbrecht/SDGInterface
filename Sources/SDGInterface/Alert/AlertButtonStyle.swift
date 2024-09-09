/*
 AlertButtonStyle.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit)
  import UIKit
#endif

/// A style of alert button.
public enum AlertButtonStyle {

  /// The default style.
  case `default`

  /// A style indicating cancellation.
  case cancellation

  /// A style indicating a destructive action.
  case destructive

  // MARK: - Cocoa

  #if canImport(UIKit) && !os(watchOS)
    /// Constructs a Cocoa representation of the button style.
    public func cocoa() -> UIAlertAction.Style {
      switch self {
      case .default:
        return .default
      case .cancellation:
        return .cancel
      case .destructive:
        return .destructive
      }
    }
  #endif
}
