/*
 InternalTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit
#endif

import SDGControlFlow
import SDGText
import SDGLocalization

@testable import SDGButtons

import SDGInterfaceLocalizations

import XCTest

import SDGApplicationTestUtilities

final class InternalTests: ApplicationTestCase {

  func testButtonCocoaImplementation() {
    #if canImport(AppKit) || canImport(UIKit)
      let button = Button(
        label: UserFacing<StrictString, InterfaceLocalization>({ _ in "Button" }),
        action: {}
      )
      legacyMode = true
      defer { legacyMode = false }
      let cocoa = button.cocoa().native as! Button.Superclass
      #if canImport(AppKit)
        cocoa.sendAction(cocoa.action, to: cocoa.target)
      #else
        _ = cocoa
      #endif
    #endif
  }

  func testCheckBoxCocoaImplementation() {
    #if canImport(AppKit)
      let isChecked = Shared(false)
      let label = UserFacing<StrictString, SDGInterfaceLocalizations.InterfaceLocalization>(
        { _ in
          "Check Box"
        })
      let checkBox = CheckBox(label: label, isChecked: isChecked)
      legacyMode = true
      defer { legacyMode = false }
      let cocoa = checkBox.cocoa().native as! NSButton
      cocoa.state = .on
      XCTAssert(isChecked.value)
      isChecked.value = false
      XCTAssertEqual(cocoa.state, .off)
    #endif
  }

  func testSegmentedControlCocoaImplementation() {
    #if canImport(AppKit) || canImport(UIKit)
      enum Enumeration: CaseIterable {
        case a, b
      }
      let segmentedControl = SegmentedControl(
        labels: { _ in UserFacing<ButtonLabel, InterfaceLocalization>({ _ in .text("label") }) },
        selection: Shared(Enumeration.a)
      )
      legacyMode = true
      defer { legacyMode = false }
      let cocoa = segmentedControl.cocoa().native as! SegmentedControl.Superclass
      cocoa.selectSegment(withTag: 1)
    #endif
  }
}
