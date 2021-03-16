/*
 MenuBar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SwiftUI

  import SDGMathematics
  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

  /// An application’s menu bar.
  ///
  /// `MenuBar` is a fully localized version of Interface Builder’s template with several useful additions.
  ///
  /// Some menu items only appear if the application provides details they need to operate:
  /// - “Preferences...” appears if the application has a preference manager.
  /// - “Help” appears if a help book is specified in the `Info.plist` file.
  public struct MenuBar<ApplicationSpecificMenus>: MenuBarProtocol
  where ApplicationSpecificMenus: LegacyCommands {

    // MARK: - Initialization

    /// Creates a menu bar.
    ///
    /// - Parameters:
    ///   - applicationSpecificSubmenus: Application‐specific submenus to place before the “Window” menu.
    public init(
      applicationSpecificSubmenus: () -> ApplicationSpecificMenus
    ) {
      self.applicationSpecificSubmenus = applicationSpecificSubmenus()
    }

    // MARK: - Properties

    private let applicationSpecificSubmenus: ApplicationSpecificMenus

    private var menu:
      SDGInterface.Menu<
        InterfaceLocalization,
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<
                  MenuComponentsConcatenation<
                    MenuComponentsConcatenation<
                      SDGInterface.Menu<
                        ApplicationNameLocalization,
                        MenuComponentsConcatenation<
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<
                              MenuComponentsConcatenation<
                                MenuComponentsConcatenation<
                                  MenuComponentsConcatenation<
                                    MenuComponentsConcatenation<
                                      MenuComponentsConcatenation<
                                        MenuComponentsConcatenation<
                                          MenuComponentsConcatenation<
                                            MenuEntry<MenuBarLocalization>, SDGInterface.Divider
                                          >, MenuEntry<MenuBarLocalization>
                                        >, SDGInterface.Divider
                                      >, SDGInterface.Menu<MenuBarLocalization, EmptyMenuComponents>
                                    >, SDGInterface.Divider
                                  >, MenuEntry<MenuBarLocalization>
                                >, MenuEntry<MenuBarLocalization>
                              >, MenuEntry<MenuBarLocalization>
                            >, SDGInterface.Divider
                          >, MenuEntry<MenuBarLocalization>
                        >
                      >,
                      SDGInterface.Menu<
                        MenuBarLocalization,
                        MenuComponentsConcatenation<
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<
                              MenuComponentsConcatenation<
                                MenuComponentsConcatenation<
                                  MenuComponentsConcatenation<
                                    MenuComponentsConcatenation<
                                      MenuComponentsConcatenation<
                                        MenuComponentsConcatenation<
                                          MenuComponentsConcatenation<
                                            MenuComponentsConcatenation<
                                              MenuComponentsConcatenation<
                                                MenuEntry<MenuBarLocalization>,
                                                MenuEntry<MenuBarLocalization>
                                              >,
                                              SDGInterface.Menu<
                                                MenuBarLocalization, MenuEntry<MenuBarLocalization>
                                              >
                                            >, SDGInterface.Divider
                                          >, MenuEntry<MenuBarLocalization>
                                        >, MenuEntry<MenuBarLocalization>
                                      >, MenuEntry<MenuBarLocalization>
                                    >, MenuEntry<MenuBarLocalization>
                                  >, MenuEntry<MenuBarLocalization>
                                >, MenuEntry<InterfaceLocalization>
                              >, SDGInterface.Divider
                            >, MenuEntry<MenuBarLocalization>
                          >, MenuEntry<MenuBarLocalization>
                        >
                      >
                    >,
                    SDGInterface.Menu<
                      MenuBarLocalization,
                      MenuComponentsConcatenation<
                        MenuComponentsConcatenation<
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<
                              MenuComponentsConcatenation<
                                MenuComponentsConcatenation<
                                  MenuComponentsConcatenation<
                                    MenuComponentsConcatenation<
                                      MenuComponentsConcatenation<
                                        MenuComponentsConcatenation<
                                          MenuComponentsConcatenation<
                                            MenuComponentsConcatenation<
                                              MenuComponentsConcatenation<
                                                MenuComponentsConcatenation<
                                                  MenuComponentsConcatenation<
                                                    MenuEntry<MenuBarLocalization>,
                                                    MenuEntry<MenuBarLocalization>
                                                  >, SDGInterface.Divider
                                                >, MenuEntry<MenuBarLocalization>
                                              >, MenuEntry<MenuBarLocalization>
                                            >, MenuEntry<MenuBarLocalization>
                                          >, MenuEntry<MenuBarLocalization>
                                        >, MenuEntry<MenuBarLocalization>
                                      >, MenuEntry<MenuBarLocalization>
                                    >, SDGInterface.Divider
                                  >,
                                  SDGInterface.Menu<
                                    MenuBarLocalization,
                                    MenuComponentsConcatenation<
                                      MenuComponentsConcatenation<
                                        MenuComponentsConcatenation<
                                          MenuComponentsConcatenation<
                                            MenuComponentsConcatenation<
                                              MenuEntry<MenuBarLocalization>,
                                              MenuEntry<MenuBarLocalization>
                                            >, MenuEntry<MenuBarLocalization>
                                          >, MenuEntry<MenuBarLocalization>
                                        >, MenuEntry<MenuBarLocalization>
                                      >, MenuEntry<MenuBarLocalization>
                                    >
                                  >
                                >,
                                SDGInterface.Menu<
                                  MenuBarLocalization,
                                  MenuComponentsConcatenation<
                                    MenuComponentsConcatenation<
                                      MenuComponentsConcatenation<
                                        MenuComponentsConcatenation<
                                          MenuComponentsConcatenation<
                                            MenuEntry<MenuBarLocalization>,
                                            MenuEntry<MenuBarLocalization>
                                          >, SDGInterface.Divider
                                        >, MenuEntry<MenuBarLocalization>
                                      >, MenuEntry<MenuBarLocalization>
                                    >, MenuEntry<MenuBarLocalization>
                                  >
                                >
                              >,
                              SDGInterface.Menu<
                                MenuBarLocalization,
                                MenuComponentsConcatenation<
                                  MenuComponentsConcatenation<
                                    MenuComponentsConcatenation<
                                      MenuComponentsConcatenation<
                                        MenuComponentsConcatenation<
                                          MenuComponentsConcatenation<
                                            MenuComponentsConcatenation<
                                              MenuEntry<MenuBarLocalization>, SDGInterface.Divider
                                            >, MenuEntry<MenuBarLocalization>
                                          >, MenuEntry<MenuBarLocalization>
                                        >, MenuEntry<MenuBarLocalization>
                                      >, MenuEntry<MenuBarLocalization>
                                    >, MenuEntry<MenuBarLocalization>
                                  >, MenuEntry<MenuBarLocalization>
                                >
                              >
                            >,
                            SDGInterface.Menu<MenuBarLocalization, MenuEntry<InterfaceLocalization>>
                          >, MenuEntry<InterfaceLocalization>
                        >,
                        SDGInterface.Menu<
                          MenuBarLocalization,
                          MenuComponentsConcatenation<
                            MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                          >
                        >
                      >
                    >
                  >,
                  SDGInterface.Menu<
                    MenuBarLocalization,
                    MenuComponentsConcatenation<
                      SDGInterface.Menu<
                        MenuBarLocalization,
                        MenuComponentsConcatenation<
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<
                              MenuComponentsConcatenation<
                                MenuComponentsConcatenation<
                                  MenuComponentsConcatenation<
                                    MenuComponentsConcatenation<
                                      MenuComponentsConcatenation<
                                        MenuComponentsConcatenation<
                                          MenuComponentsConcatenation<
                                            MenuComponentsConcatenation<
                                              MenuComponentsConcatenation<
                                                MenuComponentsConcatenation<
                                                  MenuComponentsConcatenation<
                                                    MenuComponentsConcatenation<
                                                      MenuComponentsConcatenation<
                                                        MenuEntry<MenuBarLocalization>,
                                                        MenuEntry<MenuBarLocalization>
                                                      >, MenuEntry<MenuBarLocalization>
                                                    >, MenuEntry<MenuBarLocalization>
                                                  >, SDGInterface.Divider
                                                >, MenuEntry<MenuBarLocalization>
                                              >, MenuEntry<MenuBarLocalization>
                                            >, SDGInterface.Divider
                                          >,
                                          SDGInterface.Menu<
                                            MenuBarLocalization,
                                            MenuComponentsConcatenation<
                                              MenuComponentsConcatenation<
                                                MenuComponentsConcatenation<
                                                  MenuEntry<MenuBarLocalization>,
                                                  MenuEntry<MenuBarLocalization>
                                                >, MenuEntry<MenuBarLocalization>
                                              >, MenuEntry<MenuBarLocalization>
                                            >
                                          >
                                        >,
                                        SDGInterface.Menu<
                                          MenuBarLocalization,
                                          MenuComponentsConcatenation<
                                            MenuComponentsConcatenation<
                                              MenuEntry<MenuBarLocalization>,
                                              MenuEntry<MenuBarLocalization>
                                            >, MenuEntry<MenuBarLocalization>
                                          >
                                        >
                                      >,
                                      SDGInterface.Menu<
                                        MenuBarLocalization,
                                        MenuComponentsConcatenation<
                                          MenuComponentsConcatenation<
                                            MenuComponentsConcatenation<
                                              MenuComponentsConcatenation<
                                                MenuEntry<MenuBarLocalization>,
                                                MenuEntry<MenuBarLocalization>
                                              >, MenuEntry<MenuBarLocalization>
                                            >, MenuEntry<MenuBarLocalization>
                                          >, MenuEntry<MenuBarLocalization>
                                        >
                                      >
                                    >,
                                    SDGInterface.Menu<
                                      InterfaceLocalization,
                                      MenuComponentsConcatenation<
                                        MenuComponentsConcatenation<
                                          MenuComponentsConcatenation<
                                            MenuEntry<InterfaceLocalization>,
                                            MenuEntry<InterfaceLocalization>
                                          >, MenuEntry<InterfaceLocalization>
                                        >, MenuEntry<InterfaceLocalization>
                                      >
                                    >
                                  >, SDGInterface.Divider
                                >, MenuEntry<MenuBarLocalization>
                              >, SDGInterface.Divider
                            >, MenuEntry<MenuBarLocalization>
                          >, MenuEntry<MenuBarLocalization>
                        >
                      >,
                      SDGInterface.Menu<
                        MenuBarLocalization,
                        MenuComponentsConcatenation<
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<
                              MenuComponentsConcatenation<
                                MenuComponentsConcatenation<
                                  MenuComponentsConcatenation<
                                    MenuComponentsConcatenation<
                                      MenuComponentsConcatenation<
                                        MenuComponentsConcatenation<
                                          MenuEntry<MenuBarLocalization>,
                                          MenuEntry<MenuBarLocalization>
                                        >, MenuEntry<MenuBarLocalization>
                                      >, MenuEntry<MenuBarLocalization>
                                    >, SDGInterface.Divider
                                  >,
                                  SDGInterface.Menu<
                                    MenuBarLocalization,
                                    MenuComponentsConcatenation<
                                      SDGInterface.Menu<
                                        MenuBarLocalization,
                                        MenuComponentsConcatenation<
                                          MenuComponentsConcatenation<
                                            MenuEntry<MenuBarLocalization>,
                                            MenuEntry<MenuBarLocalization>
                                          >, MenuEntry<MenuBarLocalization>
                                        >
                                      >,
                                      SDGInterface.Menu<
                                        MenuBarLocalization,
                                        MenuComponentsConcatenation<
                                          MenuComponentsConcatenation<
                                            MenuEntry<MenuBarLocalization>,
                                            MenuEntry<MenuBarLocalization>
                                          >, MenuEntry<MenuBarLocalization>
                                        >
                                      >
                                    >
                                  >
                                >, SDGInterface.Divider
                              >, MenuEntry<MenuBarLocalization>
                            >, MenuEntry<MenuBarLocalization>
                          >, MenuEntry<MenuBarLocalization>
                        >
                      >
                    >
                  >
                >,
                SDGInterface.Menu<
                  MenuBarLocalization,
                  MenuComponentsConcatenation<
                    MenuComponentsConcatenation<
                      MenuComponentsConcatenation<
                        MenuComponentsConcatenation<
                          MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                        >, SDGInterface.Divider
                      >, MenuEntry<MenuBarLocalization>
                    >, MenuEntry<MenuBarLocalization>
                  >
                >
              >, ApplicationSpecificMenus.MenuComponentsType
            >,
            SDGInterface.Menu<
              MenuBarLocalization,
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<
                  MenuComponentsConcatenation<
                    MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                  >, SDGInterface.Divider
                >, MenuEntry<MenuBarLocalization>
              >
            >
          >, SDGInterface.Menu<MenuBarLocalization, MenuEntry<MenuBarLocalization>>
        >
      >
    {
      return Menu(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Menu Bar"
          case .deutschDeutschland:
            return "Menüleiste"
          }
        }),
        entries: {
          MenuComponentsBuilder.buildBlock(
            MenuBar.application(),
            MenuBar.file(),
            MenuBar.edit(),
            MenuBar.format(),
            MenuBar.view(),
            applicationSpecificSubmenus.menuComponents(),
            MenuBar.window(),
            MenuBar.help()
          )
        }
      )
    }

    /// The menu bar as an `NSMenu`.
    public func cocoa() -> NSMenu {
      return menu.cocoaMenu()
    }

    // MARK: - Items

    internal static func fallbackApplicationName(
      quotationMarks: (leading: StrictString, trailing: StrictString)
    ) -> StrictString {
      var result = quotationMarks.leading
      result.append("\u{2068}")
      result.append(contentsOf: ApplicationNameForm.localizedIsolatedForm.resolved())
      result.append("\u{2069}")
      result.append(contentsOf: quotationMarks.trailing)
      return result
    }
  }

  @available(macOS 11, *)
  extension MenuBar where ApplicationSpecificMenus: SDGInterface.Commands {

    /// Generates a SwiftUI representation of the application‐specific menus.
    @SwiftUI.CommandsBuilder public func swiftUI() -> some SwiftUI.Commands {

      CommandGroup(replacing: .appInfo) {
        MenuBar<SDGInterface.EmptyCommands>.about().swiftUI()
      }

      CommandGroup(replacing: .appSettings) {
        MenuBar<SDGInterface.EmptyCommands>.preferences().swiftUI()
      }

      CommandGroup(replacing: .appVisibility) {
        MenuBar<SDGInterface.EmptyCommands>.hide().swiftUI()
        MenuBar<SDGInterface.EmptyCommands>.hideOthers().swiftUI()
        MenuBar<SDGInterface.EmptyCommands>.showAll().swiftUI()
      }

      CommandGroup(replacing: .appTermination) {
        MenuBar<SDGInterface.EmptyCommands>.quit().swiftUI()
      }

      CommandGroup(replacing: .printItem) {
        MenuBar<SDGInterface.EmptyCommands>.pageSetUp().swiftUI()
        MenuBar<SDGInterface.EmptyCommands>.print().swiftUI()
      }

      CommandGroup(replacing: .pasteboard) {
        Group {
          MenuBar<SDGInterface.EmptyCommands>.cut().swiftUI()
          MenuBar<SDGInterface.EmptyCommands>.copy().swiftUI()
          MenuBar<SDGInterface.EmptyCommands>.paste().swiftUI()
          MenuBar<SDGInterface.EmptyCommands>.pasteAndMatchStyle().swiftUI()
          MenuBar<SDGInterface.EmptyCommands>.delete().swiftUI()
          MenuBar<SDGInterface.EmptyCommands>.selectAll().swiftUI()
        }
        Group {
          Divider().swiftUI()
          MenuBar<SDGInterface.EmptyCommands>.find().swiftUI()
          MenuBar<SDGInterface.EmptyCommands>.spellingAndGrammar().swiftUI()
          MenuBar<SDGInterface.EmptyCommands>.substitutions().swiftUI()
          MenuBar<SDGInterface.EmptyCommands>.transformations().swiftUI()
          ContextMenu.showCharacterInformation().swiftUI()
        }
      }

      applicationSpecificSubmenus.swiftUICommands()
    }
  }
#endif
