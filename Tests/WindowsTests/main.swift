/*
 main.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

@testable import SDGApplicationTests
@testable import SDGButtonsTests
@testable import SDGImageDisplayTests
@testable import SDGInterfaceResourceGeneration
@testable import SDGInterfaceTests
@testable import SDGKeyboardTests
@testable import SDGMenuBarTests
@testable import SDGProgressIndicatorsTests

extension SDGApplicationTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testApplication", testApplication),
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
      ("testPreferenceManager", testPreferenceManager),
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

extension SDGInterfaceTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAlignment", testAlignment),
      ("testAnchorSource", testAnchorSource),
      ("testAnyView", testAnyView),
      ("testApplicationName", testApplicationName),
      ("testBackground", testBackground),
      ("testCocoaView", testCocoaView),
      ("testCocoaViewImplementation", testCocoaViewImplementation),
      ("testCocoaWindow", testCocoaWindow),
      ("testCocoaWindowImplementation", testCocoaWindowImplementation),
      ("testColour", testColour),
      ("testCompositeViewImplementation", testCompositeViewImplementation),
      ("testContentMode", testContentMode),
      ("testContextMenu", testContextMenu),
      ("testEdge", testEdge),
      ("testEdgeSet", testEdgeSet),
      ("testEmptyView", testEmptyView),
      ("testHorizontalStack", testHorizontalStack),
      ("testKeyModifiers", testKeyModifiers),
      ("testLayoutConstraintPriority", testLayoutConstraintPriority),
      ("testLegacyView", testLegacyView),
      ("testMenu", testMenu),
      ("testMenuComponent", testMenuComponent),
      ("testMenuEntry", testMenuEntry),
      ("testNSRectEdge", testNSRectEdge),
      ("testPoint", testPoint),
      ("testPopOver", testPopOver),
      ("testPopOverAttachmentAnchor", testPopOverAttachmentAnchor),
      ("testRectangle", testRectangle),
      ("testSize", testSize),
      ("testSwiftUIViewImplementation", testSwiftUIViewImplementation),
      ("testTable", testTable),
      ("testUIPopOverArrowDirection", testUIPopOverArrowDirection),
      ("testUnitPoint", testUnitPoint),
      ("testView", testView),
      ("testWindow", testWindow),
    ])
  ]
}

extension SDGInterfaceTests.InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLegacyView", testLegacyView),
      ("testPopOverCocoaImplementation", testPopOverCocoaImplementation),
      ("testProportionedView", testProportionedView),
    ])
  ]
}

extension SDGInterfaceTests.RegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testMenuEntryCocoaImplementationCanBeCopied", testMenuEntryCocoaImplementationCanBeCopied)
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

extension SDGProgressIndicatorsTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLabelledProgressBar", testLabelledProgressBar),
      ("testProgressBar", testProgressBar),
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += SDGApplicationTests.APITests.windowsTests
tests += SDGApplicationTests.InternalTests.windowsTests
tests += SDGButtonsTests.APITests.windowsTests
tests += SDGButtonsTests.InternalTests.windowsTests
tests += SDGImageDisplayTests.APITests.windowsTests
tests += SDGImageDisplayTests.InternalTests.windowsTests
tests += SDGInterfaceTests.APITests.windowsTests
tests += SDGInterfaceTests.InternalTests.windowsTests
tests += SDGInterfaceTests.RegressionTests.windowsTests
tests += SDGKeyboardTests.APITests.windowsTests
tests += SDGMenuBarTests.APITests.windowsTests
tests += SDGProgressIndicatorsTests.APITests.windowsTests

XCTMain(tests)
