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
import SDGLocalization

import SDGTextDisplay
import SDGProgressIndicators
import SDGApplication

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testLabelledProgressBar() {
    #if canImport(AppKit) || canImport(UIKit)
      let bar = LabelledProgressBar<InterfaceLocalization>(
        label: Label<InterfaceLocalization>(UserFacing({ _ in "" })),
        progressBar: ProgressBar(range: Shared(0...1), value: Shared(nil))
      )
      _ = bar.cocoa()
    #endif
  }

  func testProgressBar() {
    #if canImport(AppKit) || canImport(UIKit)
      let range: Shared<ClosedRange<Double>> = Shared(0...1)
      let value: Shared<Double?> = Shared(nil)
      _ = ProgressBar(range: range, value: value)
      range.value = 0...range.value.upperBound
      range.value = range.value.lowerBound...10
      value.value = 5
    #endif
  }
}
