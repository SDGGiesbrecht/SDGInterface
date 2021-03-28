/*
 Alert.Button.Style.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Alert.Button {

  /// A style of alert button.
  public enum Style {

    /// The default style.
    case `default`

    /// A style indicating cancellation.
    case cancellation

    /// A style indicating a destructive action.
    case destructive
  }
}
