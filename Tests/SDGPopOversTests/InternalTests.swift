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

import SDGViews
@testable import SDGPopOvers

import XCTest

import SDGViewsTestUtilities
import SDGApplicationTestUtilities

final class InternalTests: ApplicationTestCase {

  func testLegacyView() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      forAllLegacyModes {
        let combined = SDGViews.EmptyView().popOver(
          isPresented: Shared(false),
          content: { SDGViews.EmptyView() }
        )
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          testViewConformance(of: combined)
        }
      }
    #endif
  }
}
