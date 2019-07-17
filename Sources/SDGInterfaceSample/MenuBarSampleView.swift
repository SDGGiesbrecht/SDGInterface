/*
 MenuBarSampleView.swift

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

    private static func button() -> MenuEntry<InterfaceLocalization> {
        let button = MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Button"
            }
        })))
        button.action = #selector(Application.demonstrateButton)
        button.target = Application.shared
        return button
    }

    private static func buttonSet() -> MenuEntry<InterfaceLocalization> {
        let buttonSet = MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Radio Buttons"
            }
        })))
        buttonSet.action = #selector(Application.demonstrateRadioButtonSet)
        buttonSet.target = Application.shared
        return buttonSet
    }

    private static func checkBox() -> MenuEntry<InterfaceLocalization> {
        let checkBox = MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Check Box"
            }
        })))
        checkBox.action = #selector(Application.demonstrateCheckBox)
        checkBox.target = Application.shared
        return checkBox
    }

    private static func image() -> MenuEntry<InterfaceLocalization> {
        let image = MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Image"
            }
        })))
        image.action = #selector(Application.demonstrateImage)
        image.target = Application.shared
        return image
    }

    private static func label() -> MenuEntry<InterfaceLocalization> {
        let label = MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Label"
            }
        })))
        label.action = #selector(Application.demonstrateLabel)
        label.target = Application.shared
        return label
    }

    private static func letterbox() -> MenuEntry<InterfaceLocalization> {
        let letterbox = MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Letterbox"
            }
        })))
        letterbox.action = #selector(Application.demonstrateLetterbox)
        letterbox.target = Application.shared
        return letterbox
    }

    private static func textEditor() -> MenuEntry<InterfaceLocalization> {
        let textEditor = MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Editor"
            }
        })))
        textEditor.action = #selector(Application.demonstrateTextEditor)
        textEditor.target = Application.shared
        return textEditor
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
#endif
