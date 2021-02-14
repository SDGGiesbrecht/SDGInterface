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
#if canImport(AppKit)
  import AppKit
#endif

import SDGControlFlow
import SDGLogic
import SDGText
import SDGLocalization

import SDGInterface
import SDGWindows
import SDGApplication

import SDGInterfaceLocalizations

import XCTest

import SDGXCTestUtilities

import SDGInterfaceTestUtilities
import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testAlignment() {
    XCTAssertEqual(SDGInterface.Alignment(horizontal: .centre, vertical: .centre), .centre)
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        var swiftUI: SwiftUI.Alignment = .center
        var sdgInterface = SDGInterface.Alignment(swiftUI)!
        XCTAssertEqual(sdgInterface, .centre)
        XCTAssertEqual(SwiftUI.Alignment(sdgInterface), .center)
        swiftUI = .topLeading
        sdgInterface = SDGInterface.Alignment(swiftUI)!
        XCTAssertEqual(sdgInterface, .topLeading)
        XCTAssertEqual(SwiftUI.Alignment(sdgInterface), .topLeading)
        swiftUI = .bottomTrailing
        sdgInterface = SDGInterface.Alignment(swiftUI)!
        XCTAssertEqual(sdgInterface, .bottomTrailing)
        XCTAssertEqual(SwiftUI.Alignment(sdgInterface), .bottomTrailing)
      }
    #endif
  }

  func testAnyView() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        _ = AnyView(EmptyView()).swiftUI()
      }
    #endif
  }

  func testApplicationName() {
    // #workaround(Swift 5.3.2, Web lacks ProcessInfo.)
    #if !os(WASI)
      XCTAssertEqual(ProcessInfo.applicationName(.español(.de)), "del Ejemplar")
      XCTAssertEqual(ProcessInfo.applicationName(.deutsch(.akkusativ)), "Beispiel")
      XCTAssertEqual(ProcessInfo.applicationName(.deutsch(.dativ)), "Beispiel")
      XCTAssertEqual(ProcessInfo.applicationName(.français(.de)), "de l’Exemple")
      XCTAssertEqual(ProcessInfo.applicationName(.ελληνικά(.αιτιατική)), "το Παράδειγμα")
      XCTAssertEqual(ProcessInfo.applicationName(.ελληνικά(.γενική)), "του Παραδείγματος")
    #endif
  }

  func testBackground() {
    #if canImport(AppKit) || canImport(UIKit)
      forAllLegacyModes {
        _ = Colour.red.background(Colour.blue).cocoa()
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

  func testColour() {
    XCTAssertEqual(Colour.white.red, 1)
    XCTAssertEqual(Colour.black.green, 0)
    XCTAssertEqual(Colour.blue.blue, 1)
    XCTAssertEqual(Colour.green.opacity, 1)
    XCTAssertEqual(Colour.cyan.red, 0)
    XCTAssertEqual(Colour.red.green, 0)
    XCTAssertEqual(Colour.magenta.blue, 1)
    XCTAssertEqual(Colour.yellow.opacity, 1)
    #if canImport(AppKit)
      XCTAssertEqual(Colour.yellow.green, Colour(NSColor(Colour.yellow))?.green)
    #endif
    #if canImport(UIKit)
      XCTAssertEqual(Colour.cyan.blue, Colour(UIColor(Colour.cyan)).blue)
    #endif

    #if canImport(SwiftUI) || canImport(AppKit) || (canImport(UIKit) && !(os(iOS) && arch(arm)))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        testViewConformance(of: Colour.red, testBody: false)
      }
    #endif
  }

  func testCompositeViewImplementation() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      struct TestView: CompositeViewImplementation {
        func compose() -> SDGInterface.EmptyView {
          return EmptyView()
        }
      }
      if #available(tvOS 13, iOS 13, *) {
        testViewConformance(of: TestView(), testBody: false)
      }
    #endif
  }

  func testContentMode() {
    for mode in SDGInterface.ContentMode.allCases {
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
          let swiftUI = SwiftUI.ContentMode(mode)
          let roundTrip = SDGInterface.ContentMode(swiftUI)
          XCTAssertEqual(roundTrip, mode)
        }
      #endif
    }
  }

  func testEdge() {
    for edge in SDGInterface.Edge.allCases {
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
          let swiftUI = SwiftUI.Edge(edge)
          let roundTrip = SDGInterface.Edge(swiftUI)
          XCTAssertEqual(roundTrip, edge)
        }
      #endif
    }
  }

  func testEdgeSet() {
    let horizontal = SDGInterface.Edge.Set.horizontal
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        let swiftUIHorizontal = SwiftUI.Edge.Set(horizontal)
        let roundTrip = SDGInterface.Edge.Set(swiftUIHorizontal)
        XCTAssertEqual(roundTrip, horizontal)
        for edge in SDGInterface.Edge.allCases {
          let swiftUIEdge = SwiftUI.Edge(edge)
          let entry = SDGInterface.Edge.Set(edge)
          let swiftUIEntry = SwiftUI.Edge.Set(swiftUIEdge)
          XCTAssertEqual(horizontal.contains(entry), swiftUIHorizontal.contains(swiftUIEntry))
        }
      }
    #endif
    for edge in SDGInterface.Edge.allCases {
      let set = SDGInterface.Edge.Set(edge)
      XCTAssert(set.contains(SDGInterface.Edge.Set(edge)))
      for other in SDGInterface.Edge.allCases where other ≠ edge {
        XCTAssertFalse(set.contains(SDGInterface.Edge.Set(other)))
      }
    }
  }

  func testEmptyView() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        _ = EmptyView().swiftUI()
      }
    #endif
  }

  func testHorizontalStack() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *) {
        testViewConformance(
          of: HorizontalStack(spacing: 0, content: [AnyView(CocoaView())]),
          testBody: false
        )
        testViewConformance(
          of: HorizontalStack(alignment: .top, spacing: 1, content: [AnyView(CocoaView())]),
          testBody: false
        )
        testViewConformance(
          of: HorizontalStack(alignment: .bottom, spacing: 2, content: [AnyView(CocoaView())]),
          testBody: false
        )
      }
    #endif
  }

  func testLayoutConstraintPriority() {
    #if canImport(AppKit) || canImport(UIKit)
      _ = LayoutConstraintPriority(rawValue: 500)
    #endif
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

  func testNSRectEdge() {
    #if canImport(AppKit)
      var converted: Set<NSRectEdge> = []
      for edge in SDGInterface.Edge.allCases {
        converted.insert(NSRectEdge(edge))
      }
      XCTAssertEqual(converted.count, 4)
    #endif
  }

  func testPoint() {
    #if canImport(CoreGraphics)
      XCTAssertEqual(Point(CGPoint(x: 0, y: 0)), Point(0, 0))
      XCTAssertEqual(CGPoint(Point(0, 0)).x, 0)
    #endif
  }

  func testRectangle() {
    XCTAssertEqual(Rectangle(origin: Point(1, 2), size: Size(width: 3, height: 4)).size.height, 4)
    #if canImport(CoreGraphics)
      XCTAssertEqual(
        CGRect(Rectangle(origin: Point(1, 2), size: Size(width: 3, height: 4))).width,
        3
      )
      XCTAssertEqual(
        Rectangle(CGRect(x: 1, y: 2, width: 3, height: 4)),
        Rectangle(origin: Point(1, 2), size: Size(width: 3, height: 4))
      )
    #endif
  }

  func testSize() {
    XCTAssertEqual(Size(), Size(width: 0, height: 0))
    #if canImport(CoreGraphics)
      XCTAssertEqual(Size(CGSize(width: 0, height: 0)), Size(width: 0, height: 0))
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

  func testUnitPoint() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      let point = Point(1, 2)
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        let converted = UnitPoint(point)
        XCTAssertEqual(converted.x, 1)
        XCTAssertEqual(converted.y, 2)
        XCTAssertEqual(Point(converted), point)
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
        EmptyView().cocoa(), EmptyView().cocoa(),
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
          let window = Window(
            type: .primary(nil),
            name: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
            content: SwiftUI.AnyView(swiftUI).cocoa()
          ).cocoa()
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
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        testViewConformance(of: SwiftUIExample())
      }
    #endif
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        struct SomeView: SwiftUI.View {
          var body: some SwiftUI.View {
            return SwiftUI.EmptyView()
          }
        }
        testViewConformance(of: SomeView())
      }
    #endif
  }
}
