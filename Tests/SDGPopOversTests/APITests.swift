/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGInterface
import SDGViews
import SDGWindows
import SDGPopOvers
import SDGApplication

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

import SDGViewsTestUtilities
import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testAnchorSource() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        var shimmed = RectangularAttachmentAnchor.rectangle(SDGInterfaceBasics.Rectangle())
        _ = Anchor<CGRect>.Source(shimmed)
        shimmed = .bounds
        _ = Anchor<CGRect>.Source(shimmed)
      }
    #endif
  }

  func testCocoaView() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      let anchor = CocoaView()
      let window = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
        content: anchor
      )
      let cocoaWindow = window.cocoa()
      defer { cocoaWindow.close() }
      let popOver = CocoaView()
      anchor.displayPopOver(popOver, attachmentAnchor: .point(Point(0, 0)))
      anchor.displayPopOver(
        popOver,
        attachmentAnchor: .rectangle(
          .rectangle(Rectangle(origin: Point(10, 20), size: Size(width: 30, height: 40)))
        )
      )
    #endif
  }

  func testLegacyView() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      let combined = SDGViews.EmptyView().popOver(
        isPresented: Shared(false),
        content: { SDGViews.EmptyView() }
      )
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        let testBody: Bool
        #if os(tvOS)
          testBody = false
        #else
          testBody = true
        #endif
        testViewConformance(of: combined, testBody: testBody)
      }
    #endif
  }

  func testPopOver() {
    #if canImport(AppKit) || canImport(UIKit)
      let window = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
        content: EmptyView().cocoa()
      ).cocoa()
      window.content?.displayPopOver(EmptyView())
      #if canImport(UIKit)
        CocoaView().displayPopOver(EmptyView())
      #endif
    #endif
  }

  func testPopOverAttachmentAnchor() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        var shimmed = AttachmentAnchor.point(Point(0, 0))
        _ = PopoverAttachmentAnchor(shimmed)
        shimmed = AttachmentAnchor.rectangle(.rectangle(SDGInterfaceBasics.Rectangle()))
        _ = PopoverAttachmentAnchor(shimmed)
      }
    #endif
  }

  func testUIPopOverArrowDirection() {
    #if canImport(UIKit) && !(os(iOS) && arch(arm)) && !os(watchOS)
      var set: Set<UIPopoverArrowDirection.RawValue> = []
      for edge in SDGInterfaceBasics.Edge.allCases {
        set.insert(UIPopoverArrowDirection(edge).rawValue)
      }
      XCTAssertEqual(set.count, SDGInterfaceBasics.Edge.allCases.count)
    #endif
  }
}
