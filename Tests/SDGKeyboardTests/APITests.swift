/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGKeyboard

import XCTest

import SDGXCTestUtilities

import SDGInterfaceInternalTestUtilities

final class APITests: ApplicationTestCase {

  func testKey() {
    XCTAssert(Key.rightIndexHome.hasConsistentPosition)
    #if canImport(Carbon)
      let name = String(Key.rightIndexHome.currentName)
      XCTAssertEqual(name, name.uppercased())
      XCTAssertFalse(name.isEmpty)
      XCTAssertEqual(Key(code: Key.rightIndexHome.keyCode), Key.rightIndexHome)
      XCTAssertNil(Key(code: CGKeyCode.max))
    #endif
    XCTAssertFalse(Key.かなジス.hasConsistentPosition)
    XCTAssert(Key.rightIndexHome.existsConsistently)
    XCTAssertFalse(Key.かなジス.existsConsistently)
    XCTAssert(Key.rightDoubleOutsideHomeISO_JIS_RightTripleOutsideUpperANSI.existsConsistently)
    #if canImport(Carbon)
      for key in Key.allCases {
        XCTAssertEqual(key.coreGraphicsCode, Int(key.keyCode))
        XCTAssertEqual(Key(coreGraphicsCode: key.coreGraphicsCode), key)
      }
    #endif
    XCTAssertEqual(Key(coreGraphicsCode: Key.thumbs.coreGraphicsCode), Key.thumbs)
    XCTAssertNil(Key(coreGraphicsCode: Int.max))
  }
}
