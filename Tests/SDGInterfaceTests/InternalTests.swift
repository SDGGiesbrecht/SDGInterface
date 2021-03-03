/*
 InternalTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

import SDGControlFlow
import SDGText
import SDGLocalization

@testable import SDGInterface

import SDGInterfaceLocalizations

import XCTest

import SDGInterfaceTestUtilities
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

  func testButtonLabel() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        _ = ButtonLabel.text("text").swiftUI()
        _ = ButtonLabel.symbol(Image.empty).swiftUI()
      }
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

  func testImage() {
    #if canImport(AppKit)
      XCTAssertNil(Image(systemIdentifier: "no such image"))
    #endif
  }

  func testLegacyView() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      forAllLegacyModes {
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          let combined = SDGInterface.EmptyView().popOver(
            isPresented: Shared(false),
            content: { SDGInterface.EmptyView() }
          ).adjustForLegacyMode()
          testViewConformance(of: combined, testBody: false)
        }
      }
    #endif
  }

  func testPopOverCocoaImplementation() {
    withLegacyMode {
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        let isPresented = Shared(false)
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          let combined = SDGInterface.EmptyView().popOver(
            isPresented: isPresented,
            content: { SDGInterface.EmptyView() }
          ).adjustForLegacyMode()
          let window = Window(
            type: .primary(nil),
            name: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
            content: combined
          )
          window.display()
          isPresented.value = true
        }
      #endif
    }
  }

  func testProportionedView() {
    #if canImport(AppKit) || canImport(UIKit)
      _ = Proportioned(content: CocoaView(), aspectRatio: 1, contentMode: .fill).cocoa()
      _ = Proportioned(content: CocoaView(), aspectRatio: 1, contentMode: .fit).cocoa()
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
      #if canImport(AppKit)
        cocoa.selectSegment(withTag: 1)
      #else
        cocoa.selectedSegmentIndex = 1
      #endif
    #endif
  }

  func testStrictString() {
    var string = StrictString()
    string.compatibility = "..."
    _ = string.compatibility
  }

  func testUIResponder() {
    #if canImport(UIKit) && !os(tvOS)
      let executed = expectation(description: "Action executed.")
      let menuEntry = MenuEntry(
        label: UserFacing<StrictString, SDGInterfaceLocalizations.InterfaceLocalization>(
          { _ in
            "Menu Item"
          }),
        action: { executed.fulfill() }
      )
      UILabel().executeClosureAction(menuEntry.cocoa())
      wait(for: [executed], timeout: 1)
    #endif
  }
}
