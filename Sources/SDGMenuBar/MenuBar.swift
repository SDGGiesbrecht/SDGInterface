/*
 MenuBar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#endif

import SDGMathematics
import SDGText
import SDGLocalization

import SDGInterfaceBasics
import SDGMenus

import SDGInterfaceLocalizations

/// An application’s menu bar.
///
/// `MenuBar` is a fully localized version of Interface Builder’s template with several useful additions.
///
/// Some menu items only appear if the application provides details they need to operate:
/// - “Preferences...” appears if the application has a preference manager.
/// - “Help” appears if a help book is specified in the `Info.plist` file.
public final class MenuBar {

    // MARK: - Class Properties

    /// The menu bar.
    public static let menuBar: MenuBar = MenuBar()

    // MARK: - Initialization

    private init() {
        menu = Menu(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Menu Bar"
            }
        })))
        menu.entries = [
            .submenu(MenuBar.application()),
            .submenu(MenuBar.file()),
            .submenu(MenuBar.edit()),
            .submenu(MenuBar.format())
        ]

        initializeViewMenu()
        initializeWindowMenu()
        initializeHelpMenu()

        menuDidSet()
    }

    // MARK: - Properties

    public var menu: AnyMenu {
        didSet {
            menuDidSet()
        }
    }
    private func menuDidSet() {
        #if canImport(AppKit)
        NSApplication.shared.mainMenu = menu.native
        #endif
    }

    private var endOfPreferenceSection: NSMenuItem!
    private var endOfCustomMenuSection: NSMenuItem!

    // MARK: - Modification

    /// Creates a new menu in the application‐specific section. (Before the “Window” menu.)
    ///
    /// - Parameters:
    ///     - label: A label for the new submenu.
    public func addApplicationSpecificSubmenu(_ menu: AnyMenu) {
        let index: Int
        if menu.entries.count ≥ 2 {
            index = menu.entries.index(menu.entries.endIndex, offsetBy: −2)
        } else {
            index = 0
        }
        menu.entries.insert(.submenu(menu), at: index)
    }

    // MARK: - Items

    internal static func fallbackApplicationName(quotationMarks: (leading: StrictString, trailing: StrictString)) -> StrictString {
        var result = quotationMarks.leading
        result.append("\u{2068}")
        result.append(contentsOf: ApplicationNameForm.localizedIsolatedForm.resolved())
        result.append("\u{2069}")
        result.append(contentsOf: quotationMarks.trailing)
        return result
    }

    private func initializeViewMenu() {
        class Responder : NSObject {
            @objc func toggleSourceList(_ sender: Any?) {}
        }

        let view = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })))

        let showToolbar = viewMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSWindow.toggleToolbarShown(_:)))
        showToolbar.hotKey = "t"
        showToolbar.hotKeyModifiers = [.command, .option]

        viewMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSWindow.runToolbarCustomizationPalette(_:)))

        view.newSeparator()

        let showSideBar = viewMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(Responder.toggleSourceList(_:)))
        showSideBar.hotKey = "s"
        showSideBar.hotKeyModifiers = [.command, .control]

        let enterFullScreen = viewMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSWindow.toggleFullScreen(_:)))
        enterFullScreen.hotKey = "f"
        enterFullScreen.hotKeyModifiers = [.command, .control]
    }

    private func initializeWindowMenu() {
        let window = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })))
        defer { NSApplication.shared.windowsMenu = window }
        endOfCustomMenuSection = window.parentMenuItem

        let minimize = windowMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSWindow.performMiniaturize(_:)))
        minimize.hotKey = "m"
        minimize.hotKeyModifiers = .command

        windowMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSWindow.performZoom(_:)))

        window.newSeparator()

        windowMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSApplication.arrangeInFront(_:)))
    }

    private func initializeHelpMenu() {
        let helpMenu = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Ayuda"
            case .françaisFrance:
                return "Aide"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Help"
            case .deutschDeutschland:
                return "Hilfe"

            case .ελληνικάΕλλάδα:
                return "Βοήθεια"
            case .עברית־ישראל:
                return "עזרה"
            }
        })))
        defer { NSApplication.shared.helpMenu = helpMenu }

        let helpItem = helpMenuMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                let deLaAplicación = ProcessInfo.applicationName(.español(.de))
                    ?? "de \(MenuBar.fallbackApplicationName(quotationMarks: ("«", "»")))"
                return "Ayuda \(deLaAplicación)"
            case .françaisFrance:
                let deLApplication = ProcessInfo.applicationName(.français(.de))
                    ?? "de \(MenuBar.fallbackApplicationName(quotationMarks: ("« ", " »")))"
                return "Aide \(deLApplication)"

            case .englishUnitedKingdom:
                let theApplication = ProcessInfo.applicationName(.english(.unitedKingdom))
                    ?? MenuBar.fallbackApplicationName(quotationMarks: ("‘", "’"))
                return "\(theApplication) Help"
            case .englishUnitedStates:
                let theApplication = ProcessInfo.applicationName(.english(.unitedStates))
                    ?? MenuBar.fallbackApplicationName(quotationMarks: ("“", "”"))
                return "\(theApplication) Help"
            case .englishCanada:
                let theApplication = ProcessInfo.applicationName(.english(.canada))
                    ?? MenuBar.fallbackApplicationName(quotationMarks: ("“", "”"))
                return "\(theApplication) Help"
            case .deutschDeutschland:
                let derAnwendung = ProcessInfo.applicationName(.deutsch(.dativ))
                    ?? MenuBar.fallbackApplicationName(quotationMarks: ("„", "“"))
                return "Hilfe zu \(derAnwendung)"

            case .ελληνικάΕλλάδα:
                let τηνΕφαρμογή = ProcessInfo.applicationName(.ελληνικά(.αιτιατική))
                    ?? MenuBar.fallbackApplicationName(quotationMarks: ("«", "»"))
                return "Βοήθεια για \(τηνΕφαρμογή)"
            case .עברית־ישראל:
                let היישום = ProcessInfo.applicationName(.עברית)
                    ?? MenuBar.fallbackApplicationName(quotationMarks: ("”", "“"))
                return "עזרה עבור \(היישום)"
            }
        })), action: #selector(NSApplication.showHelp(_:)))
        helpItem.hotKey = "?"
        helpItem.hotKeyModifiers = .command
        if Bundle.main.infoDictionary?["CFBundleHelpBookName"] == nil {
            helpItem.isHidden = true
        }
    }
}

#endif

#if !os(tvOS)
internal enum MenuLabels {

    static let normalizeText = Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom:
            return "Normalise Text"
        case .englishUnitedStates, .englishCanada:
            return "Normalize Text"
        }
    }))

    static let showCharacterInformation = Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Show Character Information"
        }
    }))
}
