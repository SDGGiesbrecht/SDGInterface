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
import SDGViews
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
        let label = UserFacing<StrictString, SDGInterfaceLocalizations.InterfaceLocalization>(
          { _ in
            "Check Box"
          })
        let checkBox = CheckBox(label: label, isChecked: Shared(false))
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          testViewConformance(of: checkBox)
        }
      #endif
    #endif
  }

  func testSegmentedControl() {
    #if swift(>=5.2.1)  // #workaround(workspace version 0.32.4, CI fails to build this test.)
      #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
        Application.shared.demonstrateSegmentedControl()

        enum Enumeration: CaseIterable {
          case a, b
        }
        let segmentedControl = SegmentedControl(
          labels: { _ in
            UserFacing<ButtonLabel, SDGInterfaceLocalizations.InterfaceLocalization>({ _ in
              .text("label")
            })
          },
          selection: Shared(Enumeration.a)
        )
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          _ = segmentedControl.swiftUI().body
        }
      #endif
    #endif
  }
}
