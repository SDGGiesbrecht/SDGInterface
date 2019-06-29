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

    func testMenuComponent() {
        XCTAssertNotNil(MenuComponent.entry(MenuEntry<InterfaceLocalization>(label: .binding(Shared("")))).asEntry)
        XCTAssertNotNil(MenuComponent.submenu(Menu<InterfaceLocalization>(label: .binding(Shared("")))).asSubmenu)
        XCTAssertNil(MenuComponent.submenu(Menu<InterfaceLocalization>(label: .binding(Shared("")))).asEntry)
        XCTAssertNil(MenuComponent.entry(MenuEntry<InterfaceLocalization>(label: .binding(Shared("")))).asSubmenu)
    }

    func testMenuEntry() {
        let menuLabel = Shared<StrictString>("initial")
        let menu = MenuEntry<APILocalization>(label: .binding(menuLabel))
        menuLabel.value = "changed"
        XCTAssertEqual(menu.label.resolved(), menuLabel.value)
        let separateMenuLabel = Shared<StrictString>("separate")
        menu.label = .binding(separateMenuLabel)
        XCTAssertEqual(menu.label.resolved(), separateMenuLabel.value)
        menuLabel.value = "unrelated"
        XCTAssertEqual(menu.label.resolved(), separateMenuLabel.value)
        let action = #selector(NSObject.isEqual(_:))
        menu.action = action
        _ = menu.action
        #if !os(watchOS) && !os(tvOS)
        XCTAssertEqual(menu.action, action)
        #endif
        menu.action = nil
        let target = NSObject()
        menu.target = target
        _ = menu.target
        #if canImport(AppKit)
        XCTAssertEqual(menu.target as? NSObject, target)
        #endif
        let hotKey = "A"
        menu.hotKey = hotKey
        _ = menu.hotKey
        #if canImport(AppKit)
        XCTAssertEqual(menu.hotKey, hotKey)
        #endif
        let modifiers: KeyModifiers = .command
        menu.hotKeyModifiers = modifiers
        _ = menu.hotKeyModifiers
        #if canImport(AppKit)
        XCTAssertEqual(menu.hotKeyModifiers, modifiers)
        #endif
        menu.isHidden = true
        _ = menu.isHidden
        #if canImport(AppKit)
        XCTAssert(menu.isHidden)
        #endif
        menu.indentationLevel = 1
        _ = menu.indentationLevel
        #if canImport(AppKit)
        XCTAssertEqual(menu.indentationLevel, 1)
        #endif
        menu.tag = 1
        XCTAssertEqual(menu.tag, 1)
        #if !os(watchOS) && !os(tvOS)
        let title = menu.native.title
        #endif
        #if canImport(AppKit)
        menu.native = NSMenuItem()
        #elseif canImport(UIKit) && !os(watchOS) && !os(tvOS)
        menu.native = UIMenuItem()
        #endif
        #if !os(watchOS) && !os(tvOS)
        XCTAssertEqual(menu.native.title, title)
        #endif
    }
}
