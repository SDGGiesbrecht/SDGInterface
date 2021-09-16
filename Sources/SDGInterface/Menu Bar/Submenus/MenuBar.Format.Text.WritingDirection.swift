/*
 MenuBar.Format.Text.WritingDirection.swift

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

    private static func paragraph() -> Menu<
      MenuBarLocalization,
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>>,
        MenuEntry<MenuBarLocalization>
      >
    > {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Párrafo"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Paragraph"
          case .françaisFrance:
            return "Paragraphe"
          case .ελληνικάΕλλάδα:
            return "Παράγραφος"

          case .deutschDeutschland:
            return "Absatz"
          case .עברית־ישראל:
            return "פיסקה"
          }
        }),
        entries: {
            paragraphDefault()
            paragraphRightToLeft()
            paragraphLeftToRight()
        }
      )
    }

    private static func defaultLabel() -> UserFacing<StrictString, MenuBarLocalization> {
      return UserFacing<StrictString, MenuBarLocalization>({ localization in
        switch localization {
        case .españolEspaña:
          return "Por omisión"
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Default"
        case .françaisFrance:
          return "Par défaut"
        case .deutschDeutschland:
          return "Standard"
        case .ελληνικάΕλλάδα:
          return "Προεπιλογή"
        case .עברית־ישראל:
          return "ברירת־המחדל"
        }
      })
    }
    private static func paragraphDefault() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: defaultLabel(),
        selector: #selector(NSResponder.makeBaseWritingDirectionNatural(_:))
      )
    }

    private static func rightToLeftLabel() -> UserFacing<StrictString, MenuBarLocalization> {
      return UserFacing<StrictString, MenuBarLocalization>({ localization in
        switch localization {
        case .españolEspaña:
          return "De derecha a izquierda"
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Right to Left"
        case .deutschDeutschland:
          return "Von rechts nach links"
        case .françaisFrance:
          return "De droite à gauche"
        case .ελληνικάΕλλάδα:
          return "Δεξιά προς αριστερά"
        case .עברית־ישראל:
          return "מימין לשמאל"
        }
      })
    }
    private static func paragraphRightToLeft() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: rightToLeftLabel(),
        selector: #selector(NSResponder.makeBaseWritingDirectionRightToLeft(_:))
      )
    }

    private static func leftToRightLabel() -> UserFacing<StrictString, MenuBarLocalization> {
      return UserFacing<StrictString, MenuBarLocalization>({ localization in
        switch localization {
        case .españolEspaña:
          return "De izquierda a derecha"
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Left to Right"
        case .deutschDeutschland:
          return "Von links nach rechts"
        case .françaisFrance:
          return "De gauche à droite"
        case .ελληνικάΕλλάδα:
          return "Αριστερά προς δεξιά"
        case .עברית־ישראל:
          return "משמאל לימין"
        }
      })
    }
    private static func paragraphLeftToRight() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: leftToRightLabel(),
        selector: #selector(NSResponder.makeBaseWritingDirectionLeftToRight(_:))
      )
    }

    private static func selection() -> Menu<
      MenuBarLocalization,
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>>,
        MenuEntry<MenuBarLocalization>
      >
    > {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Selección"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Selection"
          case .françaisFrance:
            return "Sélection"

          case .deutschDeutschland:
            return "Auswahl"
          case .ελληνικάΕλλάδα:
            return "Επιλογή"
          case .עברית־ישראל:
            return "בחירה"
          }
        }),
        entries: {
            selectionDefault()
            selectionRightToLeft()
            selectionLeftToRight()
        }
      )
    }

    private static func selectionDefault() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: defaultLabel(),
        selector: #selector(NSResponder.makeTextWritingDirectionNatural(_:))
      )
    }

    private static func selectionRightToLeft() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: rightToLeftLabel(),
        selector: #selector(NSResponder.makeTextWritingDirectionRightToLeft(_:))
      )
    }

    private static func selectionLeftToRight() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: leftToRightLabel(),
        selector: #selector(NSResponder.makeTextWritingDirectionLeftToRight(_:))
      )
    }

    internal static func writingDirection() -> Menu<
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
    > {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Sentido de la escritura"
          case .françaisFrance:
            return "Sens de l’écriture"

          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Writing Direction"
          case .deutschDeutschland:
            return "Richtung beim Schreiben"
          case .ελληνικάΕλλάδα:
            return "Κατεύθυνση γραφής"
          case .עברית־ישראל:
            return "כיווניות הכתיבה"
          }
        }),
        entries: {
            paragraph()
            selection()
        }
      )
    }
  }
#endif
