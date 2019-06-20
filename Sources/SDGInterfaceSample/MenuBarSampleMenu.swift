/*
 MenuBarSampleMenu.swift

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

    private static func menuEntry() -> MenuEntry<InterfaceLocalization> {
        return MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Menu Entry"
            }
        })))
    }

    private static func indented() -> MenuEntry<InterfaceLocalization> {
        let indented = MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Indented"
            }
        })))
        indented.indentationLevel = 1
        return indented
    }

    private static func submenu() -> Menu<InterfaceLocalization> {
        let submenu = Menu(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Submenu"
            }
        })))
        submenu.entries = [
            .entry(menuEntry())
        ]
        return submenu
    }

    internal static func menu() -> Menu<InterfaceLocalization> {
        let menu = Menu(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Menu"
            }
        })))
        menu.entries = [
            .entry(menuEntry()),
            .entry(indented()),
            .separator,
            .submenu(submenu())
        ]
        return menu
    }
}
