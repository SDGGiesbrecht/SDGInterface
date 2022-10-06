/*
 View.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGLogic

import SDGInterface

import SDGTesting

@available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
private func testSDGInterfaceViewConformance<T>(
  of view: T,
  testBody: Bool = true,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: SDGInterface.View {

  testLegacyViewConformance(of: view, file: file, line: line)

  #if canImport(SwiftUI)
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
) where T: SDGInterface.View {
  testSDGInterfaceViewConformance(of: view, testBody: testBody, file: file, line: line)
}
#if canImport(SwiftUI)
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  public func testViewConformance<T>(
    of view: T,
    testBody: Bool = true,
    file: StaticString = #filePath,
    line: UInt = #line
  ) where T: SDGInterface.View, T: SwiftUI.View {
    testSDGInterfaceViewConformance(of: view, testBody: testBody, file: file, line: line)
    testSwiftUIViewConformance(of: view, testBody: testBody, file: file, line: line)
  }
#endif

#if canImport(SwiftUI)
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
