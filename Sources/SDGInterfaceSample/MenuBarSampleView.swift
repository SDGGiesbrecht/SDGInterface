/*
 MenuBarSampleView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

import SDGMenus
import SDGMenuBar

import SDGInterfaceLocalizations

extension MenuBar {

    internal static func view() -> MenuEntry<InterfaceLocalization> {
        let view = sample.newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "View"
            }
        })))

        let button = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Button"
            }
        })), action: #selector(Application.demonstrateButton))
        button.target = self

        let buttonSet = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Button Set"
            }
        })), action: #selector(Application.demonstrateButtonSet))
        buttonSet.target = self

        let checkBox = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Check Box"
            }
        })), action: #selector(Application.demonstrateCheckBox))
        checkBox.target = self

        let image = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Image"
            }
        })), action: #selector(Application.demonstrateImage))
        image.target = self

        let label = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Label"
            }
        })), action: #selector(Application.demonstrateLabel))
        label.target = self

        let letterbox = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Letterbox"
            }
        })), action: #selector(Application.demonstrateLetterbox))
        letterbox.target = self

        let textEditor = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Editor"
            }
        })), action: #selector(Application.demonstrateTextEditor))
        textEditor.target = self

        let textField = view.newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Field"
            }
        })))

        let basicTextField = textField.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Field"
            }
        })), action: #selector(Application.demonstrateTextField))
        basicTextField.target = self

        let labelledTextField = textField.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Labelled Text Field"
            }
        })), action: #selector(Application.demonstrateLabelledTextField))
        labelledTextField.target = self
    }
}
