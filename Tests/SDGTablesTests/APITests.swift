/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGInterface
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
      let data = Shared([0])
      let table = Table<Int>(
        data: data,
        columns: [
          { integer in
            let view = CocoaView()
            view.fill(
              with: Label<InterfaceLocalization>(UserFacing({ _ in "\(integer.inDigits())" }))
                .cocoa()
            )
            return AnyView(view)
          }
        ],
        sort: { $0 < $1 }
      )
      let cocoa = table.cocoa()
      data.value = [2, 1]
      let window = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
        content: cocoa
      )
      window.display()
      #if canImport(UIKit)
        data.value = [2, 1]
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
    #endif
  }
}
