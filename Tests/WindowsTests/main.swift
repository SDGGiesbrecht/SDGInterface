/*
 main.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

@testable import SDGApplicationTests
@testable import SDGButtonsTests
@testable import SDGContextMenuTests
@testable import SDGImageDisplayTests
@testable import SDGInterfaceBasicsTests
@testable import SDGInterfaceResourceGeneration
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
      ("testQuickActionDetails", testQuickActionDetails),
      ("testSystemInterface", testSystemInterface),
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
      ("testSegmentedControl", testSegmentedControl),
    ])
  ]
}

extension SDGButtonsTests.InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testButtonCocoaImplementation", testButtonCocoaImplementation),
      ("testButtonLabel", testButtonLabel),
      ("testCheckBoxCocoaImplementation", testCheckBoxCocoaImplementation),
      ("testSegmentedControlCocoaImplementation", testSegmentedControlCocoaImplementation),
    ])
  ]
}

extension SDGContextMenuTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testContextMenu", testContextMenu)
    ])
  ]
}

extension SDGImageDisplayTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCocoaImage", testCocoaImage),
      ("testImage", testImage),
    ])
  ]
}

extension SDGImageDisplayTests.InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testImage", testImage)
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
      ("testNSRectEdge", testNSRectEdge),
      ("testPoint", testPoint),
      ("testRectangle", testRectangle),
      ("testSize", testSize),
      ("testUnitPoint", testUnitPoint),
    ])
  ]
}

extension SDGKeyboardTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testKey", testKey)
    ])
  ]
}

extension SDGMenuBarTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testMenuBar", testMenuBar)
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

extension SDGMenusTests.RegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testMenuEntryCocoaImplementationCanBeCopied", testMenuEntryCocoaImplementationCanBeCopied)
    ])
  ]
}

extension SDGPopOversTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAnchorSource", testAnchorSource),
      ("testCocoaView", testCocoaView),
      ("testLegacyView", testLegacyView),
      ("testPopOver", testPopOver),
      ("testPopOverAttachmentAnchor", testPopOverAttachmentAnchor),
      ("testUIPopOverArrowDirection", testUIPopOverArrowDirection),
    ])
  ]
}

extension SDGPopOversTests.InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLegacyView", testLegacyView),
      ("testPopOverCocoaImplementation", testPopOverCocoaImplementation),
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
      ("testTable", testTable)
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
      ("testLog", testLog),
      ("testRichText", testRichText),
      ("testTextEditor", testTextEditor),
      ("testTextField", testTextField),
      ("testTextView", testTextView),
    ])
  ]
}

extension SDGTextDisplayTests.InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testStrictString", testStrictString)
    ])
  ]
}

extension SDGViewsTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAnyView", testAnyView),
      ("testCocoaViewImplementation", testCocoaViewImplementation),
      ("testBackground", testBackground),
      ("testColour", testColour),
      ("testEmptyView", testEmptyView),
      ("testHorizontalStack", testHorizontalStack),
      ("testLayoutConstraintPriority", testLayoutConstraintPriority),
      ("testLegacyView", testLegacyView),
      ("testSwiftUIViewImplementation", testSwiftUIViewImplementation),
      ("testView", testView),
    ])
  ]
}

extension SDGViewsTests.InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testProportionedView", testProportionedView)
    ])
  ]
}

extension SDGWindowsTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCocoaWindow", testCocoaWindow),
      ("testCocoaWindowImplementation", testCocoaWindowImplementation),
      ("testWindow", testWindow),
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += SDGApplicationTests.APITests.windowsTests
tests += SDGApplicationTests.InternalTests.windowsTests
tests += SDGButtonsTests.APITests.windowsTests
tests += SDGButtonsTests.InternalTests.windowsTests
tests += SDGContextMenuTests.APITests.windowsTests
tests += SDGImageDisplayTests.APITests.windowsTests
tests += SDGImageDisplayTests.InternalTests.windowsTests
tests += SDGInterfaceBasicsTests.APITests.windowsTests
tests += SDGKeyboardTests.APITests.windowsTests
tests += SDGMenuBarTests.APITests.windowsTests
tests += SDGMenusTests.APITests.windowsTests
tests += SDGMenusTests.RegressionTests.windowsTests
tests += SDGPopOversTests.APITests.windowsTests
tests += SDGPopOversTests.InternalTests.windowsTests
tests += SDGProgressIndicatorsTests.APITests.windowsTests
tests += SDGTablesTests.APITests.windowsTests
tests += SDGTextDisplayTests.APITests.windowsTests
tests += SDGTextDisplayTests.InternalTests.windowsTests
tests += SDGViewsTests.APITests.windowsTests
tests += SDGViewsTests.InternalTests.windowsTests
tests += SDGWindowsTests.APITests.windowsTests

XCTMain(tests)
