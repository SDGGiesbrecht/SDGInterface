/*
 MenuBar.Format.Text.WritingDirection.swift

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

    private static func paragraph() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
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
          })
        )
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
      let paragraphDefault = MenuEntry(label: .static(defaultLabel()))
      paragraphDefault.action = #selector(NSResponder.makeBaseWritingDirectionNatural(_:))
      paragraphDefault.indentationLevel = 1
      return paragraphDefault
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
      let paragraphRightToLeft = MenuEntry(label: .static(rightToLeftLabel()))
      paragraphRightToLeft.action = #selector(NSResponder.makeBaseWritingDirectionRightToLeft(_:))
      paragraphRightToLeft.indentationLevel = 1
      return paragraphRightToLeft
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
      let paragraphLeftToRight = MenuEntry(label: .static(leftToRightLabel()))
      paragraphLeftToRight.action = #selector(NSResponder.makeBaseWritingDirectionLeftToRight(_:))
      paragraphLeftToRight.indentationLevel = 1
      return paragraphLeftToRight
    }

    private static func selection() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
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
          })
        )
      )
    }

    private static func selectionDefault() -> MenuEntry<MenuBarLocalization> {
      let selectionDefault = MenuEntry(label: .static(defaultLabel()))
      selectionDefault.action = #selector(NSResponder.makeTextWritingDirectionNatural(_:))
      selectionDefault.indentationLevel = 1
      return selectionDefault
    }

    private static func selectionRightToLeft() -> MenuEntry<MenuBarLocalization> {
      let selectionRightToLeft = MenuEntry(label: .static(rightToLeftLabel()))
      selectionRightToLeft.action = #selector(NSResponder.makeTextWritingDirectionRightToLeft(_:))
      selectionRightToLeft.indentationLevel = 1
      return selectionRightToLeft
    }

    private static func selectionLeftToRight() -> MenuEntry<MenuBarLocalization> {
      let selectionLeftToRight = MenuEntry(label: .static(leftToRightLabel()))
      selectionLeftToRight.action = #selector(NSResponder.makeTextWritingDirectionLeftToRight(_:))
      selectionLeftToRight.indentationLevel = 1
      return selectionLeftToRight
    }

    internal static func writingDirection() -> Menu<MenuBarLocalization> {
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
        entries: [
          .entry(paragraph()),
          .entry(paragraphDefault()),
          .entry(paragraphRightToLeft()),
          .entry(paragraphLeftToRight()),
          .separator,
          .entry(selection()),
          .entry(selectionDefault()),
          .entry(selectionRightToLeft()),
          .entry(selectionLeftToRight()),
        ]
      )
    }
  }
#endif
