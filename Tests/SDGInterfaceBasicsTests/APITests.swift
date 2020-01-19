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
import SDGLocalization

import SDGInterfaceBasics

import SDGInterfaceLocalizations

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testAlignment() {
    XCTAssertEqual(SDGInterfaceBasics.Alignment(horizontal: .centre, vertical: .centre), .centre)
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        var swiftUI: SwiftUI.Alignment = .center
        var sdgInterface = SDGInterfaceBasics.Alignment(swiftUI)!
        XCTAssertEqual(sdgInterface, .centre)
        XCTAssertEqual(SwiftUI.Alignment(sdgInterface), .center)
        swiftUI = .topLeading
        sdgInterface = SDGInterfaceBasics.Alignment(swiftUI)!
        XCTAssertEqual(sdgInterface, .topLeading)
        XCTAssertEqual(SwiftUI.Alignment(sdgInterface), .topLeading)
        swiftUI = .bottomTrailing
        sdgInterface = SDGInterfaceBasics.Alignment(swiftUI)!
        XCTAssertEqual(sdgInterface, .bottomTrailing)
        XCTAssertEqual(SwiftUI.Alignment(sdgInterface), .bottomTrailing)
      }
    #endif
  }

  func testApplicationName() {
    XCTAssertEqual(ProcessInfo.applicationName(.español(.de)), "del Ejemplar")
    XCTAssertEqual(ProcessInfo.applicationName(.deutsch(.akkusativ)), "Beispiel")
    XCTAssertEqual(ProcessInfo.applicationName(.deutsch(.dativ)), "Beispiel")
    XCTAssertEqual(ProcessInfo.applicationName(.français(.de)), "de l’Exemple")
    XCTAssertEqual(ProcessInfo.applicationName(.ελληνικά(.αιτιατική)), "το Παράδειγμα")
    XCTAssertEqual(ProcessInfo.applicationName(.ελληνικά(.γενική)), "του Παραδείγματος")
  }

  func testBinding() {
    LocalizationSetting(orderOfPrecedence: ["zxx"]).do {
      let localized = SDGInterfaceBasics.Binding<Bool, InterfaceLocalization>.static(
        UserFacing({ _ in true })
      )
      XCTAssert(localized.resolved())
      XCTAssertNil(localized.shared)
      let bound = SDGInterfaceBasics.Binding<Bool, InterfaceLocalization>.binding(Shared(true))
      XCTAssert(bound.resolved())
      XCTAssertNotNil(bound.shared)
    }
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
      XCTAssertEqual(Colour.yellow.green, Colour(Colour.yellow.nsColor).green)
    #endif
    #if canImport(UIKit)
      XCTAssertEqual(Colour.cyan.blue, Colour(Colour.cyan.uiColor).blue)
    #endif
  }

  func testContentMode() {
    for mode in SDGInterfaceBasics.ContentMode.allCases {
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
          let swiftUI = SwiftUI.ContentMode(mode)
          let roundTrip = SDGInterfaceBasics.ContentMode(swiftUI)
          XCTAssertEqual(roundTrip, mode)
        }
      #endif
    }
  }

  func testEdge() {
    for edge in SDGInterfaceBasics.Edge.allCases {
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
          let swiftUI = SwiftUI.Edge(edge)
          let roundTrip = SDGInterfaceBasics.Edge(swiftUI)
          XCTAssertEqual(roundTrip, edge)
        }
      #endif
    }
  }

  func testEdgeSet() {
    let horizontal = SDGInterfaceBasics.Edge.Set.horizontal
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        let swiftUIHorizontal = SwiftUI.Edge.Set(horizontal)
        let roundTrip = SDGInterfaceBasics.Edge.Set(swiftUIHorizontal)
        XCTAssertEqual(roundTrip, horizontal)
        for edge in SDGInterfaceBasics.Edge.allCases {
          let swiftUIEdge = SwiftUI.Edge(edge)
          let entry = SDGInterfaceBasics.Edge.Set(edge)
          let swiftUIEntry = SwiftUI.Edge.Set(swiftUIEdge)
          XCTAssertEqual(horizontal.contains(entry), swiftUIHorizontal.contains(swiftUIEntry))
        }
      }
    #endif
  }

  func testPoint() {
    #if canImport(CoreGraphics)
      XCTAssertEqual(Point(CGPoint(x: 0, y: 0)), Point(0, 0))
      XCTAssertEqual(Point(0, 0).native.x, 0)
    #endif
  }

  func testRectangle() {
    XCTAssertEqual(Rectangle(origin: Point(1, 2), size: Size(width: 3, height: 4)).size.height, 4)
    #if canImport(CoreGraphics)
      XCTAssertEqual(
        Rectangle(origin: Point(1, 2), size: Size(width: 3, height: 4)).native.width,
        3
      )
    #endif
  }

  func testSize() {
    XCTAssertEqual(Size(), Size(width: 0, height: 0))
    #if canImport(CoreGraphics)
      XCTAssertEqual(Size(CGSize(width: 0, height: 0)), Size(width: 0, height: 0))
    #endif
  }
}
