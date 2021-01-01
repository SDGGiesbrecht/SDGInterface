/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGText
import SDGLocalization

import SDGMenus
import SDGContextMenu
import SDGMenuBar

import SDGInterfaceLocalizations

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testMenuBar() {
    #if canImport(AppKit)
      let menuBar = MenuBar(applicationSpecificSubmenus: [])
      XCTAssertNotNil(menuBar)
      let submenu = menuBar.cocoa().items.first(where: { $0.submenu ≠ nil })
      XCTAssertNotNil(submenu)

      let previous = ProcessInfo.applicationName
      func testAllLocalizations() {
        defer {
          ProcessInfo.applicationName = previous
        }
        for localization in MenuBarLocalization.allCases {
          LocalizationSetting(orderOfPrecedence: [localization.code]).do {
            _ = ContextMenu._normalizeText().cocoa()
            _ = ContextMenu._showCharacterInformation().cocoa()
            _ = menuBar.cocoa()
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

      let preferencesMenuItem = NSApplication.shared.mainMenu?.items.first?.submenu?.items.first(
        where: { $0.action == #selector(_NSApplicationDelegateProtocol.openPreferences(_:)) })
      XCTAssertNotNil(preferencesMenuItem)

      _ = MenuBar(applicationSpecificSubmenus: []).cocoa()
    #endif
  }
}
