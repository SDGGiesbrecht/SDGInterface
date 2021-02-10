/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGInterfaceBasics
import SDGViews
import SDGWindows

import SDGInterfaceLocalizations

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testCocoaWindow() {
    #if canImport(AppKit) || canImport(UIKit)
      let window = CocoaWindow(CocoaWindow.NativeType()).cocoa()
      window.size = Size(width: 100, height: 100)
    #endif
  }

  func testCocoaWindowImplementation() {
    #if canImport(AppKit) || canImport(UIKit)
      _ = CocoaExample().cocoa()
    #endif
  }

  func testWindow() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      let window = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "Title" }),
        content: EmptyView().cocoa()
      ).cocoa()
      #if canImport(AppKit)  // UIKit raises an exception during tests.
        window.display()
        window.location = Point(100, 200)
        window.size = Size(width: 300, height: 400)
      #endif
      defer { window.close() }

      #if canImport(AppKit)
        window.isFullscreen = true
        _ = window.isFullscreen
        let fullscreenWindow = Window(
          type: .fullscreen,
          name: UserFacing<StrictString, AnyLocalization>({ _ in "Fullscreen" }),
          content: EmptyView().cocoa()
        ).cocoa()
        fullscreenWindow.isFullscreen = true
        fullscreenWindow.display()
        defer { fullscreenWindow.close() }
      #endif
      RunLoop.main.run(until: Date() + 3)

      let neverOnscreen = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "Fullscreen" }),
        content: EmptyView().cocoa()
      ).cocoa()
      neverOnscreen.centreInScreen()

      #if canImport(UIKit)
        _ = Window(
          type: .primary(nil),
          name: UserFacing<StrictString, AnyLocalization>({ _ in "Title" }),
          content: EmptyView().cocoa()
        )
      #endif

      let primary = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "..." }),
        content: EmptyView().cocoa()
      ).cocoa()
      _ = primary.size
      _ = primary.location
      #if canImport(AppKit)
        XCTAssert(primary.isPrimary)
        primary.isPrimary = false
        XCTAssertFalse(primary.isFullscreen)
        primary.isFullscreen = false
      #endif

      #if canImport(AppKit)
        let auxiliary = Window(
          type: .auxiliary(nil),
          name: UserFacing<StrictString, AnyLocalization>({ _ in "..." }),
          content: EmptyView().cocoa()
        ).cocoa()
        XCTAssert(auxiliary.isAuxiliary)
        primary.isAuxiliary = false
      #endif

      _ = window.isVisible
      window.location = Point(0, 0)

      if #available(macOS 11, *) {
        _ =
          Window(
            type: .primary(Size(width: 100, height: 100)),
            name: UserFacing<StrictString, AnyLocalization>({ _ in "Title" }),
            content: EmptyView()
          ).body.body
        _ =
          Window(
            type: .fullscreen,
            name: UserFacing<StrictString, AnyLocalization>({ _ in "Title" }),
            content: EmptyView()
          ).body.body
      }
    #endif
  }
}
