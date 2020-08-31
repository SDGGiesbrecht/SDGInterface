/*
 RegressionTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGText
import SDGLocalization

import SDGMenus

import SDGInterfaceLocalizations

import SDGApplicationTestUtilities

final class RegressionTests: ApplicationTestCase {

  func testMenuEntryCocoaImplementationCanBeCopied() {
    // Untracked.

    #if canImport(AppKit)
      let cocoa = MenuEntry<APILocalization>(
        label: UserFacing<StrictString, APILocalization>({ _ in "Menu Entry" })
      ).cocoa()
      _ = cocoa.copy()
    #endif
  }
}
