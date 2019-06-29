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
import SDGText
import SDGLocalization

import SDGMenus

import SDGInterfaceLocalizations

import SDGXCTestUtilities

import SDGApplicationTestUtilities

import XCTest

final class APITests : ApplicationTestCase {

    func testMenu() {
        _ = MenuEntry(label: .static(UserFacing<StrictString, APILocalization>({ _ in "..." })))
        let menuLabel = Shared<StrictString>("initial")
        let menu = Menu<APILocalization>(label: .binding(menuLabel))
        menuLabel.value = "changed"
        XCTAssertEqual(menu.label.resolved(), menuLabel.value)
        let separateMenuLabel = Shared<StrictString>("separate")
        menu.label = .binding(separateMenuLabel)
        XCTAssertEqual(menu.label.resolved(), separateMenuLabel.value)
        menuLabel.value = "unrelated"
        XCTAssertEqual(menu.label.resolved(), separateMenuLabel.value)
        #if canImport(AppKit)
        let title = menu.native.title
        menu.native = NSMenu()
        XCTAssertEqual(menu.native.title, title)
        #endif
    }
}
