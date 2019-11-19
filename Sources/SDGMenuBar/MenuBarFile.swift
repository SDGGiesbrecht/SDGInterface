/*
 MenuBarFile.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SDGText
  import SDGLocalization

  import SDGMenus

  import SDGInterfaceLocalizations

  extension MenuBar {

    private static func new() -> MenuEntry<MenuBarLocalization> {
      let new = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
              return "Nuevo"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "New"
            case .deutschDeutschland:
              return "Neu"
            case .françaisFrance:
              return "Nouveau"

            case .ελληνικάΕλλάδα:
              return "Δημιουργία"
            case .עברית־ישראל:
              return "חדש"
            }
          })
        )
      )
      new.action = #selector(NSDocumentController.newDocument(_:))
      new.hotKey = "n"
      new.hotKeyModifiers = .command
      return new
    }

    private static func open() -> MenuEntry<MenuBarLocalization> {
      let open = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
              return "Abrir..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Open..."
            case .deutschDeutschland:
              return "Öffnen ..."

            case .françaisFrance:
              return "Ouvrir..."
            case .ελληνικάΕλλάδα:
              return "Άνοιγμα..."
            case .עברית־ישראל:
              return "פתח..."
            }
          })
        )
      )
      open.action = #selector(NSDocumentController.openDocument(_:))
      open.hotKey = "o"
      open.hotKeyModifiers = .command
      return open
    }

    private static func close() -> MenuEntry<MenuBarLocalization> {
      let close = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
              return "Cerrar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Close"
            case .deutschDeutschland:
              return "Schließen"
            case .françaisFrance:
              return "Fermer"
            case .ελληνικάΕλλάδα:
              return "Κλείσιμο"
            case .עברית־ישראל:
              return "סגור"
            }
          })
        )
      )
      close.action = #selector(NSWindow.performClose(_:))
      close.hotKey = "w"
      close.hotKeyModifiers = .command
      return close
    }

    private static func save() -> MenuEntry<MenuBarLocalization> {
      let save = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
              return "Guardar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Save"
            case .deutschDeutschland:
              return "Sichern"
            case .françaisFrance:
              return "Enregistrer"
            case .ελληνικάΕλλάδα:
              return "Αποθήκευση"
            case .עברית־ישראל:
              return "שמור"
            }
          })
        )
      )
      save.action = #selector(NSDocument.save(_:))
      save.hotKey = "s"
      save.hotKeyModifiers = .command
      return save
    }

    private static func duplicate() -> MenuEntry<MenuBarLocalization> {
      let duplicate = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
              return "Duplicar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Duplicate"
            case .deutschDeutschland:
              return "Duplizieren"
            case .françaisFrance:
              return "Dupliquer"

            case .ελληνικάΕλλάδα:
              return "Διπλότυπο"
            case .עברית־ישראל:
              return "שכפל"
            }
          })
        )
      )
      duplicate.action = #selector(NSDocument.duplicate(_:))
      duplicate.hotKey = "S"
      duplicate.hotKeyModifiers = .command
      return duplicate
    }

    private static func rename() -> MenuEntry<MenuBarLocalization> {
      let rename = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
              return "Renombrar..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Rename..."
            case .françaisFrance:
              return "Renommer..."

            case .deutschDeutschland:
              return "Umbenennen ..."
            case .ελληνικάΕλλάδα:
              return "Μετανομασία..."
            case .עברית־ישראל:
              return "שינוי שם..."
            }
          })
        )
      )
      rename.action = #selector(NSDocument.rename(_:))
      return rename
    }

    private static func moveTo() -> MenuEntry<MenuBarLocalization> {
      let moveTo = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
              return "Trasladar a..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Move to..."
            case .deutschDeutschland:
              return "Bewegen ..."
            case .françaisFrance:
              return "Déplacer vers..."
            case .ελληνικάΕλλάδα:
              return "Μετακίνηση σε..."
            case .עברית־ישראל:
              return "העבר אל..."
            }
          })
        )
      )
      moveTo.action = #selector(NSDocument.move(_:))
      return moveTo
    }

    private static func revertToSaved() -> MenuEntry<InterfaceLocalization> {
      let revertToSaved = MenuEntry(
        label: .static(
          UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Revert to Saved"
            case .deutschDeutschland:
              return "Auf das gespeicherte zurückgreifen"
            }
          })
        )
      )
      revertToSaved.action = #selector(NSDocument.revertToSaved(_:))
      revertToSaved.hotKey = "r"
      revertToSaved.hotKeyModifiers = .command
      return revertToSaved
    }

    private static func pageSetUp() -> MenuEntry<MenuBarLocalization> {
      let pageSetUp = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
              return "Ajustar página..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Page Set‐Up..."
            case .deutschDeutschland:
              return "Papierformat ..."
            case .françaisFrance:
              return "Format d’impression..."
            case .ελληνικάΕλλάδα:
              return "Διαμόρφωση σελίδας..."
            case .עברית־ישראל:
              return "הגדרת עמוד..."
            }
          })
        )
      )
      pageSetUp.action = #selector(NSDocument.runPageLayout(_:))
      pageSetUp.hotKey = "P"
      pageSetUp.hotKeyModifiers = .command
      return pageSetUp
    }

    private static func print() -> MenuEntry<MenuBarLocalization> {
      let print = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
              return "Imprimir..."
            case .françaisFrance:
              return "Imprimer..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Print..."
            case .deutschDeutschland:
              return "Drucken ..."
            case .ελληνικάΕλλάδα:
              return "Εκτύπωση..."
            case .עברית־ישראל:
              return "הדפס..."
            }
          })
        )
      )
      print.action = #selector(NSView.printView(_:))
      print.hotKey = "p"
      print.hotKeyModifiers = .command
      return print
    }

    internal static func file() -> Menu<MenuBarLocalization> {
      let file = Menu(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
              return "Archivo"
            case .ελληνικάΕλλάδα:
              return "Αρχείο"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "File"
            case .deutschDeutschland:
              return "Ablage"
            case .françaisFrance:
              return "Fichier"
            case .עברית־ישראל:
              return "קובץ"
            }
          })
        )
      )
      file.entries = [
        .entry(new()),
        .entry(open()),
        .submenu(openRecent()),
        .separator,
        .entry(close()),
        .entry(save()),
        .entry(duplicate()),
        .entry(rename()),
        .entry(moveTo()),
        .entry(revertToSaved()),
        .separator,
        .entry(pageSetUp()),
        .entry(print())
      ]
      return file
    }
  }
#endif
