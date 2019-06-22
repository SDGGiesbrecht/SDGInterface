/*
 MenuBarSampleViewTextField.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import ObjectiveC

import SDGText
import SDGLocalization

import SDGMenus
import SDGMenuBar
import SDGApplication

import SDGInterfaceLocalizations

extension MenuBar {

    private static func textFieldEntry() -> MenuEntry<InterfaceLocalization> {
        let textField = MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Field"
            }
        })))
        textField.action = #selector(Application.demonstrateTextField)
        textField.target = self
        return textField
    }

    private static func labelledTextField() -> MenuEntry<InterfaceLocalization> {
        let labelledTextField = MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Labelled Text Field"
            }
        })))
        labelledTextField.action = #selector(Application.demonstrateLabelledTextField)
        labelledTextField.target = self
        return labelledTextField
    }

    internal static func textField() -> Menu<InterfaceLocalization> {
        let textField = Menu(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Field"
            }
        })))
        textField.entries = [
            .entry(textFieldEntry()),
            .entry(labelledTextField())
        ]
        return textField
    }
}
#endif
