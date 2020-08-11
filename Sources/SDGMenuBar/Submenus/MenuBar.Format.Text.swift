/*
 MenuBar.Format.Text.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
        action: #selector(NSText.alignRight(_:))
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
        action: #selector(NSText.alignCenter(_:))
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
        action: #selector(NSTextView.alignJustified(_:))
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
        action: #selector(NSText.alignLeft(_:))
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
        action: #selector(NSText.toggleRuler(_:))
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
        action: #selector(NSText.copyRuler(_:))
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
        action: #selector(NSText.pasteRuler(_:))
      )
    }

    internal static func text() -> Menu<MenuBarLocalization> {
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
        entries: [
          .entry(alignRight()),
          .entry(centre()),
          .entry(justify()),
          .entry(alignLeft()),
          .separator,
          .submenu(writingDirection()),
          .separator,
          .entry(showRuler()),
          .entry(copyRuler()),
          .entry(pasteRuler()),
        ]
      )
    }
  }
#endif
