/*
 AlertButton.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif
#if canImport(UIKit)
  import UIKit
#endif

import SDGText
import SDGLocalization

/// A button for dealing with an alert.
public struct AlertButton<L> where L: Localization {

  // MARK: - Initialization

  /// Creates a button.
  ///
  /// - Parameters:
  ///   - style: The style of button.
  ///   - label: The label on the button.
  ///   - action: The action triggered by the button.
  public init(style: AlertButtonStyle, label: UserFacing<StrictString, L>, action: (() -> Void)?) {
    self.style = style
    self.label = label
    self.action = action
  }

  // MARK: - Properties

  private let style: AlertButtonStyle
  internal let label: UserFacing<StrictString, L>
  internal let action: (() -> Void)?

  // MARK: - Cocoa

  #if canImport(UIKit) && !os(watchOS)
    /// Constructs a Cocoa representation of the alter button.
    public func cocoa() -> UIAlertAction {
      let wrappedAction: ((UIAlertAction) -> Void)? = action.map { action in
        return { (UIAlertAction) -> Void in
          // @exempt(from: tests)
          return action()
        }
      }
      return UIAlertAction(
        title: String(label.resolved()),
        style: style.cocoa(),
        handler: wrappedAction
      )
    }
  #endif

  // MARK: - SwiftUI

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    /// Constructs a SwiftUI representation of the alert button.
    @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
    public func swiftUI() -> SwiftUI.Alert.Button {
      switch style {
      case .default:
        return SwiftUI.Alert.Button.default(Text(String(label.resolved())), action: action)
      case .cancellation:
        return SwiftUI.Alert.Button.cancel(Text(String(label.resolved())), action: action)
      case .destructive:
        return SwiftUI.Alert.Button.destructive(Text(String(label.resolved())), action: action)
      }
    }
  #endif
}
