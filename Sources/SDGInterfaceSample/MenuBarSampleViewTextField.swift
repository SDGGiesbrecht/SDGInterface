/*
 MenuBarSampleViewTextField.swift

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

  import SDGMenus
  import SDGMenuBar
  import SDGApplication

  import SDGInterfaceLocalizations

  extension MenuBar {

    private static func textFieldEntry() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Text Field"
          }
        }),
        action: #selector(MenuBarTarget.demonstrateTextField)
      )
      .target(MenuBarTarget.shared)
    }

    private static func labelledTextField() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Labelled Text Field"
          }
        }),
        action: #selector(MenuBarTarget.demonstrateLabelledTextField)
      )
      .target(MenuBarTarget.shared)
    }

    internal static func textField() -> Menu<InterfaceLocalization> {
      return Menu(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Text Field"
          }
        }),
        entries: [
          .entry(textFieldEntry()),
          .entry(labelledTextField()),
        ]
      )
    }
  }
#endif
