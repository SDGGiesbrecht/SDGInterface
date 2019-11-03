/*
 LinuxMain.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

import SDGApplicationTests
import SDGButtonsTests
import SDGContextMenuTests
import SDGImageDisplayTests
import SDGInterfaceBasicsTests
import SDGKeyboardTests
import SDGMenuBarTests
import SDGMenusTests
import SDGPopOversTests
import SDGProgressIndicatorsTests
import SDGTablesTests
import SDGTextDisplayTests
import SDGViewsTests
import SDGWindowsTests

var tests = [XCTestCaseEntry]()
tests += SDGApplicationTests.__allTests()
tests += SDGButtonsTests.__allTests()
tests += SDGContextMenuTests.__allTests()
tests += SDGImageDisplayTests.__allTests()
tests += SDGInterfaceBasicsTests.__allTests()
tests += SDGKeyboardTests.__allTests()
tests += SDGMenuBarTests.__allTests()
tests += SDGMenusTests.__allTests()
tests += SDGPopOversTests.__allTests()
tests += SDGProgressIndicatorsTests.__allTests()
tests += SDGTablesTests.__allTests()
tests += SDGTextDisplayTests.__allTests()
tests += SDGViewsTests.__allTests()
tests += SDGWindowsTests.__allTests()

XCTMain(tests)
