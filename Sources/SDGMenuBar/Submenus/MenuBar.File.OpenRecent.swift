/*
 MenuBar.File.OpenRecent.swift

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

    private static func clearMenu() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Vaciar menú"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Clear Menu"
          case .deutschDeutschland:
            return "Einträge löschen"
          case .françaisFrance:
            return "Effacer le menu"
          case .ελληνικάΕλλάδα:
            return "Εκκαθάριση μενού"
          case .עברית־ישראל:
            return "נקה תפריט"
          }
        }),
        action: #selector(NSDocumentController.clearRecentDocuments(_:))
      )
    }

    internal static func openRecent() -> Menu<MenuBarLocalization> {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Abrir recientes"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Open Recent"
          case .deutschDeutschland:
            return "Benutzte Dokumente"
          case .françaisFrance:
            return "Ouvrir l’élément récent"
          case .ελληνικάΕλλάδα:
            return "Άνοιγμα προσφάτου"
          case .עברית־ישראל:
            return "פתח אחרונים"
          }
        }),
        entries: [
          .entry(clearMenu())
        ]
      )
    }
  }
#endif
