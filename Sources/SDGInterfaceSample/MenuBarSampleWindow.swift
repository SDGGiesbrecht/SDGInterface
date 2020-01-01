/*
 MenuBarSampleWindow.swift

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

    private static func fullscreen() -> MenuEntry<InterfaceLocalization> {
      let fullscreen = MenuEntry(
        label: .static(
          UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
              return "Fullscreen"
            }
          })
        )
      )
      fullscreen.action = #selector(Application.demonstrateFullscreenWindow)
      fullscreen.target = Application.shared
      return fullscreen
    }

    internal static func window() -> Menu<InterfaceLocalization> {
      let window = Menu(
        label: .static(
          UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
              return "Window"
            }
          })
        )
      )
      window.entries = [
        .entry(fullscreen())
      ]
      return window
    }
  }
#endif
