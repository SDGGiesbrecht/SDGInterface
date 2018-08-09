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

public class MenuBar : LocalizedMenu<MenuBarLocalization> {

    // MARK: - Class Properties

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
    }

    // MARK: - Application

    private func initializeApplicationMenu() {
        let application = newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Application" // #workaround(Should detect actual application name.)
            }
        })))

        application.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "About" // #workaround(Should include the application name.)
            }
        })), action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)))
    }
}
