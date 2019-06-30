/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLocalization

import SDGMenus
import SDGContextMenu
import SDGMenuBar

import SDGInterfaceLocalizations

import SDGXCTestUtilities

import SDGApplicationTestUtilities

import XCTest

final class APITests : ApplicationTestCase {

    func testMenuBar() {
        #if canImport(AppKit)
        let menuBar = MenuBar.menuBar
        XCTAssertNotNil(menuBar)
        var submenu: AnyMenu?
        _ = menuBar.menu.entries.first(where: { entry in
            switch entry {
            case .submenu(let menu):
                submenu = menu
                return true
            default:
                return false
            }
        })
        XCTAssertNotNil(submenu)

        let previous = ProcessInfo.applicationName
        func testAllLocalizations() {
            defer {
                ProcessInfo.applicationName = previous
            }
            for localization in MenuBarLocalization.allCases {
                LocalizationSetting(orderOfPrecedence: [localization.code]).do {
                    _ = ContextMenu._normalizeText().label.resolved()
                    _ = ContextMenu._showCharacterInformation().label.resolved()
                    _ = (MenuBar.menuBar.menu as? Menu<InterfaceLocalization>)?.label.resolved()
                }
            }
        }

        ProcessInfo.applicationName = { form in
            switch form {
            case .english(.canada):
                return "..."
            default:
                return nil
            }
        }
        testAllLocalizations()
        ProcessInfo.applicationName = { form in
            switch form {
            case .english(.unitedKingdom):
                return "..."
            default:
                return nil
            }
        }
        testAllLocalizations()

        let preferencesMenuItem = NSApplication.shared.mainMenu?.items.first?.submenu?.items.first(where: { $0.action == #selector(_NSApplicationDelegateProtocol.openPreferences(_:)) })
        XCTAssertNotNil(preferencesMenuItem)

        let menu = MenuBar.menuBar.menu
        MenuBar.menuBar.menu = Menu<APILocalization>(label: .binding(Shared("")))
        MenuBar.menuBar.addApplicationSpecificSubmenu(Menu<APILocalization>(label: .binding(Shared(""))))
        MenuBar.menuBar.addApplicationSpecificSubmenu(Menu<APILocalization>(label: .binding(Shared(""))))
        MenuBar.menuBar.addApplicationSpecificSubmenu(Menu<APILocalization>(label: .binding(Shared(""))))
        MenuBar.menuBar.menu = menu
        #endif
    }
}
