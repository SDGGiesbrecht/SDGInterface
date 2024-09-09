/*
 PreviewTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI

  @testable import SDGProgressIndicators

  import SDGInterfaceTestUtilities
  import SDGInterfaceInternalTestUtilities

  final class PreviewTests: ApplicationTestCase {

    func testLabelledProgressBarPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 7, *) {
        _ = LabelledProgressBarPreviews.previews
      }
    }

    func testProgressBarPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 7, *) {
        _ = ProgressBarPreviews.previews
      }
    }
  }
#endif
