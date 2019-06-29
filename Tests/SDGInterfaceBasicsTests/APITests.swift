/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterfaceBasics

import SDGXCTestUtilities

import SDGApplicationTestUtilities

import XCTest

final class APITests : ApplicationTestCase {

    func testApplicationName() {
        XCTAssertEqual(ProcessInfo.applicationName(.español(.de)), "del Ejemplar")
        XCTAssertEqual(ProcessInfo.applicationName(.deutsch(.akkusativ)), "Beispiel")
        XCTAssertEqual(ProcessInfo.applicationName(.deutsch(.dativ)), "Beispiel")
        XCTAssertEqual(ProcessInfo.applicationName(.français(.de)), "de l’Exemple")
        XCTAssertEqual(ProcessInfo.applicationName(.ελληνικά(.αιτιατική)), "το Παράδειγμα")
        XCTAssertEqual(ProcessInfo.applicationName(.ελληνικά(.γενική)), "του Παραδείγματος")
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
        XCTAssertEqual(Colour.yellow.green, Colour(native: Colour.yellow.native).green)
        #endif
        #if canImport(UIKit)
        XCTAssertEqual(Colour.cyan.blue, Colour(native: Colour.cyan.native).blue)
        #endif
    }
}
