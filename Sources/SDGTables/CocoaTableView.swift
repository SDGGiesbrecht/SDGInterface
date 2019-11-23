/*
 CocoaTableView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  internal class CocoaTableView: NSTableView {

    internal override func setFrameSize(_ newSize: NSSize) {
      super.setFrameSize(newSize)
      for index in tableColumns.indices {
        let column = tableColumns[index]
        if let width = delegate?.tableView?(self, sizeToFitWidthOfColumn: index) {
          column.width = width
        }
      }
    }
  }
#endif
