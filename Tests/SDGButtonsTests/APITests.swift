/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGInterfaceBasics
import SDGButtons
import SDGApplication

import SDGInterfaceLocalizations

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

import SDGViewsTestUtilities
import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testButton() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      Application.shared.demonstrateButton()
      let label = UserFacing<StrictString, SDGInterfaceLocalizations.InterfaceLocalization>(
        { localization in
          return "Button"
        }
      )
      let button = Button(label: label, action: {})
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        testViewConformance(of: button)
      }
    #endif
  }

  func testCheckBox() {
    #if canImport(AppKit) || canImport(UIKit)
      Application.shared.demonstrateCheckBox()
      #if canImport(AppKit)
        let label = Shared<StrictString>("Check Box")
        let binding: Binding<StrictString, APILocalization> = .binding(label)
        let checkBox = CheckBox(label: binding)
        label.value = "Changed"
        XCTAssertEqual(checkBox.specificCocoaView.title, "Changed")
        checkBox.label = .binding(Shared("Changed again."))
      #endif
    #endif
  }

  func testRadioButtonSet() {
    #if canImport(AppKit) || canImport(UIKit)
      Application.shared.demonstrateRadioButtonSet()
    #endif
  }
}
