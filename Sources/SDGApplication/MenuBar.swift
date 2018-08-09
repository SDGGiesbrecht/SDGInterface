/*
 MenuBar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterfaceLocalizations

/// An application’s menu bar.
///
/// `MenuBar` is a fully localized version of Interface Builder’s template with several useful additions.
///
/// “Preferences...” is hidden unless the `preferencesAction` property is set.
///
/// The “Help” menu is hidden unless a help book is specified in the application’s `Info.plist` file.
public class MenuBar : LocalizedMenu<MenuBarLocalization> {

    // MARK: - Class Properties

    /// The menu bar.
    public static let menuBar: MenuBar = MenuBar()

    // MARK: - Initialization

    private init() {
        super.init(label: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Menu Bar"
            }
        })))

        initializeApplicationMenu()
        initializeFileMenu()
    }

    // MARK: - Properties

    private var preferencesEntry: LocalizedMenuItem<MenuBarLocalization>!
    /// The action for the preferences item. Set this action to make the preferences item appear in the menu. The action should open a view which manages preferences.
    public var preferencesAction: Selector? {
        set {
            preferencesEntry.action = newValue
            preferencesEntry.isHidden = (newValue == nil) // #warning(Rethink to use responder chain.)
        }
        get {
            return preferencesEntry.action
        }
    }

    private var endOfPreferenceSection: NSMenuItem!

    // MARK: - Items

    private func initializeApplicationMenu() {
        let application = newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            // #workaround(Should detect actual application name.)
            case .englishCanada:
                return "Application"
            }
        })))

        application.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            // #workaround(Should include the application name.)
            case .englishCanada:
                return "About"
            }
        })), action: #selector(Application.orderFrontStandardAboutPanel(_:)))

        application.newSeparator()

        let preferences = application.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Preferences..."
            }
        })))
        preferencesEntry = preferences
        preferencesAction = nil
        preferences.keyEquivalent = ","
        preferences.keyEquivalentModifierMask = .command

        endOfPreferenceSection = application.newSeparator()

        let services = application.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Services"
            }
        })))
        Application.shared.servicesMenu = services

        application.newSeparator()

        let hide = application.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            // #workaround(Should include the application name.)
            case .englishCanada:
                return "Hide"
            }
        })), action: #selector(Application.hide))
        hide.keyEquivalent = "h"
        hide.keyEquivalentModifierMask = .command

        let hideOthers = application.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Hide Others"
            }
        })), action: #selector(Application.hideOtherApplications))
        hideOthers.keyEquivalent = "h"
        hideOthers.keyEquivalentModifierMask = [.option, .command]

        application.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Show All"
            }
        })), action: #selector(Application.unhideAllApplications))

        application.newSeparator()

        let quit = application.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            // #workaround(Should include the application name.)
            case .englishCanada:
                return "Quit"
            }
        })), action: #selector(Application.terminate))
        quit.keyEquivalent = "q"
        quit.keyEquivalentModifierMask = .command
    }

    private func initializeFileMenu() {

        let file = newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "File"
            }
        })))

        let new = file.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "New"
            }
        })), action: #selector(NSDocumentController.newDocument))
        new.keyEquivalent = "n"
        new.keyEquivalentModifierMask = .command

        let open = file.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Open..."
            }
        })), action: #selector(NSDocumentController.openDocument(_:)))
        open.keyEquivalent = "o"
        open.keyEquivalentModifierMask = .command

        let openRecent = file.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Open Recent"
            }
        })))

        openRecent.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Clear Menu"
            }
        })), action: #selector(NSDocumentController.clearRecentDocuments))

        file.newSeparator()

        let close = file.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Close"
            }
        })), action: #selector(NSWindow.performClose))
        close.keyEquivalent = "w"
        close.keyEquivalentModifierMask = .command

        let save = file.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Save..."
            }
        })), action: #selector(NSDocument.save(_:)))
        save.keyEquivalent = "s"
        save.keyEquivalentModifierMask = .command

        // #warning(Update to “Duplicate”?)
        let saveAs = file.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Save As..."
            }
        })), action: #selector(NSDocument.saveAs))
        saveAs.keyEquivalent = "S"
        saveAs.keyEquivalentModifierMask = .command
    }
}
