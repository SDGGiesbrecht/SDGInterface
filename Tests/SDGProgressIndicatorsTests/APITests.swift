/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

import SDGProgressIndicators
import SDGApplication

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testLabelledProgressBar() {
    #if canImport(AppKit) || canImport(UIKit)
      let bar = LabelledProgressBar<InterfaceLocalization>(labelText: .binding(Shared("")))
      XCTAssertEqual(bar.progressBar.progressValue, nil)
      XCTAssertEqual(bar.label.text.resolved(), "")
      _ = bar.cocoaView
    #endif
  }

  func testProgressBar() {
    #if canImport(AppKit) || canImport(UIKit)
      let bar = ProgressBar()
      XCTAssertEqual(bar.progressValue, nil)
      bar.startValue = 0
      XCTAssertEqual(bar.startValue, 0)
      bar.endValue = 10
      XCTAssertEqual(bar.endValue, 10)
      bar.progressValue = 5
      XCTAssertEqual(bar.progressValue, 5)
    #endif
  }
}
