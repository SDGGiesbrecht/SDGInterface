/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLocalization

import SDGViews
import SDGTextDisplay
import SDGTables
import SDGWindows
import SDGApplication

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests : ApplicationTestCase {

    func testTable() {
        #if canImport(AppKit) || canImport(UIKit)
        let table = Table<Int>(data: Shared([0]), columns: [{ integer in
            let view = AnyNativeView()
            view.fill(with: Label<InterfaceLocalization>(text: .binding(Shared("\(integer.inDigits())"))))
            return view
            }])
        table.sort = { $0 < $1 }
        XCTAssertNotNil(table.sort)
        let window = Window<InterfaceLocalization>.auxiliaryWindow(name: .binding(Shared("")), view: table)
        window.display()
        #endif
    }
}
