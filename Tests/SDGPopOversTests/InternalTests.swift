/*
 InternalTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGViews
import SDGWindows
@testable import SDGPopOvers

import XCTest

import SDGViewsTestUtilities
import SDGApplicationTestUtilities

final class InternalTests: ApplicationTestCase {

  func testLegacyView() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      forAllLegacyModes {
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          let combined = SDGViews.EmptyView().popOver(
            isPresented: Shared(false),
            content: { SDGViews.EmptyView() }
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
          let combined = SDGViews.EmptyView().popOver(
            isPresented: isPresented,
            content: { SDGViews.EmptyView() }
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
}
