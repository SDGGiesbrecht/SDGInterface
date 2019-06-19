/*
 MenuBarEditFind.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#endif

import SDGText
import SDGLocalization

import SDGMenus

import SDGInterfaceLocalizations

extension MenuBar {

    private static func findEntry() -> MenuEntry<MenuBarLocalization> {
        let find = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Buscar..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find..."
            case .deutschDeutschland:
                return "Suchen ..."
            case .françaisFrance:
                return "Rechercher..."
            case .ελληνικάΕλλάδα:
                return "Εύρεση"
            case .עברית־ישראל:
                return "חיפוש..."
            }
        })))
        find.action = #selector(NSTextView.performFindPanelAction(_:))
        #if canImport(AppKit)
        find.native.tag = 1
        #endif
        find.hotKey = "f"
        find.hotKeyModifiers = .command
        return find
    }

    private static func findAndReplace() -> MenuEntry<MenuBarLocalization> {
        let replace = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Buscar y reemplazar..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find & Replace..."
            case .deutschDeutschland:
                return "Suchen und Ersetzen ..."
            case .françaisFrance:
                return "Rechercher et remplacer..."
            case .ελληνικάΕλλάδα:
                return "Εύρεση και αντικατάσταση..."
            case .עברית־ישראל:
                return "חפש והחלף..."
            }
        })))
        replace.action = #selector(NSTextView.performFindPanelAction(_:))
        #if canImport(AppKit)
        replace.native.tag = 12
        #endif
        replace.hotKey = "f"
        replace.hotKeyModifiers = [.command, .option]
    }

    private static func findNext() -> MenuEntry<MenuBarLocalization> {
        let findNext = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Buscar siguiente"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find Next"
            case .deutschDeutschland:
                return "Weitersuchen (vorwärts)"
            case .françaisFrance:
                return "Rechercher le suivant"
            case .ελληνικάΕλλάδα:
                return "Εύρεση επόμενου"
            case .עברית־ישראל:
                return "חפש את הבא"
            }
        })))
        findNext.action = #selector(NSTextView.performFindPanelAction(_:))
        #if canImport(AppKit)
        findNext.native.tag = 2
        #endif
        findNext.hotKey = "g"
        findNext.hotKeyModifiers = [.command]
    }

    private static func findPrevious() -> MenuEntry<MenuBarLocalization> {
        let findPrevious = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Buscar antetior"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find Previous"
            case .deutschDeutschland:
                return "Weitersuchen (rückwärts)"
            case .françaisFrance:
                return "Rechercher le précédent"
            case .ελληνικάΕλλάδα:
                return "Εύρεση προηγούμενου"
            case .עברית־ישראל:
                return "חפש את הקודם"
            }
        })))
        findPrevious.action = #selector(NSTextView.performFindPanelAction(_:))
        #if canImport(AppKit)
        findPrevious.native.tag = 3
        #endif
        findPrevious.hotKey = "G"
        findPrevious.hotKeyModifiers = [.command]
    }

    private static func useSelectionForFind() -> MenuEntry<MenuBarLocalization> {
        let useSelectionForFind = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Usar selección para buscar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use Selection for Find"
            case .deutschDeutschland:
                return "Auswahl suchen"
            case .françaisFrance:
                return "Rechercher la sélection"
            case .ελληνικάΕλλάδα:
                return "Χρήση επιλογής για εύρεση"
            case .עברית־ישראל:
                return "השתמש במלל הנבחר לחיפוש"
            }
        })))
        useSelectionForFind.action = #selector(NSTextView.performFindPanelAction(_:))
        #if canImport(AppKit)
        useSelectionForFind.native.tag = 7
        #endif
        useSelectionForFind.hotKey = "e"
        useSelectionForFind.hotKeyModifiers = .command
    }

    private static func jumpToSelection() -> MenuEntry<MenuBarLocalization> {
        let jumpToSelection = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Ir a la selección"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Jump to Selection"
            case .deutschDeutschland:
                return "Auswahl anzeigen"
            case .françaisFrance:
                return "Aller à la sélection"
            case .ελληνικάΕλλάδα:
                return "Μετάβαση σε επιλογή"
            case .עברית־ישראל:
                return "עבור על הקטע הנבחר"
            }
        })))
        jumpToSelection.action = #selector(NSResponder.centerSelectionInVisibleArea(_:))
        jumpToSelection.hotKey = "j"
        jumpToSelection.hotKeyModifiers = [.command]
    }

    internal static func find() -> Menu<MenuBarLocalization> {
        let find = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Buscar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find"
            case .deutschDeutschland:
                return "Suchen"
            case .françaisFrance:
                return "Rechercher"
            case .ελληνικάΕλλάδα:
                return "Εύρεση"
            case .עברית־ישראל:
                return "חיפוש"
            }
        })))
        find.entries = [
            .entry(findEntry()),
            .entry(findAndReplace()),
            .entry(findNext()),
            .entry(findPrevious()),
            .entry(useSelectionForFind())
        ]
        return find
    }
}
