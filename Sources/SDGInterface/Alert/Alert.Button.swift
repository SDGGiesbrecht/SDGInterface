/*
 Alert.Button.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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
  }
}
