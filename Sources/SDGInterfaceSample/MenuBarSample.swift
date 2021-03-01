/*
 MenuBarSample.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import ObjectiveC

  import SDGText
  import SDGLocalization

  import SDGInterface
  import SDGMenuBar
  import SDGApplication

  import SDGInterfaceLocalizations

  extension MenuBar {

    private static func error() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Error"
          }
        }),
        action: #selector(MenuBarTarget.demonstrateError).action(target: MenuBarTarget.shared)
      )
    }

    internal static func sample() -> Menu<InterfaceLocalization> {
      return Menu(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Sample"
          }
        }),
        entries: [
          .entry(error()),
          .submenu(menu()),
          .submenu(view()),
          .submenu(window()),
        ]
      )
    }
  }
#endif
