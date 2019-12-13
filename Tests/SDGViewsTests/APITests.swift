/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGControlFlow

import SDGViews
import SDGWindows
import SDGApplication

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testCocoaViewImplementation() {
    #if canImport(AppKit) || canImport(UIKit)
      let view = CocoaExample()
      _ = view.cocoaView
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, iOS 13, tvOS 13, *) {
          _ = view.swiftUIView
        }
      #endif
    #endif
  }

  func testLetterbox() {
    #if canImport(AppKit) || canImport(UIKit)
      Application.shared.demonstrateLetterbox()
      let letterbox = Letterbox(content: EmptyView(), aspectRatio: 1)
      letterbox.colour = .red
      XCTAssertEqual(letterbox.colour?.opacity, 1)
    #endif
  }

  func testRowView() {
    #if canImport(AppKit) || canImport(UIKit)
      if #available(iOS 9, *) {  // @exempt(from: unicode)
        let row = RowView(views: [AnyCocoaView()])
        row.views = [AnyCocoaView()]
        _ = RowView(views: [AnyCocoaView(), AnyCocoaView()], spacing: .specific(0))
      }
    #endif
  }

  func testSwiftUIViewImplementation() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, iOS 13, tvOS 13, *) {  // @exempt(from: unicode)
        let view = SwiftUIExample()
        _ = view.swiftUIView
        #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
          _ = view.cocoaView
        #endif
      }
    #endif
  }

  func testView() {
    #if canImport(AppKit) || canImport(UIKit)
      func newView() -> AnyCocoaView {
        #if canImport(AppKit)
          let native = NSView()
        #elseif canImport(UIKit)
          let native = UIView()
        #endif
        return AnyCocoaView(native)
      }
      newView().fill(with: EmptyView())
      newView().setMinimumSize(size: 10, axis: .horizontal)
      newView().position(subviews: [EmptyView(), EmptyView()], inSequenceAlong: .vertical)
      newView().centre(subview: EmptyView())
      newView().equalizeSize(amongSubviews: [EmptyView(), EmptyView()], on: .horizontal)
      newView().equalizeSize(amongSubviews: [EmptyView(), EmptyView()], on: .vertical)
      newView().lockSizeRatio(
        toSubviews: [EmptyView(), EmptyView()],
        coefficient: 1,
        axis: .horizontal
      )
      newView().lockSizeRatio(
        toSubviews: [EmptyView(), EmptyView()],
        coefficient: 1,
        axis: .vertical
      )
      newView().alignCentres(ofSubviews: [EmptyView(), EmptyView()], on: .horizontal)
      newView().alignCentres(ofSubviews: [EmptyView(), EmptyView()], on: .vertical)
      newView().alignLastBaselines(ofSubviews: [EmptyView(), EmptyView()])
      _ = newView().aspectRatio(1, contentMode: .fit)
      newView().position(
        subviews: [EmptyView(), EmptyView()],
        inSequenceAlong: .horizontal,
        padding: .specific(0),
        leadingMargin: .specific(8),
        trailingMargin: .automatic
      )

      #if !(os(iOS) && arch(arm))
        if #available(macOS 10.15, iOS 13, tvOS 13, *) {
          let swiftUI = newView().swiftUIView
          let window = Window<InterfaceLocalization>.primaryWindow(
            name: .binding(Shared("")),
            view: swiftUI
          )
          window.display()
          window.close()
        }
      #endif

      forAllLegacyModes {
        #if canImport(AppKit)
          class Sizeless: NSView, CocoaViewImplementation {
            override var intrinsicContentSize: NSSize {
              return NSSize(width: 1, height: 0)
            }
          }
        #else
          class Sizeless: UIView, CocoaViewImplementation {
            override var intrinsicContentSize: CGSize {
              return CGSize(width: 1, height: 0)
            }
          }
        #endif
        _ = Sizeless().aspectRatio(nil, contentMode: .fill)
      }
    #endif
  }
}
