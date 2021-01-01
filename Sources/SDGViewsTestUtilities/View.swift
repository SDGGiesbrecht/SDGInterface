/*
 View.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI
#endif

import SDGLogic

import SDGViews

import SDGTesting

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  private func testSDGViewsViewConformance<T>(
    of view: T,
    testBody: Bool = true,
    file: StaticString = #filePath,
    line: UInt = #line
  ) where T: SDGViews.View {

    testLegacyViewConformance(of: view, file: file, line: line)

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      let swiftUI = view.swiftUI()
      if testBody {
        _ = swiftUI.body
      }
    #endif
  }

  // @documentation(testViewConformance)
  /// Tests a type’s conformance to View.
  ///
  /// - Parameters:
  ///     - view: A view.
  ///     - testBody: Optional. Whether or not to test the `body` property.
  ///     - file: Optional. A different source file to associate with any failures.
  ///     - line: Optional. A different line to associate with any failures.
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  public func testViewConformance<T>(
    of view: T,
    testBody: Bool = true,
    file: StaticString = #filePath,
    line: UInt = #line
  ) where T: SDGViews.View {
    testSDGViewsViewConformance(of: view, testBody: testBody, file: file, line: line)
  }
  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
    public func testViewConformance<T>(
      of view: T,
      testBody: Bool = true,
      file: StaticString = #filePath,
      line: UInt = #line
    ) where T: SDGViews.View, T: SwiftUI.View {
      testSDGViewsViewConformance(of: view, testBody: testBody, file: file, line: line)
      testSwiftUIViewConformance(of: view, testBody: testBody, file: file, line: line)
    }
  #endif
#endif

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  private func testSwiftUIViewConformance<T>(
    of view: T,
    testBody: Bool = true,
    file: StaticString = #filePath,
    line: UInt = #line
  ) where T: SwiftUI.View {
    if testBody {
      _ = view.body
    }
  }

  // #documentation(testViewConformance)
  /// Tests a type’s conformance to View.
  ///
  /// - Parameters:
  ///     - view: A view.
  ///     - testBody: Optional. Whether or not to test the `body` property.
  ///     - file: Optional. A different source file to associate with any failures.
  ///     - line: Optional. A different line to associate with any failures.
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  public func testViewConformance<T>(
    of view: T,
    testBody: Bool = true,
    file: StaticString = #filePath,
    line: UInt = #line
  ) where T: SwiftUI.View {
    testSwiftUIViewConformance(of: view, testBody: testBody, file: file, line: line)
  }
#endif
