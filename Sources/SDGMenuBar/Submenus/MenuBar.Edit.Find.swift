/*
 MenuBar.Edit.Find.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)

  import AppKit

  import SDGText
  import SDGLocalization

  import SDGInterface

  import SDGInterfaceLocalizations

  extension MenuBar {

    private static func findEntry() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "f",
        selector: #selector(NSTextView.performFindPanelAction(_:)),
        platformTag: 1
      )
    }

    private static func findAndReplace() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: [.command, .option],
        hotKey: "f",
        selector: #selector(NSTextView.performFindPanelAction(_:)),
        platformTag: 12
      )
    }

    private static func findNext() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "g",
        selector: #selector(NSTextView.performFindPanelAction(_:)),
        platformTag: 2
      )
    }

    private static func findPrevious() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "G",
        selector: #selector(NSTextView.performFindPanelAction(_:)),
        platformTag: 3
      )
    }

    private static func useSelectionForFind() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "e",
        selector: #selector(NSTextView.performFindPanelAction(_:)),
        platformTag: 7
      )
    }

    private static func jumpToSelection() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "j",
        selector: #selector(NSResponder.centerSelectionInVisibleArea(_:))
      )
    }

    internal static func find() -> Menu<MenuBarLocalization> {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        entries: [
          .entry(findEntry()),
          .entry(findAndReplace()),
          .entry(findNext()),
          .entry(findPrevious()),
          .entry(jumpToSelection()),
          .entry(useSelectionForFind()),
        ]
      )
    }
  }
#endif
