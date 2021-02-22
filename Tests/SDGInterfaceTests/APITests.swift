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
import SDGTextDisplay
import SDGApplication

import SDGInterfaceLocalizations

import SDGInterfaceSample

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

  func testAnchorSource() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        var shimmed = RectangularAttachmentAnchor.rectangle(SDGInterface.Rectangle())
        _ = Anchor<CGRect>.Source(shimmed)
        shimmed = .bounds
        _ = Anchor<CGRect>.Source(shimmed)
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

  func testCocoaViewImplementation() {
    #if canImport(AppKit) || canImport(UIKit)
      let view = CocoaViewExample()
      _ = view.cocoa()
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          _ = view.swiftUI()
        }
      #endif
    #endif
  }

  func testCocoaWindow() {
    #if canImport(AppKit) || canImport(UIKit)
      let window = CocoaWindow(CocoaWindow.NativeType()).cocoa()
      window.size = Size(width: 100, height: 100)
    #endif
  }

  func testCocoaWindowImplementation() {
    #if canImport(AppKit) || canImport(UIKit)
      _ = CocoaWindowExample().cocoa()
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

  func testKeyModifiers() {
    let modifiers: KeyModifiers = [.command, .shift, .option, .control, .function, .capsLock]
    #if canImport(AppKit)
      XCTAssertEqual(KeyModifiers(modifiers.cocoa), modifiers)
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
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      let combined = SDGInterface.EmptyView().popOver(
        isPresented: Shared(false),
        content: { SDGInterface.EmptyView() }
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

  func testMenu() {
    #if (canImport(AppKit) || canImport(UIKit)) && !os(tvOS) && !os(watchOS)
      _ = MenuEntry(label: UserFacing<StrictString, APILocalization>({ _ in "..." }))
      let menuLabel = UserFacing<StrictString, APILocalization>({ _ in "initial" })
      let menu = SDGInterface.Menu<APILocalization>(label: menuLabel, entries: [])
      _ = menu.cocoa()
    #endif
  }

  func testMenuComponent() {
    #if (canImport(AppKit) || canImport(UIKit)) && !os(tvOS) && !os(watchOS)
      XCTAssertNotNil(
        MenuComponent.entry(
          MenuEntry<SDGInterfaceLocalizations.InterfaceLocalization>(
            label: UserFacing<StrictString, SDGInterfaceLocalizations.InterfaceLocalization>({ _ in "" })
          )
        ).asEntry
      )
      #if canImport(AppKit)
        XCTAssertNotNil(
          MenuComponent.submenu(
            SDGInterface.Menu<SDGInterfaceLocalizations.InterfaceLocalization>(
              label: UserFacing<StrictString, SDGInterfaceLocalizations.InterfaceLocalization>({ _ in "" }),
              entries: []
            )
          ).asSubmenu
        )
        XCTAssertNil(
          MenuComponent.submenu(
            SDGInterface.Menu<SDGInterfaceLocalizations.InterfaceLocalization>(
              label: UserFacing<StrictString, SDGInterfaceLocalizations.InterfaceLocalization>({ _ in "initial" }),
              entries: []
            )
          ).asEntry
        )
        XCTAssertNil(
          MenuComponent.entry(
            MenuEntry<SDGInterfaceLocalizations.InterfaceLocalization>(
              label: UserFacing<StrictString, SDGInterfaceLocalizations.InterfaceLocalization>({ _ in "" })
            )
          )
          .asSubmenu
        )
      #endif
    #endif
  }

  func testMenuEntry() {
    #if (canImport(AppKit) || canImport(UIKit)) && !os(tvOS) && !os(watchOS)
      let menuLabel = Shared<StrictString>("initial")
      let entry = MenuEntry<APILocalization>(
        label: UserFacing<StrictString, APILocalization>({ _ in "" })
      )
      menuLabel.value = "changed"
      menuLabel.value = "unrelated"
      _ = entry.cocoa()
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
        shimmed = AttachmentAnchor.rectangle(.rectangle(SDGInterface.Rectangle()))
        _ = PopoverAttachmentAnchor(shimmed)
      }
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
        let view = SwiftUIViewExample()
        _ = view.swiftUI()
        #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
          _ = view.cocoa()
        #endif
      }
    #endif
  }

  func testTable() {
    #if canImport(AppKit) || canImport(UIKit)
      let data = Shared([0])
      let table = Table<Int>(
        data: data,
        columns: [
          { integer in
            let view = CocoaView()
            view.fill(
              with: SDGTextDisplay.Label<SDGInterfaceLocalizations.InterfaceLocalization>(
                UserFacing({ _ in "\(integer.inDigits())" })
              )
              .cocoa()
            )
            return AnyView(view)
          }
        ],
        sort: { $0 < $1 }
      )
      let cocoa = table.cocoa()
      data.value = [2, 1]
      let window = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
        content: cocoa
      )
      window.display()
      #if canImport(UIKit)
        data.value = [2, 1]
        let uiTableView = table.cocoa().native as! UITableView
        uiTableView.dataSource?.tableView(
          uiTableView,
          cellForRowAt: IndexPath(row: 0, section: 0)
        )
        uiTableView.dataSource?.tableView(
          uiTableView,
          cellForRowAt: IndexPath(row: 0, section: 0)
        )
      #endif
    #endif
  }

  func testUIPopOverArrowDirection() {
    #if canImport(UIKit) && !(os(iOS) && arch(arm)) && !os(watchOS)
      var set: Set<UIPopoverArrowDirection.RawValue> = []
      for edge in SDGInterface.Edge.allCases {
        set.insert(UIPopoverArrowDirection(edge).rawValue)
      }
      XCTAssertEqual(set.count, SDGInterface.Edge.allCases.count)
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
        testViewConformance(of: SwiftUIViewExample())
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

      if #available(macOS 11, tvOS 14, iOS 14, *) {
        #if !(canImport(UIKit) && (os(iOS) && arch(arm)))
          _ =
            Window(
              type: .primary(Size(width: 100, height: 100)),
              name: UserFacing<StrictString, AnyLocalization>({ _ in "Title" }),
              content: EmptyView()
            ).body.body
          #if canImport(AppKit)
            _ =
              Window(
                type: .fullscreen,
                name: UserFacing<StrictString, AnyLocalization>({ _ in "Title" }),
                content: EmptyView()
              ).body.body
          #endif
        #endif
      }
    #endif
  }
}
