/*
 MenuBar.Edit.swift

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

    private static func undo() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "z",
        action: Selector.undo
      )
    }

    private static func redo() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "Z",
        action: Selector.redo
      )
    }

    private static func cut() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "x",
        action: #selector(NSText.cut(_:))
      )
    }

    private static func copy() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "c",
        action: #selector(NSText.copy(_:))
      )
    }

    private static func paste() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "v",
        action: #selector(NSText.paste(_:))
      )
    }

    private static func pasteAndMatchStyle() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: [.command, .option],
        hotKey: "V",
        action: #selector(NSTextView.pasteAsPlainText(_:))
      )
    }

    private static func delete() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        action: #selector(NSText.delete(_:))
      )
    }

    private static func selectAll() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "a",
        action: #selector(NSResponder.selectAll(_:))
      )
    }

    // Show Character Information (See context menu.)

    internal static func edit() -> Menu<MenuBarLocalization> {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        entries: [
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
          .entry(ContextMenu._showCharacterInformation()),
          .submenu(speech()),
        ]
      )
    }
  }
#endif
