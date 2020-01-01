/*
 MenuBarWindow.swift

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

    private static func minimize() -> MenuEntry<MenuBarLocalization> {
      let minimize = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
              return "Minimizar"
            case .englishUnitedKingdom:
              return "Minimise"
            case .englishUnitedStates, .englishCanada:
              return "Minimize"
            case .deutschDeutschland:
              return "Im Dock ablegen"
            case .françaisFrance:
              return "Placer dans le Dock"
            case .ελληνικάΕλλάδα:
              return "Ελαχιστοποίηση"
            case .עברית־ישראל:
              return "מזער"
            }
          })
        )
      )
      minimize.action = #selector(NSWindow.performMiniaturize(_:))
      minimize.hotKey = "m"
      minimize.hotKeyModifiers = .command
      return minimize
    }

    private static func zoom() -> MenuEntry<MenuBarLocalization> {
      let zoom = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña,
              .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Zoom"
            case .deutschDeutschland:
              return "Zoomen"
            case .ελληνικάΕλλάδα:
              return "Ζουμ"

            case .françaisFrance:
              return "Réduire/agrandir"
            case .עברית־ישראל:
              return "הגדל/הקטן"
            }
          })
        )
      )
      zoom.action = #selector(NSWindow.performZoom(_:))
      return zoom
    }

    private static func bringAllToFront() -> MenuEntry<MenuBarLocalization> {
      let bringAllToFront = MenuEntry(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
              return "Traer todo al frente"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Bring All to Front"
            case .deutschDeutschland:
              return "Alle nach vorne bringen"
            case .françaisFrance:
              return "Tout ramener au premier plan"
            case .ελληνικάΕλλάδα:
              return "Μεταφωρά όλων σε πρώτο πλάνο"
            case .עברית־ישראל:
              return "הבא הכל קדימה"
            }
          })
        )
      )
      bringAllToFront.action = #selector(NSApplication.arrangeInFront(_:))
      return bringAllToFront
    }

    internal static func window() -> Menu<MenuBarLocalization> {
      let window = Menu(
        label: .static(
          UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
              return "Ventana"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Window"

            case .deutschDeutschland:
              return "Fenster"
            case .françaisFrance:
              return "Fenêtre"

            case .ελληνικάΕλλάδα:
              return "Παράθυρο"
            case .עברית־ישראל:
              return "חלון"
            }
          })
        )
      )
      window.entries = [
        .entry(minimize()),
        .entry(zoom()),
        .separator,
        .entry(bringAllToFront())
      ]
      NSApplication.shared.windowsMenu = window.native
      return window
    }
  }
#endif
