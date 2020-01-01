/*
 InternalTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@testable import SDGViews

import SDGApplicationTestUtilities

final class InternalTests: ApplicationTestCase {

  func testAspectRatioContainer() {
    #if canImport(AppKit) || canImport(UIKit)
      _ =
        AspectRatioContainer.constraining(AnyCocoaView(), toAspectRatio: 1, contentMode: .fill)
        .cocoaView
      _ =
        AspectRatioContainer.constraining(AnyCocoaView(), toAspectRatio: 1, contentMode: .fit)
        .cocoaView
    #endif
  }
}
