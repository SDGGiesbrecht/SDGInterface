/*
 MenuBarSample.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import ObjectiveC

  import SDGText
  import SDGLocalization

  import SDGMenus
  import SDGMenuBar
  import SDGApplication

  import SDGInterfaceLocalizations

  extension MenuBar {

    private static func error() -> MenuEntry<InterfaceLocalization> {
      let error = MenuEntry(
        label: .static(
          UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
              return "Error"
            }
          })
        )
      )
      error.action = #selector(Application.demonstrateError)
      error.target = Application.shared
      return error
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
