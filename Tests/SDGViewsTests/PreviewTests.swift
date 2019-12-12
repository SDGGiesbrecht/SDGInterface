/*
 PreviewTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@testable import SDGViews

import SDGApplicationTestUtilities

final class PreviewTests: ApplicationTestCase {

  func testAspectRatioPreviews() {
    if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
      _ = AspectRatioPreviews()
    }
  }
}
