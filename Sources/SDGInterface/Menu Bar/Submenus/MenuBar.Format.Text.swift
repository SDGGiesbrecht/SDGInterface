/*
 MenuBar.Format.Text.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

    private static func alignRight() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Alinear a la derecha"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Align Right"
          case .deutschDeutschland:
            return "Rechtsbündig"
          case .françaisFrance:
            return "Aligner à droite"
          case .ελληνικάΕλλάδα:
            return "Στοίχιση δεξιά"
          case .עברית־ישראל:
            return "יישר לימין"
          }
        }),
        hotKeyModifiers: .command,
        hotKey: "}",
        selector: #selector(NSText.alignRight(_:))
      )
    }

    private static func centre() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Centrar"
          case .englishUnitedKingdom, .englishCanada:
            return "Centre"
          case .englishUnitedStates:
            return "Center"
          case .deutschDeutschland:
            return "Zentriert"
          case .françaisFrance:
            return "Centrer"
          case .ελληνικάΕλλάδα:
            return "Κεντράρισμα"

          case .עברית־ישראל:
            return "מרכז"
          }
        }),
        hotKeyModifiers: .command,
        hotKey: "|",
        selector: #selector(NSText.alignCenter(_:))
      )
    }

    private static func justify() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Justificar"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Justify"
          case .françaisFrance:
            return "Justifier"

          case .deutschDeutschland:
            return "Blocksatz"
          case .ελληνικάΕλλάδα:
            return "Πλήρης στοίχιση"
          case .עברית־ישראל:
            return "יישר לשני הצדדים"
          }
        }),
        selector: #selector(NSTextView.alignJustified(_:))
      )
    }

    private static func alignLeft() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Alinear a la izquierda"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Align Left"
          case .deutschDeutschland:
            return "Linksbündig"
          case .françaisFrance:
            return "Aligner à gauche"
          case .ελληνικάΕλλάδα:
            return "Στοίχιση αριστερά"
          case .עברית־ישראל:
            return "יישר לשמאל"
          }
        }),
        hotKeyModifiers: .command,
        hotKey: "{",
        selector: #selector(NSText.alignLeft(_:))
      )
    }

    private static func showRuler() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Mostrar regla"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Show Ruler"
          case .deutschDeutschland:
            return "Lineal einblenden"
          case .françaisFrance:
            return "Afficher la règle"
          case .ελληνικάΕλλάδα:
            return "Εμφάνιση χάρακα"
          case .עברית־ישראל:
            return "הצג סרגל"
          }
        }),
        selector: #selector(NSText.toggleRuler(_:))
      )
    }

    private static func copyRuler() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Copiar regla"
          case .françaisFrance:
            return "Copier la règle"

          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Copy Ruler"
          case .deutschDeutschland:
            return "Lineal kopieren"
          case .ελληνικάΕλλάδα:
            return "Αντιγραφή χάρακα"
          case .עברית־ישראל:
            return "העתק סרגל"
          }
        }),
        hotKeyModifiers: [.command, .control],
        hotKey: "c",
        selector: #selector(NSText.copyRuler(_:))
      )
    }

    private static func pasteRuler() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Pegar regla"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Paste Ruler"
          case .deutschDeutschland:
            return "Lineal einsetzen"
          case .françaisFrance:
            return "Coller la règle"
          case .ελληνικάΕλλάδα:
            return "Επικόλληση χάρακα"
          case .עברית־ישראל:
            return "הדבק סרגל"
          }
        }),
        hotKeyModifiers: [.command, .control],
        hotKey: "v",
        selector: #selector(NSText.pasteRuler(_:))
      )
    }

    internal static func text() -> Menu<
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
                        MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                      >, MenuEntry<MenuBarLocalization>
                    >, MenuEntry<MenuBarLocalization>
                  >, Divider
                >,
                Menu<
                  MenuBarLocalization,
                  MenuComponentsConcatenation<
                    Menu<
                      MenuBarLocalization,
                      MenuComponentsConcatenation<
                        MenuComponentsConcatenation<
                          MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                        >, MenuEntry<MenuBarLocalization>
                      >
                    >,
                    Menu<
                      MenuBarLocalization,
                      MenuComponentsConcatenation<
                        MenuComponentsConcatenation<
                          MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                        >, MenuEntry<MenuBarLocalization>
                      >
                    >
                  >
                >
              >, Divider
            >, MenuEntry<MenuBarLocalization>
          >, MenuEntry<MenuBarLocalization>
        >, MenuEntry<MenuBarLocalization>
      >
    > {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Texto"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
            .deutschDeutschland:
            return "Text"
          case .françaisFrance:
            return "Texte"
          case .ελληνικάΕλλάδα:
            return "Κείμενο"
          case .עברית־ישראל:
            return "מלל"
          }
        }),
        entries: {
          alignRight()
          centre()
          justify()
          alignLeft()
          Divider()
          writingDirection()
          Divider()
          showRuler()
          copyRuler()
          pasteRuler()
        }
      )
    }
  }
#endif
