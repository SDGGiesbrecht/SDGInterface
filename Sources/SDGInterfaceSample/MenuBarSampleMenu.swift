/*
 MenuBarSampleMenu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import SDGText
  import SDGLocalization

  import SDGInterface

  import SDGInterfaceLocalizations

  extension MenuBar {

    private static func menuEntry() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Menu Entry"
          }
        }),
        action: {}
      )
    }

    private static func submenu() -> Menu<InterfaceLocalization, MenuEntry<InterfaceLocalization>> {
      return Menu(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Submenu"
          }
        }),
        entries: {
            menuEntry()
        }
      )
    }

    internal static func menu() -> Menu<
      InterfaceLocalization,
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<MenuEntry<InterfaceLocalization>, Divider>,
        Menu<InterfaceLocalization, MenuEntry<InterfaceLocalization>>
      >
    > {
      return Menu(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Menu"
          }
        }),
        entries: {
            menuEntry()
            Divider()
            submenu()
        }
      )
    }
  }
#endif
