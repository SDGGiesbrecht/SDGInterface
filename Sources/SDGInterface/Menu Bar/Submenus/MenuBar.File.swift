/*
 MenuBar.File.swift

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

  import SDGInterfaceLocalizations

  extension MenuBar {

    private static func new() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "n",
        selector: #selector(NSDocumentController.newDocument(_:))
      )
    }

    private static func open() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "o",
        selector: #selector(NSDocumentController.openDocument(_:))
      )
    }

    private static func close() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "w",
        selector: #selector(NSWindow.performClose(_:))
      )
    }

    private static func save() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "s",
        selector: #selector(NSDocument.save(_:))
      )
    }

    private static func duplicate() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "S",
        selector: #selector(NSDocument.duplicate(_:))
      )
    }

    private static func rename() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        selector: #selector(NSDocument.rename(_:))
      )
    }

    private static func moveTo() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        selector: #selector(NSDocument.move(_:))
      )
    }

    private static func revertToSaved() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Revert to Saved"
          case .deutschDeutschland:
            return "Auf das gespeicherte zurückgreifen"
          }
        }),
        hotKeyModifiers: .command,
        hotKey: "r",
        selector: #selector(NSDocument.revertToSaved(_:))
      )
    }

    internal static func pageSetUp() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "P",
        selector: #selector(NSDocument.runPageLayout(_:))
      )
    }

    internal static func print() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "p",
        selector: #selector(NSView.printView(_:))
      )
    }

    internal static func file() -> Menu<
      MenuBarLocalization,
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<
                  MenuComponentsConcatenation<
                    MenuComponentsConcatenation<
                      MenuComponentsConcatenation<
                        MenuComponentsConcatenation<
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<
                              MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                            >, Menu<MenuBarLocalization, MenuEntry<MenuBarLocalization>>
                          >, Divider
                        >, MenuEntry<MenuBarLocalization>
                      >, MenuEntry<MenuBarLocalization>
                    >, MenuEntry<MenuBarLocalization>
                  >, MenuEntry<MenuBarLocalization>
                >, MenuEntry<MenuBarLocalization>
              >, MenuEntry<InterfaceLocalization>
            >, Divider
          >, MenuEntry<MenuBarLocalization>
        >, MenuEntry<MenuBarLocalization>
      >
    > {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        entries: {
            new()
            open()
            openRecent()
            Divider()
            close()
            save()
            duplicate()
            rename()
            moveTo()
            revertToSaved()
            Divider()
            pageSetUp()
            print()
        }
      )
    }
  }
#endif
