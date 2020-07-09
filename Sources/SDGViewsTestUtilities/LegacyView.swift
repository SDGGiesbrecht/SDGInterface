/*
 LegacyView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGViews
import SDGWindows

import SDGInterfaceLocalizations

import SDGTesting

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  /// Tests a type’s conformance to LegacyView.
  ///
  /// - Parameters:
  ///     - view: A view.
  ///     - file: Optional. A different source file to associate with any failures.
  ///     - line: Optional. A different line to associate with any failures.
  @available(watchOS 6, *)
  public func testLegacyViewConformance<T>(
    of view: T,
    file: StaticString = #file,
    line: UInt = #line
  ) where T: LegacyView {

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      _ = view.cocoa()
    #endif
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        _ = view.swiftUIAnyView()
      }
    #endif

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      _ = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
        content: view
      )
    #endif
  }
#endif
