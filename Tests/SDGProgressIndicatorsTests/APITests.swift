/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLocalization

import SDGInterface
import SDGProgressIndicators

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

import SDGInterfaceTestUtilities
import SDGInterfaceInternalTestUtilities

final class APITests: ApplicationTestCase {

  func testLabelledProgressBar() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      if #available(watchOS 7, *) {
        let bar = LabelledProgressBar<InterfaceLocalization>(
          label: Label<InterfaceLocalization>(UserFacing({ _ in "" })),
          progressBar: ProgressBar(range: Shared(0...1), value: Shared(nil))
        )
        #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
          _ = bar.cocoa()
        #endif
      }
    #endif
  }

  func testProgressBar() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      let range: Shared<ClosedRange<Double>> = Shared(0...1)
      let value: Shared<Double?> = Shared(nil)
      if #available(watchOS 7, *) {
        let bar = ProgressBar(range: range, value: value)
        range.value = 0...range.value.upperBound
        range.value = range.value.lowerBound...10
        value.value = 5

        if #available(tvOS 13, iOS 13, *) {
          testViewConformance(of: bar, testBody: false)
        }

        let inderminate = ProgressBar(range: Shared(0...1), value: Shared(nil))
        if #available(tvOS 13, iOS 13, *) {
          testViewConformance(of: inderminate, testBody: false)
        }

        withLegacyMode {
          if #available(tvOS 13, iOS 13, *) {
            #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
              _ = bar.swiftUI()
            #endif
          }
        }
      }
    #endif
  }
}
