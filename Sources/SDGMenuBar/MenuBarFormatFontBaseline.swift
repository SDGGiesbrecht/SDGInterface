/*
 MenuBarFormatFontBaseline.swift

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

  import SDGInterfaceBasics
  import SDGMenus

  import SDGInterfaceLocalizations

  extension MenuBar {

    private static func normal() -> MenuEntry<MenuBarLocalization> {
      let normal = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
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
          })
        )
      )
      normal.action = #selector(RichTextEditingResponder.resetBaseline(_:))
      return normal
    }

    private static func superscript() -> MenuEntry<MenuBarLocalization> {
      let superscript = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
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
          })
        )
      )
      superscript.action = #selector(RichTextEditingResponder.makeSuperscript(_:))
      return superscript
    }

    private static func `subscript`() -> MenuEntry<MenuBarLocalization> {
      let `subscript` = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
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
          })
        )
      )
      `subscript`.action = #selector(RichTextEditingResponder.makeSubscript(_:))
      return `subscript`
    }

    private static func raise() -> MenuEntry<MenuBarLocalization> {
      let raise = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
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
          })
        )
      )
      raise.action = #selector(NSTextView.raiseBaseline(_:))
      return raise
    }

    private static func lower() -> MenuEntry<MenuBarLocalization> {
      let lower = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
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
          })
        )
      )
      lower.action = #selector(NSTextView.lowerBaseline(_:))
      return lower
    }

    internal static func baseline() -> Menu<MenuBarLocalization> {
      let baseline = Menu(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
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
          })
        )
      )
      baseline.entries = [
        .entry(normal()),
        .entry(superscript()),
        .entry(`subscript`()),
        .entry(raise()),
        .entry(lower()),
      ]
      return baseline
    }
  }
#endif
