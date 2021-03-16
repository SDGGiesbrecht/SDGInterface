/*
 MenuBarSampleWindow.swift

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
  import SDGApplication

  import SDGInterfaceLocalizations

  extension MenuBar {

    private static func fullscreen() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Fullscreen"
          }
        }),
        selector: #selector(MenuBarTarget.demonstrateFullscreenWindow),
        target: MenuBarTarget.shared
      )
    }

    internal static func window() -> Menu<InterfaceLocalization, MenuEntry<InterfaceLocalization>> {
      return Menu(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Window"
          }
        }),
        entries: {
          MenuComponentsBuilder.buildBlock(
            fullscreen()
          )
        }
      )
    }
  }
#endif
