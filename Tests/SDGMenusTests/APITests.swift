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
    #if (canImport(AppKit) || canImport(UIKit)) && !os(tvOS) && !os(watchOS)
      _ = MenuEntry(label: UserFacing<StrictString, APILocalization>({ _ in "..." }))
      let menuLabel = UserFacing<StrictString, APILocalization>({ _ in "initial" })
      let menu = Menu<APILocalization>(label: menuLabel, entries: [])
      #if canImport(AppKit)
        _ = menu.cocoa()
      #endif
    #endif
  }

  func testMenuComponent() {
    #if (canImport(AppKit) || canImport(UIKit)) && !os(tvOS) && !os(watchOS)
      XCTAssertNotNil(
        MenuComponent.entry(
          MenuEntry<InterfaceLocalization>(
            label: UserFacing<StrictString, InterfaceLocalization>({ _ in "" })
          )
        ).asEntry
      )
      #if canImport(AppKit)
        XCTAssertNotNil(
          MenuComponent.submenu(
            Menu<InterfaceLocalization>(
              label: UserFacing<StrictString, InterfaceLocalization>({ _ in "" }),
              entries: []
            )
          ).asSubmenu
        )
        XCTAssertNil(
          MenuComponent.submenu(
            Menu<InterfaceLocalization>(
              label: UserFacing<StrictString, InterfaceLocalization>({ _ in "initial" }),
              entries: []
            )
          ).asEntry
        )
        XCTAssertNil(
          MenuComponent.entry(
            MenuEntry<InterfaceLocalization>(
              label: UserFacing<StrictString, InterfaceLocalization>({ _ in "" })
            )
          )
          .asSubmenu
        )
      #endif
    #endif
  }

  func testMenuEntry() {
    #if (canImport(AppKit) || canImport(UIKit)) && !os(tvOS) && !os(watchOS)
      let menuLabel = Shared<StrictString>("initial")
      let _ = MenuEntry<APILocalization>(
        label: UserFacing<StrictString, APILocalization>({ _ in "" })
      )
      menuLabel.value = "changed"
      menuLabel.value = "unrelated"
    #endif
  }
}
