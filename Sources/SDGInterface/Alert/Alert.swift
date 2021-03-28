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
  ///   - message: The message.
  /// 	- details: Details.
  ///   - dismissalButton: The dismissal button.
  public init(
    message: UserFacing<StrictString, L>,
    details: UserFacing<StrictString, M>?,
    dismissalButton: Button<N>
  ) {
    self.message = message
    self.details = details
    self.dismissalButton = dismissalButton
  }

  // MARK: - Properties

  private let message: UserFacing<StrictString, L>
  private let details: UserFacing<StrictString, M>?
  private let dismissalButton: Button<N>

  // MARK: - SwiftUI

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  public func swiftUI() -> SwiftUI.Alert {
    return SwiftUI.Alert(title: Text(String(message.resolved())), message: details.)
  }
}
