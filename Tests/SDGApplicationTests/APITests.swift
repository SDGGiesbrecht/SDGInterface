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
import SDGInterfaceLocalizations
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
        #if !os(tvOS)

        _ = LocalizedMenuItem(label: Shared(UserFacing<StrictString, APILocalization>({ _ in "..." })))

        #if canImport(AppKit)
        let menuBar = Application.shared.mainMenu
        XCTAssertNotNil(menuBar)
        let itemWithSubmenu = menuBar?.items.first(where: { $0.submenu ≠ nil })
        let submenu = itemWithSubmenu?.submenu
        XCTAssertNotNil(submenu)
        XCTAssertEqual(submenu?.parentMenuItem, itemWithSubmenu)
        XCTAssertNil(menuBar?.parentMenuItem)
        #elseif canImport(UIKit)
        XCTAssertNil(Menu.shared.parentMenuItem)
        #endif

        #endif
    }

    func testMenuBar() {
        for localization in MenuBarLocalization.allCases {
            LocalizationSetting(orderOfPrecedence: [localization.code]).do {}
        }
        #if canImport(AppKit)
        let preferencesMenuItem = MenuBar.menuBar.items.first!.submenu!.items.first(where: { $0.action == #selector(ApplicationDelegate.openPreferences) })!
        XCTAssert(SampleApplicationDelegate().validateMenuItem(preferencesMenuItem))
        XCTAssertFalse(ApplicationDelegate().validateMenuItem(preferencesMenuItem))

        XCTAssertFalse(SampleApplicationDelegate().validateMenuItem(MenuBar.menuBar.items.first!)) // Application
        XCTAssertFalse(SampleApplicationDelegate().validateMenuItem(NSMenuItem(title: "", action: nil, keyEquivalent: "")))
        #endif
    }

    func testPreferences() {
        ApplicationDelegate().openPreferences(nil)
        SampleApplicationDelegate().openPreferences(nil)
    }
}
