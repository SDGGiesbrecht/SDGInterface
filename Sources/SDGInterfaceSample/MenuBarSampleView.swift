/*
 MenuBarSampleView.swift

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

    private static func button() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Button"
          }
        }),
        action: #selector(Application.demonstrateButton)
      )
      .target(Application.shared)
    }

    private static func buttonSet() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Radio Buttons"
          }
        }),
        action: #selector(Application.demonstrateSegmentedControl)
      )
      .target(Application.shared)
    }

    private static func checkBox() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Check Box"
          }
        }),
        action: #selector(Application.demonstrateCheckBox)
      )
      .target(Application.shared)
    }

    private static func image() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Image"
          }
        }),
        action: #selector(Application.demonstrateImage)
      )
      .target(Application.shared)
    }

    private static func label() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Label"
          }
        }),
        action: #selector(Application.demonstrateLabel)
      )
      .target(Application.shared)
    }

    private static func textEditor() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Text Editor"
          }
        }),
        action: #selector(Application.demonstrateTextEditor)
      )
      .target(Application.shared)
    }

    internal static func view() -> Menu<InterfaceLocalization> {
      return Menu(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "View"
          }
        }),
        entries: [
          .entry(button()),
          .entry(buttonSet()),
          .entry(checkBox()),
          .entry(image()),
          .entry(label()),
          .entry(textEditor()),
          .submenu(textField()),
        ]
      )
    }
  }
#endif
