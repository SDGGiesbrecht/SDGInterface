/*
 MenuBar.Format.swift

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

    internal static func format() -> Menu<
      MenuBarLocalization,
      MenuComponentsConcatenation<
        Menu<
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
                                    >, Divider
                                  >, MenuEntry<MenuBarLocalization>
                                >, MenuEntry<MenuBarLocalization>
                              >, Divider
                            >,
                            Menu<
                              MenuBarLocalization,
                              MenuComponentsConcatenation<
                                MenuComponentsConcatenation<
                                  MenuComponentsConcatenation<
                                    MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                                  >, MenuEntry<MenuBarLocalization>
                                >, MenuEntry<MenuBarLocalization>
                              >
                            >
                          >,
                          Menu<
                            MenuBarLocalization,
                            MenuComponentsConcatenation<
                              MenuComponentsConcatenation<
                                MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                              >, MenuEntry<MenuBarLocalization>
                            >
                          >
                        >,
                        Menu<
                          MenuBarLocalization,
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<
                              MenuComponentsConcatenation<
                                MenuComponentsConcatenation<
                                  MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                                >, MenuEntry<MenuBarLocalization>
                              >, MenuEntry<MenuBarLocalization>
                            >, MenuEntry<MenuBarLocalization>
                          >
                        >
                      >,
                      Menu<
                        InterfaceLocalization,
                        MenuComponentsConcatenation<
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<
                              MenuEntry<InterfaceLocalization>, MenuEntry<InterfaceLocalization>
                            >, MenuEntry<InterfaceLocalization>
                          >, MenuEntry<InterfaceLocalization>
                        >
                      >
                    >, Divider
                  >, MenuEntry<MenuBarLocalization>
                >, Divider
              >, MenuEntry<MenuBarLocalization>
            >, MenuEntry<MenuBarLocalization>
          >
        >,
        Menu<
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
                            MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                          >, MenuEntry<MenuBarLocalization>
                        >, MenuEntry<MenuBarLocalization>
                      >, Divider
                    >,
                    Menu<
                      MenuBarLocalization,
                      MenuComponentsConcatenation<
                        Menu<
                          MenuBarLocalization,
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<
                              MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                            >, MenuEntry<MenuBarLocalization>
                          >
                        >,
                        Menu<
                          MenuBarLocalization,
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<
                              MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                            >, MenuEntry<MenuBarLocalization>
                          >
                        >
                      >
                    >
                  >, Divider
                >, MenuEntry<MenuBarLocalization>
              >, MenuEntry<MenuBarLocalization>
            >, MenuEntry<MenuBarLocalization>
          >
        >
      >
    > {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Formato"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
            .deutschDeutschland,
            .françaisFrance:
            return "Format"

          case .עברית־ישראל:
            return "עיצוב"
          case .ελληνικάΕλλάδα:
            return "Μορφή"
          }
        }),
        entries: {
          font()
          text()
        }
      )
    }
  }
#endif
