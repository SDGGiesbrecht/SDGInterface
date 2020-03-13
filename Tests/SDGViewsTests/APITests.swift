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
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        _ = AnyView(EmptyView()).swiftUI()
      }
    #endif
  }

  func testCocoaViewImplementation() {
    #if canImport(AppKit) || canImport(UIKit)
      let view = CocoaExample()
      _ = view.cocoa()
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          _ = view.swiftUI()
        }
      #endif
    #endif
  }

  func testBackground() {
    #if canImport(AppKit) || canImport(UIKit)
      forAllLegacyModes {
        _ = Colour.red.background(Colour.blue).cocoa()
      }
    #endif
  }

  func testColour() {
    #if canImport(AppKit) || canImport(UIKit) && !(os(iOS) && arch(arm))
      _ = Colour.red.cocoa()
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        _ = Colour.green.swiftUI()
      }
    #endif
  }

  func testEmptyView() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        _ = EmptyView().swiftUI()
      }
    #endif
  }

  func testHorizontalStack() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      if #available(iOS 9, *) {
        let stack = HorizontalStack(spacing: 0, content: [AnyView(CocoaView())])
        #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
          if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
            _ = stack.swiftUI()
          }
        #endif
        _ = stack.cocoa()
      }
    #endif
  }

  func testLayoutConstraintPriority {
    _ = LayoutConstraintPriority(rawValue: 500)
  }

  func testLegacyView() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      class Legacy: LegacyView {
        func cocoa() -> CocoaView {
          return EmptyView().cocoa()
        }
      }
      if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
        _ = Legacy().swiftUIAnyView()
      }
    #endif
  }

  func testSwiftUIViewImplementation() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {  // @exempt(from: unicode)
        let view = SwiftUIExample()
        _ = view.swiftUI()
        #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
          _ = view.cocoa()
        #endif
      }
    #endif
  }

  func testView() {
    #if canImport(AppKit) || canImport(UIKit)
      func newView() -> CocoaView {
        #if canImport(AppKit)
          let native = NSView()
        #elseif canImport(UIKit)
          let native = UIView()
        #endif
        return CocoaView(native)
      }
      newView().fill(with: EmptyView().cocoa())
      newView().constrain(.width, toBe: .greaterThanOrEqual, 10)
      newView().position(
        subviews: [EmptyView().cocoa(), EmptyView().cocoa()],
        inSequenceAlong: .vertical
      )
      newView().centre(subview: EmptyView().cocoa())
      newView().equalize(.width, amongSubviews: [EmptyView().cocoa(), EmptyView().cocoa()])
      newView().equalize(.height, amongSubviews: [EmptyView().cocoa(), EmptyView().cocoa()])
      newView().constrain(
        .width,
        toBe: .equal,
        .width,
        ofSubviews: [EmptyView().cocoa(), EmptyView().cocoa()]
      )
      newView().constrain(
        .height,
        toBe: .equal,
        .height,
        ofSubviews: [EmptyView().cocoa(), EmptyView().cocoa()]
      )
      newView().alignCentres(
        ofSubviews: [EmptyView().cocoa(), EmptyView().cocoa()],
        on: .horizontal
      )
      newView().alignCentres(
        ofSubviews: [EmptyView().cocoa(), EmptyView().cocoa()],
        on: .vertical
      )
      newView().alignLastBaselines(ofSubviews: [
        EmptyView().cocoa(), EmptyView().cocoa()
      ])
      _ = newView().aspectRatio(1, contentMode: .fit).cocoa()
      newView().position(
        subviews: [EmptyView().cocoa(), EmptyView().cocoa()],
        inSequenceAlong: .horizontal,
        padding: 0,
        leadingMargin: 0,
        trailingMargin: nil
      )

      #if !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          let swiftUI = newView().swiftUI()
          let window = Window<InterfaceLocalization>.primaryWindow(
            name: .binding(Shared("")),
            view: SwiftUI.AnyView(swiftUI).cocoa()
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
          IntrinsicSize(CGSize(width: 0, height: 1)).aspectRatio(nil, contentMode: .fill).cocoa()
        _ =
          IntrinsicSize(CGSize(width: 1, height: 0)).aspectRatio(nil, contentMode: .fill).cocoa()
        _ =
          IntrinsicSize(CGSize(width: 1, height: 1)).aspectRatio(nil, contentMode: .fill).cocoa()
      }

      forAllLegacyModes {
        _ = newView().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .centre).cocoa()
      }
    #endif
  }
}
