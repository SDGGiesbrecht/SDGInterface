/*
 SampleApplication.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.2, Web lacks ProcessInfo.)
#if !os(WASI)
  // @example(application)
  import Foundation

  import SDGText
  import SDGLocalization

  import SDGInterface

  public struct SampleApplication: LegacyApplication /* or Application */ {

    public init() {}

    public var applicationName: ProcessInfo.ApplicationNameResolver {
      return { form in
        switch form {
        case .english(let region):
          switch region {
          case .unitedKingdom, .unitedStates, .canada:
            return "Sample"
          }
        case .español(let preposición):
          switch preposición {
          case .ninguna:
            return "Ejemplar"
          case .de:
            return "del Ejemplar"
          }
        case .deutsch(let fall):
          switch fall {
          case .nominativ, .akkusativ, .dativ:
            return "Beispiel"
          }
        case .français(let préposition):
          switch préposition {
          case .aucune:
            return "Exemple"
          case .de:
            return "de l’Exemple"
          }

        case .ελληνικά(let πτώση):
          switch πτώση {
          case .ονομαστική:
            return "Παράδειγμα"
          case .αιτιατική:
            return "το Παράδειγμα"
          case .γενική:
            return "του Παραδείγματος"
          }
        case .עברית:
          return "דוגמה"
        }
      }
    }

    public var applicationIdentifier: String {
      return "com.example.SampleApplication"
    }

    public func finishLaunching(_ details: LaunchDetails) -> Bool {
      Swift.print("Hello, world!")
      return true
    }
  }
  // @endExample

  extension SampleApplication {

    // MARK: - Application

    public var preferenceManager: SDGInterface.PreferenceManager? {
      return PreferenceManager()
    }

    // MARK: - SystemInterface

    #if canImport(AppKit)
      public var menuBar:
        MenuBar<
          Menu<
            InterfaceLocalization,
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<
                  MenuEntry<InterfaceLocalization>,
                  Menu<
                    InterfaceLocalization,
                    MenuComponentsConcatenation<
                      MenuComponentsConcatenation<MenuEntry<InterfaceLocalization>, Divider>,
                      Menu<InterfaceLocalization, MenuEntry<InterfaceLocalization>>
                    >
                  >
                >,
                Menu<
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
                >
              >, Menu<InterfaceLocalization, MenuEntry<InterfaceLocalization>>
            >
          >
        >
      {
        return MenuBar(
          applicationSpecificSubmenus: {
            return CommandsBuilder.buildBlock(
              MenuBar<EmptyCommands>.sample()
            )
          }
        )
      }
    #endif

    public var remainsRunningWithNoWindows: Bool {  // @exempt(from: tests)
      return true
    }
  }
#endif
