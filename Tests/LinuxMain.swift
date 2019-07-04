import XCTest

import SDGApplicationTests
import SDGContextMenuTests
import SDGInterfaceBasicsTests
import SDGKeyboardTests
import SDGMenuBarTests
import SDGMenusTests
import SDGWindowsTests

var tests = [XCTestCaseEntry]()
tests += SDGApplicationTests.__allTests()
tests += SDGContextMenuTests.__allTests()
tests += SDGInterfaceBasicsTests.__allTests()
tests += SDGKeyboardTests.__allTests()
tests += SDGMenuBarTests.__allTests()
tests += SDGMenusTests.__allTests()
tests += SDGWindowsTests.__allTests()

XCTMain(tests)
