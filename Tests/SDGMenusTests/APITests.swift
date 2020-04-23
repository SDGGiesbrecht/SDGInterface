/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGMenus

import SDGInterfaceLocalizations

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testKeyModifiers() {
    let modifiers: KeyModifiers = [.command, .shift, .option, .control, .function, .capsLock]
    #if canImport(AppKit)
      XCTAssertEqual(KeyModifiers(modifiers.cocoa), modifiers)
    #endif
  }

  func testMenu() {
    #if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS) && !os(tvOS)
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
        _ = menu.cocoa.title
      #endif
    #endif
  }

  func testMenuComponent() {
    #if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS) && !os(tvOS)
      XCTAssertNotNil(
        MenuComponent.entry(MenuEntry<InterfaceLocalization>(label: .binding(Shared("")))).asEntry
      )
      #if canImport(AppKit)
        XCTAssertNotNil(
          MenuComponent.submenu(Menu<InterfaceLocalization>(label: .binding(Shared("")))).asSubmenu
        )
        XCTAssertNil(
          MenuComponent.submenu(Menu<InterfaceLocalization>(label: .binding(Shared("")))).asEntry
        )
        XCTAssertNil(
          MenuComponent.entry(MenuEntry<InterfaceLocalization>(label: .binding(Shared(""))))
            .asSubmenu
        )
      #endif
    #endif
  }

  func testMenuEntry() {
    #if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS) && !os(tvOS)
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
      #if canImport(AppKit)
        let target = NSObject()
        menu.target = target
        XCTAssertEqual(menu.target as? NSObject, target)
      #endif
      #if canImport(AppKit)
        let hotKey = "A"
        menu.hotKey = hotKey
        XCTAssertEqual(menu.hotKey, hotKey)
      #endif
      #if canImport(AppKit)
        let modifiers: KeyModifiers = .command
        menu.hotKeyModifiers = modifiers
        XCTAssertEqual(menu.hotKeyModifiers, modifiers)
      #endif
      menu.isHidden = true
      _ = menu.isHidden
      XCTAssert(menu.isHidden)
      #if canImport(AppKit)
        menu.indentationLevel = 1
        XCTAssertEqual(menu.indentationLevel, 1)
      #endif
      menu.tag = 1
      XCTAssertEqual(menu.tag, 1)
      #if !os(watchOS) && !os(tvOS)
        _ = menu.cocoa.title
      #endif
    #endif
  }
}
