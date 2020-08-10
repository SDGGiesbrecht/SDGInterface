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
import SDGContextMenu

import SDGInterfaceLocalizations

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testContextMenu() {
    #if canImport(UIKit) && !os(tvOS) && !os(watchOS)
      let contextMenu = ContextMenu.contextMenu
      let newEntry = MenuEntry<InterfaceLocalization>(label: .binding(Shared("")))
      newEntry.isHidden = true
      contextMenu.menu = Menu(
        label: UserFacing<StrictString, APILocalization>({ _ in "" }),
        entries: [.entry(newEntry)]
      )
    #endif
  }
}
