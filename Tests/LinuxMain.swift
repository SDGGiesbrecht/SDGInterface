import XCTest

import SDGApplicationTests
import SDGInterfaceBasicsTests
import SDGMenuBarTests
import SDGMenusTests

var tests = [XCTestCaseEntry]()
tests += SDGApplicationTests.__allTests()
tests += SDGInterfaceBasicsTests.__allTests()
tests += SDGMenuBarTests.__allTests()
tests += SDGMenusTests.__allTests()

XCTMain(tests)
