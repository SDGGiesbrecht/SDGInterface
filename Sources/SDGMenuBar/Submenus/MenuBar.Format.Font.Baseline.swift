/*
 MenuBar.Format.Font.Baseline.swift

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

    private static func normal() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Valor por omisión"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Use Default"
          case .deutschDeutschland:
            return "Normal"
          case .françaisFrance:
            return "Valeur par défaut"
          case .ελληνικάΕλλάδα:
            return "Χρήση προεπιλογής"
          case .עברית־ישראל:
            return "השתמש בברירת המחדל"
          }
        }),
        selector: #selector(RichTextEditingResponder.resetBaseline(_:))
      )
    }

    private static func superscript() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Superíndice"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Superscript"
          case .deutschDeutschland:
            return "Hochgestellt"
          case .françaisFrance:
            return "Exposant"
          case .ελληνικάΕλλάδα:
            return "Εκθέτης"
          case .עברית־ישראל:
            return "כתב עילי"
          }
        }),
        selector: #selector(RichTextEditingResponder.makeSuperscript(_:))
      )
    }

    private static func `subscript`() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Subíndice"
          case .françaisFrance:
            return "Indice"

          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Subscript"
          case .deutschDeutschland:
            return "Tiefgestellt"
          case .ελληνικάΕλλάδα:
            return "Δεικτής"
          case .עברית־ישראל:
            return "כתב תחתי"
          }
        }),
        selector: #selector(RichTextEditingResponder.makeSubscript(_:))
      )
    }

    private static func raise() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Subir"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Raise"
          case .deutschDeutschland:
            return "Höher"
          case .françaisFrance:
            return "Élever"
          case .ελληνικάΕλλάδα:
            return "Ανύψωση"
          case .עברית־ישראל:
            return "הגבה"
          }
        }),
        selector: #selector(NSTextView.raiseBaseline(_:))
      )
    }

    private static func lower() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Bajar"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Lower"
          case .deutschDeutschland:
            return "Niedriger"
          case .françaisFrance:
            return "Abaisser"
          case .ελληνικάΕλλάδα:
            return "Χαμήλωμα"
          case .עברית־ישראל:
            return "נמוך יותר"
          }
        }),
        selector: #selector(NSTextView.lowerBaseline(_:))
      )
    }

    internal static func baseline() -> Menu<MenuBarLocalization> {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Línea base"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Baseline"
          case .françaisFrance:
            return "Ligne de base"

          case .deutschDeutschland:
            return "Schriftlinie"
          case .ελληνικάΕλλάδα:
            return "Γραμμή βάσης"
          case .עברית־ישראל:
            return "קו בסיס"
          }
        }),
        entries: [
          .entry(normal()),
          .entry(superscript()),
          .entry(`subscript`()),
          .entry(raise()),
          .entry(lower()),
        ]
      )
    }
  }
#endif
