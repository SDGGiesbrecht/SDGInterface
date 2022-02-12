/*
 MenuBarSampleView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import ObjectiveC

  import SDGText
  import SDGLocalization

  import SDGInterface

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
        selector: #selector(MenuBarTarget.demonstrateButton),
        target: MenuBarTarget.shared
      )
    }

    private static func buttonSet() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Radio Buttons"
          }
        }),
        selector: #selector(MenuBarTarget.demonstrateSegmentedControl),
        target: MenuBarTarget.shared
      )
    }

    private static func checkBox() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Check Box"
          }
        }),
        selector: #selector(MenuBarTarget.demonstrateCheckBox),
        target: MenuBarTarget.shared
      )
    }

    private static func image() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Image"
          }
        }),
        selector: #selector(MenuBarTarget.demonstrateImage),
        target: MenuBarTarget.shared
      )
    }

    private static func label() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Label"
          }
        }),
        selector: #selector(MenuBarTarget.demonstrateLabel),
        target: MenuBarTarget.shared
      )
    }

    private static func log() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Log"
          }
        }),
        selector: #selector(MenuBarTarget.demonstrateLog),
        target: MenuBarTarget.shared
      )
    }

    private static func textEditor() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Text Editor"
          }
        }),
        selector: #selector(MenuBarTarget.demonstrateTextEditor),
        target: MenuBarTarget.shared
      )
    }

    internal static func view() -> Menu<
      InterfaceLocalization,
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<
                  MenuComponentsConcatenation<
                    MenuEntry<InterfaceLocalization>, MenuEntry<InterfaceLocalization>
                  >, MenuEntry<InterfaceLocalization>
                >, MenuEntry<InterfaceLocalization>
              >, MenuEntry<InterfaceLocalization>
            >, MenuEntry<InterfaceLocalization>
          >, MenuEntry<InterfaceLocalization>
        >,
        Menu<
          InterfaceLocalization,
          MenuComponentsConcatenation<
            MenuEntry<InterfaceLocalization>, MenuEntry<InterfaceLocalization>
          >
        >
      >
    > {
      return Menu(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "View"
          }
        }),
        entries: {
          button()
          buttonSet()
          checkBox()
          image()
          label()
          log()
          textEditor()
          textField()
        }
      )
    }
  }
#endif
