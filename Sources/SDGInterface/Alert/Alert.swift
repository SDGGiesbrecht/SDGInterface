/*
 Alert.swift

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

/// An alert.
public struct Alert<L, M, N> where L: Localization, M: Localization, N: Localization {

  /// Creates an alert.
  ///
  /// - Parameters:
  ///   - title: The title.
  /// 	- message: The message.
  ///   - dismissalButton: The dismissal button.
  public init(
    title: UserFacing<StrictString, L>,
    message: UserFacing<StrictString, M>,
    dismissalButton: Button<N>
  ) {
    self.title = title
    self.message = message
    self.dismissalButton = dismissalButton
  }

  // MARK: - Properties

  private let title: UserFacing<StrictString, L>
  private let message: UserFacing<StrictString, M>?
  private let dismissalButton: Button<N>?

  // MARK: - SwiftUI

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
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
