/*
 MenuBar.Window.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

    private static func minimize() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "m",
        selector: #selector(NSWindow.performMiniaturize(_:))
      )
    }

    private static func zoom() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        selector: #selector(NSWindow.performZoom(_:))
      )
    }

    private static func bringAllToFront() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        selector: #selector(NSApplication.arrangeInFront(_:))
      )
    }

    internal static func window() -> Menu<
      MenuBarLocalization,
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
          >, Divider
        >, MenuEntry<MenuBarLocalization>
      >
    > {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        entries: {
          minimize()
          zoom()
          Divider()
          bringAllToFront()
        }
      )
    }
  }
#endif
