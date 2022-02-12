/*
 MenuBar.Help.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

  extension MenuBar {

    internal static func helpEntry() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            let deLaAplicación =
              ProcessInfo.applicationName(.español(.de))
              ?? "de \(MenuBar.fallbackApplicationName(quotationMarks: ("«", "»")))"
            return "Ayuda \(deLaAplicación)"
          case .françaisFrance:
            let deLApplication =
              ProcessInfo.applicationName(.français(.de))
              ?? "de \(MenuBar.fallbackApplicationName(quotationMarks: ("« ", " »")))"
            return "Aide \(deLApplication)"

          case .englishUnitedKingdom:
            let theApplication =
              ProcessInfo.applicationName(.english(.unitedKingdom))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("‘", "’"))
            return "\(theApplication) Help"
          case .englishUnitedStates:
            let theApplication =
              ProcessInfo.applicationName(.english(.unitedStates))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("“", "”"))
            return "\(theApplication) Help"
          case .englishCanada:
            let theApplication =
              ProcessInfo.applicationName(.english(.canada))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("“", "”"))
            return "\(theApplication) Help"
          case .deutschDeutschland:
            let derAnwendung =
              ProcessInfo.applicationName(.deutsch(.dativ))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("„", "“"))
            return "Hilfe zu \(derAnwendung)"

          case .ελληνικάΕλλάδα:
            let τηνΕφαρμογή =
              ProcessInfo.applicationName(.ελληνικά(.αιτιατική))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("«", "»"))
            return "Βοήθεια για \(τηνΕφαρμογή)"
          case .עברית־ישראל:
            let היישום =
              ProcessInfo.applicationName(.עברית)
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("”", "“"))
            return "עזרה עבור \(היישום)"
          }
        }),
        hotKeyModifiers: .command,
        hotKey: "?",
        selector: #selector(NSApplication.showHelp(_:)),
        isHidden: Shared(Bundle.main.infoDictionary?["CFBundleHelpBookName"] == nil)
      )
    }

    internal static func help() -> Menu<MenuBarLocalization, MenuEntry<MenuBarLocalization>> {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Ayuda"
          case .françaisFrance:
            return "Aide"

          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Help"
          case .deutschDeutschland:
            return "Hilfe"

          case .ελληνικάΕλλάδα:
            return "Βοήθεια"
          case .עברית־ישראל:
            return "עזרה"
          }
        }),
        entries: {
          helpEntry()
        }
      )
    }
  }
#endif
