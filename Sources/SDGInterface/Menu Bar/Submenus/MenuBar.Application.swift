/*
 MenuBar.Application.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

  internal let hidePreferences = Shared(true)

  extension MenuBar {
    internal static func about() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            let deLaAplicación =
              ProcessInfo.applicationName(.español(.de))
              ?? "de \(MenuBar.fallbackApplicationName(quotationMarks: ("«", "»")))"
            return "Acerca \(deLaAplicación)"
          case .englishUnitedKingdom:
            let theApplication =
              ProcessInfo.applicationName(.english(.unitedKingdom))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("‘", "’"))
            return "About \(theApplication)"
          case .englishUnitedStates:
            let theApplication =
              ProcessInfo.applicationName(.english(.unitedStates))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("“", "”"))
            return "About \(theApplication)"
          case .englishCanada:
            let theApplication =
              ProcessInfo.applicationName(.english(.canada))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("“", "”"))
            return "About \(theApplication)"
          case .deutschDeutschland:
            let dieAnwendung =
              ProcessInfo.applicationName(.deutsch(.akkusativ))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("„", "“"))
            return "Über \(dieAnwendung)"
          case .françaisFrance:
            let deLApplication =
              ProcessInfo.applicationName(.français(.de))
              ?? "de \(MenuBar.fallbackApplicationName(quotationMarks: ("« ", " »")))"
            return "À propos \(deLApplication)"
          case .ελληνικάΕλλάδα:
            let τηνΕφαρμογή =
              ProcessInfo.applicationName(.ελληνικά(.αιτιατική))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("«", "»"))
            return "Πληροφορίες για \(τηνΕφαρμογή)"
          case .עברית־ישראל:
            let היישום =
              (ProcessInfo.applicationName(.עברית)
                ?? MenuBar.fallbackApplicationName(quotationMarks: ("”", "“")))
            return "אותות \(היישום)"
          }
        }),
        selector: #selector(NSApplication.orderFrontStandardAboutPanel(_:))
      )
    }

    internal static func preferences() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Preferencias..."
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Preferences..."
          case .françaisFrance:
            return "Préférences..."

          case .deutschDeutschland:
            return "Einstellungen ..."
          case .ελληνικάΕλλάδα:
            return "Προτιμήσεις..."
          case .עברית־ישראל:
            return "העדפות..."
          }
        }),
        hotKeyModifiers: .command,
        hotKey: ",",
        selector: #selector(NSApplicationDelegateProtocol.openPreferences(_:)),
        isHidden: hidePreferences
      )
    }

    private static func services() -> Menu<MenuBarLocalization, EmptyMenuComponents> {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Servicios"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
            .françaisFrance:
            return "Services"
          case .deutschDeutschland:
            return "Dienste"
          case .ελληνικάΕλλάδα:
            return "Υπηρεσίες"
          case .עברית־ישראל:
            return "שירותים"
          }
        }),
        entries: {}
      )
    }

    internal static func hide() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            let laAplicación =
              ProcessInfo.applicationName(.español(.ninguna))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("«", "»"))
            return "Ocultar \(laAplicación)"
          case .englishUnitedKingdom:
            let theApplication =
              ProcessInfo.applicationName(.english(.unitedKingdom))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("‘", "’"))
            return "Hide \(theApplication)"
          case .englishUnitedStates:
            let theApplication =
              ProcessInfo.applicationName(.english(.unitedStates))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("“", "”"))
            return "Hide \(theApplication)"
          case .englishCanada:
            let theApplication =
              ProcessInfo.applicationName(.english(.canada))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("“", "”"))
            return "Hide \(theApplication)"
          case .deutschDeutschland:
            let dieAnwendung =
              ProcessInfo.applicationName(.deutsch(.akkusativ))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("„", "“"))
            return "\(dieAnwendung) ausblenden"
          case .françaisFrance:
            let lApplication =
              ProcessInfo.applicationName(.français(.aucune))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("« ", " »"))
            return "Masquer \(lApplication)"
          case .ελληνικάΕλλάδα:
            let τηςΕφαρμογής =
              ProcessInfo.applicationName(.ελληνικά(.γενική))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("«", "»"))
            return "Απόκρυψη \(τηςΕφαρμογής)"
          case .עברית־ישראל:
            let היישום =
              ProcessInfo.applicationName(.עברית)
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("”", "“"))
            return "הסתר את \(היישום)"
          }
        }),
        hotKeyModifiers: .command,
        hotKey: "h",
        selector: #selector(NSApplication.hide(_:))
      )
    }

    internal static func hideOthers() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Ocultar otros"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Hide Others"
          case .deutschDeutschland:
            return "Andere ausblenden"
          case .françaisFrance:
            return "Masquer les autres"
          case .ελληνικάΕλλάδα:
            return "Απόκρυψη άλλων"
          case .עברית־ישראל:
            return "הסתר אחרים"
          }
        }),
        hotKeyModifiers: [.option, .command],
        hotKey: "h",
        selector: #selector(NSApplication.hideOtherApplications(_:))
      )
    }

    internal static func showAll() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            return "Mostrar todo"
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Show All"
          case .deutschDeutschland:
            return "Alle einblenden"
          case .françaisFrance:
            return "Tout afficher"
          case .ελληνικάΕλλάδα:
            return "Εμφάνιση όλων"
          case .עברית־ישראל:
            return "הצג הכול"
          }
        }),
        selector: #selector(NSApplication.unhideAllApplications(_:))
      )
    }

    internal static func quit() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
          switch localization {
          case .españolEspaña:
            let deLaAplicación =
              ProcessInfo.applicationName(.español(.de))
              ?? "de \(MenuBar.fallbackApplicationName(quotationMarks: ("«", "»")))"
            return "Salir \(deLaAplicación)"

          case .englishUnitedKingdom:
            let theApplication =
              ProcessInfo.applicationName(.english(.unitedKingdom))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("‘", "’"))
            return "Quit \(theApplication)"
          case .englishUnitedStates:
            let theApplication =
              ProcessInfo.applicationName(.english(.unitedStates))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("“", "”"))
            return "Quit \(theApplication)"
          case .englishCanada:
            let theApplication =
              ProcessInfo.applicationName(.english(.canada))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("“", "”"))
            return "Quit \(theApplication)"
          case .françaisFrance:
            let lApplication =
              ProcessInfo.applicationName(.français(.aucune))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("« ", " »"))
            return "Quitter \(lApplication)"

          case .deutschDeutschland:
            let dieAnwendung =
              ProcessInfo.applicationName(.deutsch(.akkusativ))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("„", "“"))
            return "\(dieAnwendung) beenden"
          case .ελληνικάΕλλάδα:
            let τηςΕφαρμογής =
              ProcessInfo.applicationName(.ελληνικά(.γενική))
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("«", "»"))
            return "Τερματισμός \(τηςΕφαρμογής)"
          case .עברית־ישראל:
            let היישום =
              ProcessInfo.applicationName(.עברית)
              ?? MenuBar.fallbackApplicationName(quotationMarks: ("”", "“"))
            return "סיים את \(היישום)"
          }
        }),
        hotKeyModifiers: .command,
        hotKey: "q",
        selector: #selector(NSApplication.terminate(_:))
      )
    }

    internal static func application() -> Menu<
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
                        MenuComponentsConcatenation<MenuEntry<MenuBarLocalization>, Divider>,
                        MenuEntry<MenuBarLocalization>
                      >, Divider
                    >, Menu<MenuBarLocalization, EmptyMenuComponents>
                  >, Divider
                >, MenuEntry<MenuBarLocalization>
              >, MenuEntry<MenuBarLocalization>
            >, MenuEntry<MenuBarLocalization>
          >, Divider
        >, MenuEntry<MenuBarLocalization>
      >
    > {
      return Menu(
        label: ApplicationNameForm.localizedIsolatedForm,
        entries: {
            about()
            Divider()
            preferences()
            Divider()
            services()
            Divider()
            hide()
            hideOthers()
            showAll()
            Divider()
            quit()
        }
      )
    }
  }
#endif
