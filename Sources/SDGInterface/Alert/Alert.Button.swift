/*
 Alert.Button.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGText
import SDGLocalization

extension Alert {

  /// A button for dealing with an alert.
  public struct Button<L> where L: Localization {

    // MARK: - Initialization

    /// Creates a button.
    ///
    /// - Parameters:
    ///   - style: The style of button.
    ///   - label: The label on the button.
    ///   - action: The action triggered by the button.
    public init(style: Style, label: UserFacing<StrictString, L>, action: (() -> Void)?) {
      self.style = style
      self.label = label
      self.action = action
    }

    // MARK: - Properties

    private let style: Style
    private let label: UserFacing<StrictString, L>
    private let action: (() -> Void)?

    // MARK: - SwiftUI

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
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
}
