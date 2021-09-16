/*
 SampleApplication.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_LACKS_FOUNDATION_PROCESS_INFO
  // @example(application)
  import Foundation

  import SDGText
  import SDGLocalization

  import SDGInterface

  #if !(os(iOS) && arch(arm))
    @available(macOS 11, tvOS 14, iOS 14, watchOS 7, *)
    extension SampleApplication: Application {}
  #endif

  @available(watchOS 6, *)
  public struct SampleApplication: LegacyApplication {

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

    public static func main() {  // @exempt(from: tests)
      #if os(iOS) && arch(arm)
        legacyMain()
      #else
        if #available(macOS 11, tvOS 14, iOS 14, watchOS 7, *) {
          modernMain()
        } else {
          legacyMain()
        }
      #endif
    }

    public var mainWindow: Window<Label<InterfaceLocalization>, InterfaceLocalization> {
      return Window(
        type: .primary(nil),
        name: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Sample"
          }
        }),
        content: Label(
          UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
              return "Hello, world!"
            }
          })
        )
      )
    }
  }
  // @endExample

  @available(watchOS 6, *)
  extension SampleApplication {

    // MARK: - Application

    public var preferences: Label<InterfaceLocalization> {
      return Label(
        UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Preferences"
          }
        })
      )
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
              MenuBar<EmptyCommands>.sample()
          }
        )
      }
    #endif

    public var remainsRunningWithNoWindows: Bool {  // @exempt(from: tests)
      return true
    }
  }
#endif
