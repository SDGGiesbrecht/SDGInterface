/*
 MenuBar.Format.Font.Ligatures.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

    private static func useDefault() -> MenuEntry<MenuBarLocalization> {
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
        selector: #selector(NSTextView.useStandardLigatures(_:))
      )
    }

    private static func useNone() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Ninguna"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Use None"
          case .deutschDeutschland:
            return "Nicht verwenden"
          case .françaisFrance:
            return "Aucune"
          case .ελληνικάΕλλάδα:
            return "Κανένα"
          case .עברית־ישראל:
            return "אל תשתמש בשום אפשרות"
          }
        }),
        selector: #selector(NSTextView.turnOffLigatures(_:))
      )
    }

    private static func useAll() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Todas"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Use All"
          case .deutschDeutschland:
            return "Alle verwenden"
          case .françaisFrance:
            return "Toutes"
          case .ελληνικάΕλλάδα:
            return "Χρήση όλων"
          case .עברית־ישראל:
            return "השתמש בכולם"
          }
        }),
        selector: #selector(NSTextView.useAllLigatures(_:))
      )
    }

    internal static func ligatures() -> Menu<
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
            return "Ligaduras"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
            .françaisFrance:
            return "Ligatures"
          case .deutschDeutschland:
            return "Ligaturen"

          case .ελληνικάΕλλάδα:
            return "Συμπλέγματα"
          case .עברית־ישראל:
            return "משלבי אותיות"
          }
        }),
        entries: {
          useDefault()
          useNone()
          useAll()
        }
      )
    }
  }
#endif
