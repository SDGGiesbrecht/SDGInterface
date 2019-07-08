import XCTest

import SDGApplicationTests
import SDGContextMenuTests
import SDGImageDisplayTests
import SDGInterfaceBasicsTests
import SDGKeyboardTests
import SDGMenuBarTests
import SDGMenusTests
import SDGPopOversTests
import SDGTablesTests
import SDGTextDisplayTests
import SDGViewsTests
import SDGWindowsTests

var tests = [XCTestCaseEntry]()
tests += SDGApplicationTests.__allTests()
tests += SDGContextMenuTests.__allTests()
tests += SDGImageDisplayTests.__allTests()
tests += SDGInterfaceBasicsTests.__allTests()
tests += SDGKeyboardTests.__allTests()
tests += SDGMenuBarTests.__allTests()
tests += SDGMenusTests.__allTests()
tests += SDGPopOversTests.__allTests()
tests += SDGTablesTests.__allTests()
tests += SDGTextDisplayTests.__allTests()
tests += SDGViewsTests.__allTests()
tests += SDGWindowsTests.__allTests()

XCTMain(tests)
