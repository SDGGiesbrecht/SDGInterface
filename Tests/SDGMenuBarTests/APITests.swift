/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMenus
import SDGMenuBar

import SDGXCTestUtilities

import SDGApplicationTestUtilities

import XCTest

final class APITests : ApplicationTestCase {

    func testMenuBar() {
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
        #if canImport(AppKit)
        XCTAssertNotNil(submenu)
        #endif
    }
}
