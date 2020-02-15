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

extension APITests {
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

extension InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testApplicationName", testApplicationName),
      ("testNSApplicationDelegate", testNSApplicationDelegate),
      ("testUIApplicationDelegate", testUIApplicationDelegate),
    ])
  ]
}

extension APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testButton", testButton),
      ("testCheckBox", testCheckBox),
      ("testRadioButtonSet", testRadioButtonSet),
    ])
  ]
}

extension APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testContextMenu", testContextMenu),
    ])
  ]
}

extension APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testImageView", testImageView),
    ])
  ]
}

extension APITests {
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

extension APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testKey", testKey),
    ])
  ]
}

extension APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testMenuBar", testMenuBar),
    ])
  ]
}

extension APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testKeyModifiers", testKeyModifiers),
      ("testMenu", testMenu),
      ("testMenuComponent", testMenuComponent),
      ("testMenuEntry", testMenuEntry),
    ])
  ]
}

extension APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testPopOver", testPopOver),
    ])
  ]
}

extension APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLabelledProgressBar", testLabelledProgressBar),
      ("testProgressBar", testProgressBar),
    ])
  ]
}

extension APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testTable", testTable),
    ])
  ]
}

extension APITests {
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

extension APITests {
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

extension InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAspectRatioContainer", testAspectRatioContainer),
    ])
  ]
}

extension APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testWindow", testWindow),
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += APITests.windowsTests
tests += InternalTests.windowsTests
tests += APITests.windowsTests
tests += APITests.windowsTests
tests += APITests.windowsTests
tests += APITests.windowsTests
tests += APITests.windowsTests
tests += APITests.windowsTests
tests += APITests.windowsTests
tests += APITests.windowsTests
tests += APITests.windowsTests
tests += APITests.windowsTests
tests += APITests.windowsTests
tests += APITests.windowsTests
tests += InternalTests.windowsTests
tests += APITests.windowsTests

XCTMain(tests)
