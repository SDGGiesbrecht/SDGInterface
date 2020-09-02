/*
 InternalTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

@testable import SDGTextDisplay

import SDGApplicationTestUtilities

final class InternalTests: ApplicationTestCase {

  func testStrictString() {
    var string = StrictString()
    string.compatibility = "..."
  }
}
