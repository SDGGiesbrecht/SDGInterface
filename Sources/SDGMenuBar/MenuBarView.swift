/*
 MenuBarView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(Linux) && !os(iOS) && !os(watchOS) && !os(tvOS)
import AppKit

import SDGText
import SDGLocalization

import SDGMenus

import SDGInterfaceLocalizations

extension MenuBar {

    private static func showToolbar() -> MenuEntry<MenuBarLocalization> {
        let showToolbar = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Mostrar barra de herramientas"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Toolbar"
            case .deutschDeutschland:
                return "Symbolleiste einblenden"
            case .françaisFrance:
                return "Afficher la barre d’outils"
            case .ελληνικάΕλλάδα:
                return "Εμφάνιση γραμμής εργαλείων"
            case .עברית־ישראל:
                return "הצג את סרגל הכלים"
            }
        })))
        showToolbar.action = #selector(NSWindow.toggleToolbarShown(_:))
        showToolbar.hotKey = "t"
        showToolbar.hotKeyModifiers = [.command, .option]
        return showToolbar
    }

    private static func customizeToolbar() -> MenuEntry<MenuBarLocalization> {
        let customizeToolbar = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Personalizar barra de herramientas..."
            case .englishUnitedKingdom:
                return "Customise Toolbar..."
            case .englishUnitedStates, .englishCanada:
                return "Customize Toolbar..."
            case .deutschDeutschland:
                return "Symbolleiste anpassen ..."
            case .françaisFrance:
                return "Personnaliser la barre d’outils..."
            case .ελληνικάΕλλάδα:
                return "Προσαρμογή γραμμής εργαλείων..."
            case .עברית־ישראל:
                return "התאמה אישית של סרגל הכלים..."
            }
        })))
        customizeToolbar.action = #selector(NSWindow.runToolbarCustomizationPalette(_:))
        return customizeToolbar
    }

    private static func showSideBar() -> MenuEntry<MenuBarLocalization> {
        let showSideBar = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Mostrar barra lateral"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Side Bar"
            case .deutschDeutschland:
                return "Seitenleiste einblenden"
            case .françaisFrance:
                return "Afficher la barre latérale"
            case .ελληνικάΕλλάδα:
                return "Εμφάνιση πλαϊνής στήλης"
            case .עברית־ישראל:
                return "הצג את סרגל הצד"
            }
        })))
        showSideBar.action = Selector.toggleSourceList
        showSideBar.hotKey = "s"
        showSideBar.hotKeyModifiers = [.command, .control]
        return showSideBar
    }

    private static func enterFullScreen() -> MenuEntry<MenuBarLocalization> {
        let enterFullScreen = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Usar pantalla completa"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Enter Full Screen"
            case .deutschDeutschland:
                return "Vollbild ein"
            case .françaisFrance:
                return "Activer le mode plein écran"
            case .ελληνικάΕλλάδα:
                return "Είσοδος σε πλήρη οθόνη"
            case .עברית־ישראל:
                return "עבור למסך מלא"
            }
        })))
        enterFullScreen.action = #selector(NSWindow.toggleFullScreen(_:))
        enterFullScreen.hotKey = "f"
        enterFullScreen.hotKeyModifiers = [.command, .control]
        return enterFullScreen
    }

    internal static func view() -> Menu<MenuBarLocalization> {
        let view = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Visualización"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "View"
            case .deutschDeutschland:
                return "Darstellung"
            case .françaisFrance:
                return "Présentation"
            case .ελληνικάΕλλάδα:
                return "Προβολή"
            case .עברית־ישראל:
                return "תצוגה"
            }
        })))
        view.entries = [
            .entry(showToolbar()),
            .entry(customizeToolbar()),
            .separator,
            .entry(showSideBar()),
            .entry(enterFullScreen())
        ]
        return view
    }
}
#endif
