/*
 PreviewTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  @testable import SDGInterface

  import SDGInterfaceTestUtilities
  import SDGApplicationTestUtilities

  final class PreviewTests: ApplicationTestCase {

    func testProportionedPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = ProportionedPreviews.previews
      }
    }

    func testLayeredPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = LayeredPreviews.previews
      }
    }

    func testFramedPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = FramedPreviews.previews
      }
    }

    func testHorizontalStackPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = HorizontalStackPreviews.previews
      }
    }

    func testLetterboxPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = LetterboxPreviews.previews
      }
    }

    func testPaddedPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = PaddedPreviews.previews
      }
    }
  }
#endif
