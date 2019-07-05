/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGImageDisplay
import SDGApplication

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests : ApplicationTestCase {

    func testImageView() {
        #if canImport(AppKit) || canImport(UIKit)
        Application.shared.demonstrateImage()
        #endif
    }
}