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
import SDGWindows

import SDGInterfaceLocalizations

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testWindow() {
    #if canImport(AppKit) || canImport(UIKit)
      let window = Window<InterfaceLocalization>(
        name: .binding(Shared("Title")),
        view: EmptyView().cocoa()
      )
      #if canImport(AppKit)  // UIKit raises an exception during tests.
        window.display()
        window.location = Point(100, 200)
        window.size = Size(width: 300, height: 400)
      #endif
      defer { window.close() }

      #if canImport(AppKit)
        window.isFullscreen = true
        _ = window.isFullscreen
        let fullscreenWindow = Window<InterfaceLocalization>(
          name: .binding(Shared("Fullscreen")),
          view: EmptyView().cocoa()
        )
        fullscreenWindow.isFullscreen = true
        fullscreenWindow.display()
        defer { fullscreenWindow.close() }
      #endif
      RunLoop.main.run(until: Date() + 3)

      #if canImport(AppKit)
        window.native.title = "Replaced Title"
        XCTAssert(window.native.title == "Replaced Title")
      #endif

      let neverOnscreen = Window<InterfaceLocalization>(
        name: .binding(Shared("Never Onscreen")),
        view: EmptyView().cocoa()
      )
      neverOnscreen.centreInScreen()

      #if canImport(UIKit)
        _ = Window<InterfaceLocalization>(
          name: .binding(Shared("Title")),
          view: EmptyView().cocoa()
        )
      #endif

      window.name = .static(UserFacing({ _ in "Modified Title" }))

      let primary = Window<InterfaceLocalization>.primaryWindow(
        name: .binding(Shared("...")),
        view: EmptyView().cocoa()
      )
      _ = primary.size
      _ = primary.location
      primary.view = EmptyView().cocoa()
      #if canImport(AppKit)
        XCTAssert(primary.isPrimary)
        primary.isPrimary = false
        XCTAssertFalse(primary.isFullscreen)
        primary.isFullscreen = false
      #endif

      #if canImport(AppKit)
        let auxiliary = Window<InterfaceLocalization>.auxiliaryWindow(
          name: .binding(Shared("...")),
          view: EmptyView().cocoa()
        )
        XCTAssert(auxiliary.isAuxiliary)
        primary.isAuxiliary = false
      #endif

      _ = window.isVisible
      window.location = Point(0, 0)
    #endif
  }
}
