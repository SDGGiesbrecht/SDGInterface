/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

final class APITests: ApplicationTestCase {

  func testTable() {
    #if canImport(AppKit) || canImport(UIKit)
      if #available(iOS 9, *) {  // @exempt(from: unicode)
        let table = Table<Int>(
          data: Shared([0]),
          columns: [
            { integer in
              let view = CocoaView()
              view.fill(
                with: Label<InterfaceLocalization>(text: .binding(Shared("\(integer.inDigits())")))
                  .cocoa()
              )
              return AnyView(view)
            }
          ]
        )
        table.sort = { $0 < $1 }
        XCTAssertNotNil(table.sort)
        table.data = Shared([2, 1])
        let columns = table.columns
        table.columns = []
        table.columns = columns
        let window = Window<InterfaceLocalization>.primaryWindow(
          name: .binding(Shared("")),
          view: table.cocoa()
        )
        window.display()
        #if canImport(UIKit)
          table.data = Shared([2, 1])
          let uiTableView = table.cocoa().native as! UITableView
          uiTableView.dataSource?.tableView(
            uiTableView,
            cellForRowAt: IndexPath(row: 0, section: 0)
          )
          uiTableView.dataSource?.tableView(
            uiTableView,
            cellForRowAt: IndexPath(row: 0, section: 0)
          )
        #endif
      }
    #endif
  }
}
