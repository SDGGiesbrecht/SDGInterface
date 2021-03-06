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

@testable import SDGInterfaceResourceGeneration
@testable import SDGInterfaceTests
@testable import SDGKeyboardTests
@testable import SDGProgressIndicatorsTests

extension SDGInterfaceTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAlignment", testAlignment),
      ("testAnchorSource", testAnchorSource),
      ("testAnyView", testAnyView),
      ("testApplication", testApplication),
      ("testApplicationName", testApplicationName),
      ("testAttributedString", testAttributedString),
      ("testBackground", testBackground),
      ("testButton", testButton),
      ("testCharacterInformation", testCharacterInformation),
      ("testCheckBox", testCheckBox),
      ("testCocoaImage", testCocoaImage),
      ("testCocoaView", testCocoaView),
      ("testCocoaViewImplementation", testCocoaViewImplementation),
      ("testCocoaWindow", testCocoaWindow),
      ("testCocoaWindowImplementation", testCocoaWindowImplementation),
      ("testColour", testColour),
      ("testCommandsBuilder", testCommandsBuilder),
      ("testCommandsConcatenation", testCommandsConcatenation),
      ("testCompatibilityLabel", testCompatibilityLabel),
      ("testCompositeViewImplementation", testCompositeViewImplementation),
      ("testContentMode", testContentMode),
      ("testContextMenu", testContextMenu),
      ("testDemonstrations", testDemonstrations),
      ("testDivider", testDivider),
      ("testEdge", testEdge),
      ("testEdgeSet", testEdgeSet),
      ("testEmptyMenuComponents", testEmptyMenuComponents),
      ("testEmptyView", testEmptyView),
      ("testFetchResult", testFetchResult),
      ("testFont", testFont),
      ("testHorizontalStack", testHorizontalStack),
      ("testImage", testImage),
      ("testKeyModifiers", testKeyModifiers),
      ("testLabel", testLabel),
      ("testLayoutConstraintPriority", testLayoutConstraintPriority),
      ("testLegacyView", testLegacyView),
      ("testLog", testLog),
      ("testMenu", testMenu),
      ("testMenuBar", testMenuBar),
      ("testMenuComponentsBuilder", testMenuComponentsBuilder),
      ("testMenuComponentsConcatenation", testMenuComponentsConcatenation),
      ("testMenuEntry", testMenuEntry),
      ("testNotification", testNotification),
      ("testNSRectEdge", testNSRectEdge),
      ("testPoint", testPoint),
      ("testPopOver", testPopOver),
      ("testPopOverAttachmentAnchor", testPopOverAttachmentAnchor),
      ("testQuickActionDetails", testQuickActionDetails),
      ("testRectangle", testRectangle),
      ("testRichText", testRichText),
      ("testSegmentedControl", testSegmentedControl),
      ("testSize", testSize),
      ("testSwiftUIViewImplementation", testSwiftUIViewImplementation),
      ("testSystemInterface", testSystemInterface),
      ("testTable", testTable),
      ("testTextEditor", testTextEditor),
      ("testTextField", testTextField),
      ("testTextView", testTextView),
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
      ("testApplicationName", testApplicationName),
      ("testButtonCocoaImplementation", testButtonCocoaImplementation),
      ("testButtonLabel", testButtonLabel),
      ("testCheckBoxCocoaImplementation", testCheckBoxCocoaImplementation),
      ("testImage", testImage),
      ("testLegacyView", testLegacyView),
      ("testMenuEntry", testMenuEntry),
      ("testNSApplicationDelegate", testNSApplicationDelegate),
      ("testPopOverCocoaImplementation", testPopOverCocoaImplementation),
      ("testPreferenceManager", testPreferenceManager),
      ("testProportionedView", testProportionedView),
      ("testSegmentedControlCocoaImplementation", testSegmentedControlCocoaImplementation),
      ("testStrictString", testStrictString),
      ("testUIApplicationDelegate", testUIApplicationDelegate),
      ("testUIResponder", testUIResponder),
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

extension SDGProgressIndicatorsTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLabelledProgressBar", testLabelledProgressBar),
      ("testProgressBar", testProgressBar),
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += SDGInterfaceTests.APITests.windowsTests
tests += SDGInterfaceTests.InternalTests.windowsTests
tests += SDGInterfaceTests.RegressionTests.windowsTests
tests += SDGKeyboardTests.APITests.windowsTests
tests += SDGProgressIndicatorsTests.APITests.windowsTests

XCTMain(tests)
