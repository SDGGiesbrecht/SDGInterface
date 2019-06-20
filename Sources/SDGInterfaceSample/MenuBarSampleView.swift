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
import SDGApplication

import SDGInterfaceLocalizations

extension MenuBar {

    private static func button() -> MenuEntry<InterfaceLocalization> {
        let button = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Button"
            }
        })), action: #selector(Application.demonstrateButton))
        button.target = self
    }

    private static func buttonSet() -> MenuEntry<InterfaceLocalization> {
        let buttonSet = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Button Set"
            }
        })), action: #selector(Application.demonstrateButtonSet))
        buttonSet.target = self
    }

    private static func checkBox() -> MenuEntry<InterfaceLocalization> {
        let checkBox = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Check Box"
            }
        })), action: #selector(Application.demonstrateCheckBox))
        checkBox.target = self
    }

    private static func image() -> MenuEntry<InterfaceLocalization> {
        let image = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Image"
            }
        })), action: #selector(Application.demonstrateImage))
        image.target = self
    }

    private static func label() -> MenuEntry<InterfaceLocalization> {
        let label = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Label"
            }
        })), action: #selector(Application.demonstrateLabel))
        label.target = self
    }

    private static func letterbox() -> MenuEntry<InterfaceLocalization> {
        let letterbox = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Letterbox"
            }
        })), action: #selector(Application.demonstrateLetterbox))
        letterbox.target = self
    }

    private static func textEditor() -> MenuEntry<InterfaceLocalization> {
        let textEditor = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Editor"
            }
        })), action: #selector(Application.demonstrateTextEditor))
        textEditor.target = self
    }

    internal static func view() -> Menu<InterfaceLocalization> {
        let view = Menu(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "View"
            }
        })))
        view.entries = [
            .entry(button()),
            .entry(buttonSet()),
            .entry(checkBox()),
            .entry(image()),
            .entry(label()),
            .entry(letterbox()),
            .entry(textEditor()),
            .submenu(textField())
        ]
        return view
    }
}
