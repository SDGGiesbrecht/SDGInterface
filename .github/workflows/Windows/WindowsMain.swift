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

extension SDGApplicationTests.APITests {
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

extension SDGApplicationTests.InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testApplicationName", testApplicationName),
      ("testNSApplicationDelegate", testNSApplicationDelegate),
      ("testUIApplicationDelegate", testUIApplicationDelegate),
    ])
  ]
}

extension SDGButtonsTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testButton", testButton),
      ("testCheckBox", testCheckBox),
      ("testRadioButtonSet", testRadioButtonSet),
    ])
  ]
}

extension SDGContextMenuTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testContextMenu", testContextMenu),
    ])
  ]
}

extension SDGImageDisplayTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testImageView", testImageView),
    ])
  ]
}

extension SDGInterfaceBasicsTests.APITests {
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

extension SDGKeyboardTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testKey", testKey),
    ])
  ]
}

extension SDGMenuBarTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testMenuBar", testMenuBar),
    ])
  ]
}

extension SDGMenusTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testKeyModifiers", testKeyModifiers),
      ("testMenu", testMenu),
      ("testMenuComponent", testMenuComponent),
      ("testMenuEntry", testMenuEntry),
    ])
  ]
}

extension SDGPopOversTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testPopOver", testPopOver),
    ])
  ]
}

extension SDGProgressIndicatorsTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLabelledProgressBar", testLabelledProgressBar),
      ("testProgressBar", testProgressBar),
    ])
  ]
}

extension SDGTablesTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testTable", testTable),
    ])
  ]
}

extension SDGTextDisplayTests.APITests {
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

extension SDGViewsTests.APITests {
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

extension SDGViewsTests.InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAspectRatioContainer", testAspectRatioContainer),
    ])
  ]
}

extension SDGWindowsTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testWindow", testWindow),
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += SDGApplicationTests.APITests.windowsTests
tests += SDGApplicationTests.InternalTests.windowsTests
tests += SDGButtonsTests.APITests.windowsTests
tests += SDGContextMenuTests.APITests.windowsTests
tests += SDGImageDisplayTests.APITests.windowsTests
tests += SDGInterfaceBasicsTests.APITests.windowsTests
tests += SDGKeyboardTests.APITests.windowsTests
tests += SDGMenuBarTests.APITests.windowsTests
tests += SDGMenusTests.APITests.windowsTests
tests += SDGPopOversTests.APITests.windowsTests
tests += SDGProgressIndicatorsTests.APITests.windowsTests
tests += SDGTablesTests.APITests.windowsTests
tests += SDGTextDisplayTests.APITests.windowsTests
tests += SDGViewsTests.APITests.windowsTests
tests += SDGViewsTests.InternalTests.windowsTests
tests += SDGWindowsTests.APITests.windowsTests

XCTMain(tests)
