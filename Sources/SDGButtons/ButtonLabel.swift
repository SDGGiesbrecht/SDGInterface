/*
 ButtonLabel.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

import SDGImageDisplay

/// A button label.
public enum ButtonLabel {

    /// Text.
    case text(StrictString)

    /// A symbol.
    case symbol(Image)
}