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
        _ = Colour.red.shimmedBackground(Colour.blue).cocoaView
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
      let stack = HorizontalStack(spacing: 0, content: [AnyCocoaView()])
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
          _ = stack.swiftUIView
        }
      #endif
      _ = stack.cocoaView
    #endif
  }

  func testStabilizedView() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
        _ = StabilizedView(AnyCocoaView()).swiftUIView
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
      newView().fill(with: StabilizedView(EmptyView()))
      newView().setMinimumSize(size: 10, axis: .horizontal)
      newView().position(
        subviews: [StabilizedView(EmptyView()), StabilizedView(EmptyView())],
        inSequenceAlong: .vertical
      )
      newView().centre(subview: StabilizedView(EmptyView()))
      newView().equalizeSize(
        amongSubviews: [StabilizedView(EmptyView()), StabilizedView(EmptyView())],
        on: .horizontal
      )
      newView().equalizeSize(
        amongSubviews: [StabilizedView(EmptyView()), StabilizedView(EmptyView())],
        on: .vertical
      )
      newView().lockSizeRatio(
        toSubviews: [StabilizedView(EmptyView()), StabilizedView(EmptyView())],
        coefficient: 1,
        axis: .horizontal
      )
      newView().lockSizeRatio(
        toSubviews: [StabilizedView(EmptyView()), StabilizedView(EmptyView())],
        coefficient: 1,
        axis: .vertical
      )
      newView().alignCentres(
        ofSubviews: [StabilizedView(EmptyView()), StabilizedView(EmptyView())],
        on: .horizontal
      )
      newView().alignCentres(
        ofSubviews: [StabilizedView(EmptyView()), StabilizedView(EmptyView())],
        on: .vertical
      )
      newView().alignLastBaselines(ofSubviews: [
        StabilizedView(EmptyView()), StabilizedView(EmptyView())
      ])
      _ = newView().aspectRatio(1, contentMode: .fit)
      newView().position(
        subviews: [StabilizedView(EmptyView()), StabilizedView(EmptyView())],
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
            view: swiftUI
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
        _ = IntrinsicSize(CGSize(width: 0, height: 1)).aspectRatio(nil, contentMode: .fill)
        _ = IntrinsicSize(CGSize(width: 1, height: 0)).aspectRatio(nil, contentMode: .fill)
        _ = IntrinsicSize(CGSize(width: 1, height: 1)).aspectRatio(nil, contentMode: .fill)
      }

      forAllLegacyModes {
        _ = newView().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .centre).cocoaView
      }
    #endif
  }
}
