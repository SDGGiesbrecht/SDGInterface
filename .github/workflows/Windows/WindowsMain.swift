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

extension SDGApplicationAPITests {
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

extension SDGApplicationInternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testApplicationName", testApplicationName),
      ("testNSApplicationDelegate", testNSApplicationDelegate),
      ("testUIApplicationDelegate", testUIApplicationDelegate),
    ])
  ]
}

extension SDGButtonsAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testButton", testButton),
      ("testCheckBox", testCheckBox),
      ("testRadioButtonSet", testRadioButtonSet),
    ])
  ]
}

extension SDGContextMenuAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testContextMenu", testContextMenu),
    ])
  ]
}

extension SDGImageDisplayAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testImageView", testImageView),
    ])
  ]
}

extension SDGInterfaceBasicsAPITests {
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

extension SDGKeyboardAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testKey", testKey),
    ])
  ]
}

extension SDGMenuBarAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testMenuBar", testMenuBar),
    ])
  ]
}

extension SDGMenusAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testKeyModifiers", testKeyModifiers),
      ("testMenu", testMenu),
      ("testMenuComponent", testMenuComponent),
      ("testMenuEntry", testMenuEntry),
    ])
  ]
}

extension SDGPopOversAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testPopOver", testPopOver),
    ])
  ]
}

extension SDGProgressIndicatorsAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLabelledProgressBar", testLabelledProgressBar),
      ("testProgressBar", testProgressBar),
    ])
  ]
}

extension SDGTablesAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testTable", testTable),
    ])
  ]
}

extension SDGTextDisplayAPITests {
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

extension SDGViewsAPITests {
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

extension SDGViewsInternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAspectRatioContainer", testAspectRatioContainer),
    ])
  ]
}

extension SDGWindowsAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testWindow", testWindow),
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += SDGApplicationAPITests.windowsTests
tests += SDGApplicationInternalTests.windowsTests
tests += SDGButtonsAPITests.windowsTests
tests += SDGContextMenuAPITests.windowsTests
tests += SDGImageDisplayAPITests.windowsTests
tests += SDGInterfaceBasicsAPITests.windowsTests
tests += SDGKeyboardAPITests.windowsTests
tests += SDGMenuBarAPITests.windowsTests
tests += SDGMenusAPITests.windowsTests
tests += SDGPopOversAPITests.windowsTests
tests += SDGProgressIndicatorsAPITests.windowsTests
tests += SDGTablesAPITests.windowsTests
tests += SDGTextDisplayAPITests.windowsTests
tests += SDGViewsAPITests.windowsTests
tests += SDGViewsInternalTests.windowsTests
tests += SDGWindowsAPITests.windowsTests

XCTMain(tests)
