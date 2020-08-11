/*
 MenuBarSampleMenu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import SDGText
  import SDGLocalization

  import SDGMenus
  import SDGMenuBar

  import SDGInterfaceLocalizations

  extension MenuBar {

    private static func menuEntry() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Menu Entry"
          }
        })
      )
    }

    private static func submenu() -> Menu<InterfaceLocalization> {
      return Menu(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Submenu"
          }
        }),
        entries: [
          .entry(menuEntry())
        ]
      )
    }

    internal static func menu() -> Menu<InterfaceLocalization> {
      return Menu(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Menu"
          }
        }),
        entries: [
          .entry(menuEntry()),
          .separator,
          .submenu(submenu()),
        ]
      )
    }
  }
#endif
