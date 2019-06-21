/*
 MenuBarEdit.swift

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
#if canImport(UIKit)
import UIKit
#endif

import SDGText
import SDGLocalization

import SDGMenus
import SDGInterfaceElements

import SDGInterfaceLocalizations

extension MenuBar {

    #if canImport(AppKit)
    private static func undo() -> MenuEntry<MenuBarLocalization> {
        let undo = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Deshacer"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Undo"
            case .deutschDeutschland:
                return "Widerrufen"
            case .françaisFrance:
                return "Annuler"
            case .ελληνικάΕλλάδα:
                return "Αναίρεση"
            case .עברית־ישראל:
                return "בטל"
            }
        })))
        undo.action = Selector.undo
        undo.hotKey = "z"
        undo.hotKeyModifiers = .command
        return undo
    }

    private static func redo() -> MenuEntry<MenuBarLocalization> {
        let redo = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Rehacer"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Redo"
            case .deutschDeutschland:
                return "Wiederholen"
            case .françaisFrance:
                return "Rétablir"
            case .ελληνικάΕλλάδα:
                return "Επανάληψη"
            case .עברית־ישראל:
                return "חזור על הפעולה האחרונה"
            }
        })))
        redo.action = Selector.redo
        redo.hotKey = "Z"
        redo.hotKeyModifiers = .command
        return redo
    }

    private static func cut() -> MenuEntry<MenuBarLocalization> {
        let cut = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Cortar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Cut"
            case .deutschDeutschland:
                return "Ausschneiden"
            case .françaisFrance:
                return "Couper"
            case .ελληνικάΕλλάδα:
                return "Αποκοπή"
            case .עברית־ישראל:
                return "גזור"
            }
        })))
        cut.action = #selector(NSText.cut(_:))
        cut.hotKey = "x"
        cut.hotKeyModifiers = .command
        return cut
    }

    private static func copy() -> MenuEntry<MenuBarLocalization> {
        let copy = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Copiar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Copy"
            case .deutschDeutschland:
                return "Kopieren"
            case .françaisFrance:
                return "Copier"

            case .ελληνικάΕλλάδα:
                return "Αντιγραφή"
            case .עברית־ישראל:
                return "העתק"
            }
        })))
        copy.action = #selector(NSText.copy(_:))
        copy.hotKey = "c"
        copy.hotKeyModifiers = .command
        return copy
    }

    private static func paste() -> MenuEntry<MenuBarLocalization> {
        let paste = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Pegar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Paste"
            case .deutschDeutschland:
                return "Einsetzen"

            case .françaisFrance:
                return "Coller"
            case .ελληνικάΕλλάδα:
                return "Επικόλληση"

            case .עברית־ישראל:
                return "הדבק"
            }
        })))
        paste.action = #selector(NSText.paste(_:))
        paste.hotKey = "v"
        paste.hotKeyModifiers = .command
        return paste
    }

    private static func pasteAndMatchStyle() -> MenuEntry<MenuBarLocalization> {
        let pasteAndMatchStyle = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Pegar con el mismo estilo"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Paste & Match Style"
            case .deutschDeutschland:
                return "Einsetzen und Stil anpassen"
            case .françaisFrance:
                return "Coller et adapter le style"
            case .ελληνικάΕλλάδα:
                return "Επικόλληση και αντιστοίχιση στιλ"
            case .עברית־ישראל:
                return "הדבק והתאם לסגנון"
            }
        })))
        pasteAndMatchStyle.action = #selector(NSTextView.pasteAsPlainText(_:))
        pasteAndMatchStyle.hotKey = "V"
        pasteAndMatchStyle.hotKeyModifiers = [.command, .option]
        return pasteAndMatchStyle
    }

    private static func delete() -> MenuEntry<MenuBarLocalization> {
        let delete = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Eliminar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Delete"
            case .deutschDeutschland:
                return "Löschen"
            case .françaisFrance:
                return "Supprimer"
            case .ελληνικάΕλλάδα:
                return "Διαγραφή"
            case .עברית־ישראל:
                return "מחק"
            }
        })))
        delete.action = #selector(NSText.delete(_:))
        return delete
    }

    private static func selectAll() -> MenuEntry<MenuBarLocalization> {
        let selectAll = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Seleccionar todo"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Select All"
            case .deutschDeutschland:
                return "Alles auswählen"
            case .françaisFrance:
                return "Tout sélectionner"
            case .ελληνικάΕλλάδα:
                return "Επιλογή όλων"
            case .עברית־ישראל:
                return "בחר הכל"
            }
        })))
        selectAll.action = #selector(NSResponder.selectAll(_:))
        selectAll.hotKey = "a"
        selectAll.hotKeyModifiers = .command
        return selectAll
    }
    #endif

    #if !os(watchOS)
    public static func _showCharacterInformation() -> MenuEntry<InterfaceLocalization> {
        let showCharacterInformation = MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Character Information"
            }
        })))
        showCharacterInformation.action = #selector(NSTextView.showCharacterInformation(_:))
        return showCharacterInformation
    }
    #endif

    #if canImport(AppKit)
    internal static func edit() -> Menu<MenuBarLocalization> {
        let edit = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Edición"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Edit"
            case .françaisFrance:
                return "Édition"
            case .deutschDeutschland:
                return "Bearbeiten"
            case .ελληνικάΕλλάδα:
                return "Επεξεργασία"
            case .עברית־ישראל:
                return "עריכה"
            }
        })))
        edit.entries = [
            .entry(undo()),
            .entry(redo()),
            .separator,
            .entry(cut()),
            .entry(copy()),
            .entry(paste()),
            .entry(pasteAndMatchStyle()),
            .entry(delete()),
            .entry(selectAll()),
            .separator,
            .submenu(find()),
            .submenu(spellingAndGrammar()),
            .submenu(substitutions()),
            .submenu(transformations()),
            .entry(showCharacterInformation()),
            .submenu(speech())
        ]
        return edit
    }
    #endif
}
