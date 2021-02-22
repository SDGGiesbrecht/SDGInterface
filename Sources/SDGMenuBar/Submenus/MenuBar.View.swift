/*
 MenuBar.View.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SDGText
  import SDGLocalization

  import SDGInterface

  import SDGInterfaceLocalizations

  extension MenuBar {

    private static func showToolbar() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Mostrar barra de herramientas"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Show Toolbar"
          case .deutschDeutschland:
            return "Symbolleiste einblenden"
          case .françaisFrance:
            return "Afficher la barre d’outils"
          case .ελληνικάΕλλάδα:
            return "Εμφάνιση γραμμής εργαλείων"
          case .עברית־ישראל:
            return "הצג את סרגל הכלים"
          }
        }),
        hotKeyModifiers: [.command, .option],
        hotKey: "t",
        action: #selector(NSWindow.toggleToolbarShown(_:))
      )
    }

    private static func customizeToolbar() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Personalizar barra de herramientas..."
          case .englishUnitedKingdom:
            return "Customise Toolbar..."
          case .englishUnitedStates, .englishCanada:
            return "Customize Toolbar..."
          case .deutschDeutschland:
            return "Symbolleiste anpassen ..."
          case .françaisFrance:
            return "Personnaliser la barre d’outils..."
          case .ελληνικάΕλλάδα:
            return "Προσαρμογή γραμμής εργαλείων..."
          case .עברית־ישראל:
            return "התאמה אישית של סרגל הכלים..."
          }
        }),
        action: #selector(NSWindow.runToolbarCustomizationPalette(_:))
      )
    }

    private static func showSideBar() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Mostrar barra lateral"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Show Side Bar"
          case .deutschDeutschland:
            return "Seitenleiste einblenden"
          case .françaisFrance:
            return "Afficher la barre latérale"
          case .ελληνικάΕλλάδα:
            return "Εμφάνιση πλαϊνής στήλης"
          case .עברית־ישראל:
            return "הצג את סרגל הצד"
          }
        }),
        hotKeyModifiers: [.command, .control],
        hotKey: "s",
        action: Selector.toggleSourceList
      )
    }

    private static func enterFullScreen() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Usar pantalla completa"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Enter Full Screen"
          case .deutschDeutschland:
            return "Vollbild ein"
          case .françaisFrance:
            return "Activer le mode plein écran"
          case .ελληνικάΕλλάδα:
            return "Είσοδος σε πλήρη οθόνη"
          case .עברית־ישראל:
            return "עבור למסך מלא"
          }
        }),
        hotKeyModifiers: [.command, .control],
        hotKey: "f",
        action: #selector(NSWindow.toggleFullScreen(_:))
      )
    }

    internal static func view() -> Menu<MenuBarLocalization> {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Visualización"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "View"
          case .deutschDeutschland:
            return "Darstellung"
          case .françaisFrance:
            return "Présentation"
          case .ελληνικάΕλλάδα:
            return "Προβολή"
          case .עברית־ישראל:
            return "תצוגה"
          }
        }),
        entries: [
          .entry(showToolbar()),
          .entry(customizeToolbar()),
          .separator,
          .entry(showSideBar()),
          .entry(enterFullScreen()),
        ]
      )
    }
  }
#endif
