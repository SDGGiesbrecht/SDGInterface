/*
 WindowsMain.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

@testable import SDGInterfaceResourceGeneration
@testable import SDGApplicationTests
@testable import SDGButtonsTests
@testable import SDGContextMenuTests
@testable import SDGImageDisplayTests
@testable import SDGInterfaceBasicsTests
@testable import SDGKeyboardTests
@testable import SDGMenuBarTests
@testable import SDGMenusTests
@testable import SDGPopOversTests
@testable import SDGProgressIndicatorsTests
@testable import SDGTablesTests
@testable import SDGTextDisplayTests
@testable import SDGViewsTests
@testable import SDGWindowsTests

extension SDGApplicationTests.SDGApplicationAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testDemonstrations", testDemonstrations),
      ("testFetchResult", testFetchResult),
      ("testNotification", testNotification),
      ("testPreferences", testPreferences),
      ("testQuickActionDetails", testQuickActionDetails),
      ("testSystemMediator", testSystemMediator),
    ])
  ]
}

extension SDGApplicationTests.SDGApplicationInternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testApplicationName", testApplicationName),
      ("testNSApplicationDelegate", testNSApplicationDelegate),
      ("testUIApplicationDelegate", testUIApplicationDelegate),
    ])
  ]
}

extension SDGButtonsTests.SDGButtonsAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testButton", testButton),
      ("testCheckBox", testCheckBox),
      ("testRadioButtonSet", testRadioButtonSet),
    ])
  ]
}

extension SDGContextMenuTests.SDGContextMenuAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testContextMenu", testContextMenu),
    ])
  ]
}

extension SDGImageDisplayTests.SDGImageDisplayAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testImageView", testImageView),
    ])
  ]
}

extension SDGInterfaceBasicsTests.SDGInterfaceBasicsAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAlignment", testAlignment),
      ("testApplicationName", testApplicationName),
      ("testBinding", testBinding),
      ("testColour", testColour),
      ("testContentMode", testContentMode),
      ("testEdge", testEdge),
      ("testEdgeSet", testEdgeSet),
      ("testPoint", testPoint),
      ("testRectangle", testRectangle),
      ("testSize", testSize),
    ])
  ]
}

extension SDGKeyboardTests.SDGKeyboardAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testKey", testKey),
    ])
  ]
}

extension SDGMenuBarTests.SDGMenuBarAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testMenuBar", testMenuBar),
    ])
  ]
}

extension SDGMenusTests.SDGMenusAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testKeyModifiers", testKeyModifiers),
      ("testMenu", testMenu),
      ("testMenuComponent", testMenuComponent),
      ("testMenuEntry", testMenuEntry),
    ])
  ]
}

extension SDGPopOversTests.SDGPopOversAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testPopOver", testPopOver),
    ])
  ]
}

extension SDGProgressIndicatorsTests.SDGProgressIndicatorsAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLabelledProgressBar", testLabelledProgressBar),
      ("testProgressBar", testProgressBar),
    ])
  ]
}

extension SDGTablesTests.SDGTablesAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testTable", testTable),
    ])
  ]
}

extension SDGTextDisplayTests.SDGTextDisplayAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAttributedString", testAttributedString),
      ("testCharacterInformation", testCharacterInformation),
      ("testFont", testFont),
      ("testLabel", testLabel),
      ("testRichText", testRichText),
      ("testTextEditor", testTextEditor),
      ("testTextField", testTextField),
    ])
  ]
}

extension SDGViewsTests.SDGViewsAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCocoaViewImplementation", testCocoaViewImplementation),
      ("testBackground", testBackground),
      ("testColour", testColour),
      ("testEmptyView", testEmptyView),
      ("testHorizontalStack", testHorizontalStack),
      ("testStabilizedView", testStabilizedView),
      ("testSwiftUIViewImplementation", testSwiftUIViewImplementation),
      ("testView", testView),
    ])
  ]
}

extension SDGViewsTests.SDGViewsInternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAspectRatioContainer", testAspectRatioContainer),
    ])
  ]
}

extension SDGWindowsTests.SDGWindowsAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testWindow", testWindow),
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += SDGApplicationTests.SDGApplicationAPITests.windowsTests
tests += SDGApplicationTests.SDGApplicationInternalTests.windowsTests
tests += SDGButtonsTests.SDGButtonsAPITests.windowsTests
tests += SDGContextMenuTests.SDGContextMenuAPITests.windowsTests
tests += SDGImageDisplayTests.SDGImageDisplayAPITests.windowsTests
tests += SDGInterfaceBasicsTests.SDGInterfaceBasicsAPITests.windowsTests
tests += SDGKeyboardTests.SDGKeyboardAPITests.windowsTests
tests += SDGMenuBarTests.SDGMenuBarAPITests.windowsTests
tests += SDGMenusTests.SDGMenusAPITests.windowsTests
tests += SDGPopOversTests.SDGPopOversAPITests.windowsTests
tests += SDGProgressIndicatorsTests.SDGProgressIndicatorsAPITests.windowsTests
tests += SDGTablesTests.SDGTablesAPITests.windowsTests
tests += SDGTextDisplayTests.SDGTextDisplayAPITests.windowsTests
tests += SDGViewsTests.SDGViewsAPITests.windowsTests
tests += SDGViewsTests.SDGViewsInternalTests.windowsTests
tests += SDGWindowsTests.SDGWindowsAPITests.windowsTests

XCTMain(tests)
