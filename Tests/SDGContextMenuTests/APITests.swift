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
import SDGLocalization

import SDGMenus
import SDGContextMenu

import SDGInterfaceLocalizations

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testContextMenu() {
    #if canImport(UIKit) && !os(watchOS) && !os(tvOS)
      let contextMenu = ContextMenu.contextMenu
      let modified = contextMenu.menu
      let newEntry = MenuEntry<InterfaceLocalization>(label: .binding(Shared("")))
      newEntry.isHidden = true
      modified.entries.append(.entry(newEntry))
      contextMenu.menu = modified
    #endif
  }
}
