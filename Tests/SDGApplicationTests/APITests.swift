/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGLogic
import SDGXCTestUtilities

import SDGInterface
import SDGInterfaceSample

final class SDGApplicationAPITests : TestCase {

    override func setUp() {
        super.setUp()
        launch
    }
    let launch: Void = {
        let delegate = SampleApplicationDelegate()
        #if canImport(AppKit)
        delegate.applicationDidFinishLaunching(Notification(name: Application.didFinishLaunchingNotification))
        #elseif canImport(UIKit)
        _ = delegate.application(Application.shared)
        #endif
    }()

    func testMenu() {
        #if canImport(AppKit)
        let menuBar = Application.shared.mainMenu
        XCTAssertNotNil(menuBar)
        let itemWithSubmenu = menuBar?.items.first(where: { $0.submenu ≠ nil })
        let submenu = itemWithSubmenu?.submenu
        XCTAssertNotNil(submenu)
        XCTAssertEqual(submenu?.parentMenuItem, itemWithSubmenu)
        #endif
    }
}
