/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGControlFlow

import SDGInterfaceBasics
import SDGViews
import SDGWindows
import SDGApplication

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testAnyView() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      _ = AnyView(EmptyView()).swiftUIView
    #endif
  }

  func testCocoaViewImplementation() {
    #if canImport(AppKit) || canImport(UIKit)
      let view = CocoaExample()
      _ = view.cocoaView
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          _ = view.swiftUIView
        }
      #endif
    #endif
  }

  func testBackground() {
    #if canImport(AppKit) || canImport(UIKit)
      forAllLegacyModes {
        _ = Colour.red.background(Colour.blue).cocoaView
      }
    #endif
  }

  func testColour() {
    #if canImport(AppKit) || canImport(UIKit) && !(os(iOS) && arch(arm))
      _ = Colour.red.cocoaView
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        _ = Colour.green.swiftUIView
      }
    #endif
  }

  func testEmptyView() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        _ = EmptyView().swiftUIView
      }
    #endif
  }

  func testHorizontalStack() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      if #available(iOS 9, *) {
        let stack = HorizontalStack(spacing: 0, content: [AnyView(AnyCocoaView())])
        #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
          if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
            _ = stack.swiftUIView
          }
        #endif
        _ = stack.cocoaView
      }
    #endif
  }

  func testLegacyView() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      class Legacy: LegacyView {
        #if canImport(AppKit)
          var cocoaView: NSView {
            return EmptyView().cocoaView
          }
        #elseif canImport(UIKit)
          var cocoaView: UIView {
            return EmptyView().cocoaView
          }
        #endif
      }
      if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
        _ = Legacy().anySwiftUIView
      }
    #endif
  }

  func testStabilizedView() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
        _ = AnyCocoaView().stabilize().swiftUIView
      }
    #endif
  }

  func testSwiftUIViewImplementation() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {  // @exempt(from: unicode)
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
      newView().fill(with: EmptyView().stabilize())
      newView().setMinimumSize(size: 10, axis: .horizontal)
      newView().position(
        subviews: [EmptyView().stabilize(), EmptyView().stabilize()],
        inSequenceAlong: .vertical
      )
      newView().centre(subview: EmptyView().stabilize())
      newView().equalizeSize(
        amongSubviews: [EmptyView().stabilize(), EmptyView().stabilize()],
        on: .horizontal
      )
      newView().equalizeSize(
        amongSubviews: [EmptyView().stabilize(), EmptyView().stabilize()],
        on: .vertical
      )
      newView().lockSizeRatio(
        toSubviews: [EmptyView().stabilize(), EmptyView().stabilize()],
        coefficient: 1,
        axis: .horizontal
      )
      newView().lockSizeRatio(
        toSubviews: [EmptyView().stabilize(), EmptyView().stabilize()],
        coefficient: 1,
        axis: .vertical
      )
      newView().alignCentres(
        ofSubviews: [EmptyView().stabilize(), EmptyView().stabilize()],
        on: .horizontal
      )
      newView().alignCentres(
        ofSubviews: [EmptyView().stabilize(), EmptyView().stabilize()],
        on: .vertical
      )
      newView().alignLastBaselines(ofSubviews: [
        EmptyView().stabilize(), EmptyView().stabilize()
      ])
      _ = newView().aspectRatio(1, contentMode: .fit).cocoaView
      newView().position(
        subviews: [EmptyView().stabilize(), EmptyView().stabilize()],
        inSequenceAlong: .horizontal,
        padding: .specific(0),
        leadingMargin: .specific(8),
        trailingMargin: .automatic
      )

      #if !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          let swiftUI = newView().swiftUIView
          let window = Window<InterfaceLocalization>.primaryWindow(
            name: .binding(Shared("")),
            view: AnyView(SwiftUI.AnyView(swiftUI))
          )
          window.display()
          window.close()
        }
      #endif

      forAllLegacyModes {
        #if canImport(AppKit)
          typealias Superclass = NSView
        #else
          typealias Superclass = UIView
        #endif
        class IntrinsicSize: Superclass, CocoaViewImplementation {
          init(_ size: CGSize) {
            self.size = size
            super.init(frame: CGRect(origin: CGPoint(0, 0), size: size))
          }
          required init?(coder: NSCoder) {
            fatalError()
          }
          let size: CGSize
          override var intrinsicContentSize: CGSize {
            return size
          }
        }
        _ =
          IntrinsicSize(CGSize(width: 0, height: 1)).aspectRatio(nil, contentMode: .fill).cocoaView
        _ =
          IntrinsicSize(CGSize(width: 1, height: 0)).aspectRatio(nil, contentMode: .fill).cocoaView
        _ =
          IntrinsicSize(CGSize(width: 1, height: 1)).aspectRatio(nil, contentMode: .fill).cocoaView
      }

      forAllLegacyModes {
        _ = newView().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .centre).cocoaView
      }
    #endif
  }
}
