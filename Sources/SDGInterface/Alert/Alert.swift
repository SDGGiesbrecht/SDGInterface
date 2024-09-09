/*
 Alert.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif
#if canImport(AppKit)
  import AppKit
#endif

import SDGText
import SDGLocalization

/// An alert.
public struct Alert<L, M, N> where L: Localization, M: Localization, N: Localization {

  /// Creates an alert.
  ///
  /// - Parameters:
  ///   - style: The style of the alert.
  ///   - title: The title.
  ///   - message: The message.
  ///   - dismissalButton: The dismissal button.
  public init(
    style: AlertStyle,
    title: UserFacing<StrictString, L>,
    message: UserFacing<StrictString, M>,
    dismissalButton: AlertButton<N>
  ) {
    self.style = style
    self.title = title
    self.message = message
    self.dismissalButton = dismissalButton
  }

  // MARK: - Properties

  private let style: AlertStyle
  private let title: UserFacing<StrictString, L>
  private let message: UserFacing<StrictString, M>?
  internal let dismissalButton: AlertButton<N>?

  // MARK: - AppKit

  #if canImport(AppKit)
    // Internal because the dismisal action is handled at the call site.
    internal func cocoa() -> NSAlert {
      let alert = NSAlert()
      alert.alertStyle = style.cocoa()
      alert.messageText = String(title.resolved())
      if let message = self.message {
        alert.informativeText = String(message.resolved())
      }
      if let dismissal = dismissalButton {
        alert.addButton(withTitle: String(dismissal.label.resolved()))
      }
      return alert
    }
  #endif

  #if canImport(UIKit) && !os(watchOS)
    /// Constructs a Cocoa representation of the alert.
    public func cocoa() -> UIAlertController {
      let alert = UIAlertController(
        title: String(title.resolved()),
        message: message.map({ String($0.resolved()) }),
        preferredStyle: .alert
      )
      if let dismissal = dismissalButton {
        alert.addAction(dismissal.cocoa())
      }
      return alert
    }
  #endif

  // MARK: - SwiftUI

  #if canImport(SwiftUI)
    /// Constructs a SwiftUI representation of the alert.
    @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
    public func swiftUI() -> SwiftUI.Alert {
      return SwiftUI.Alert(
        title: Text(String(title.resolved())),
        message: message.map({ Text(String($0.resolved())) }),
        dismissButton: dismissalButton?.swiftUI()
      )
    }
  #endif
}
