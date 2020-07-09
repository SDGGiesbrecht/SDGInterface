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

import SDGViews
import SDGWindows
import SDGPopOvers
import SDGApplication

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testPopOver() {
    #if canImport(AppKit) || canImport(UIKit)
      let window = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
        content: EmptyView().cocoa()
      ).cocoa()
      window.content.displayPopOver(EmptyView())
      #if canImport(UIKit)
        CocoaView().displayPopOver(EmptyView())
      #endif
    #endif
  }
}
