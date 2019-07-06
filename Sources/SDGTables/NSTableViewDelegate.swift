/*
 NSTableViewDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit

import SDGMathematics

internal class NSTableViewDelegate<RowData> : NSObject, AppKit.NSTableViewDelegate {

    // MARK: - Properties

    internal weak var table: Table<RowData>?

    // MARK: - NSTableViewDelegate

    internal func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let identifier = tableColumn?.identifier {
            if let view = table?.nativeTable.makeView(withIdentifier: identifier, owner: self) {
                return view // @exempt(from: tests)
            } else if let nativeTableColumns = table?.nativeTable.tableColumns,
                let index = nativeTableColumns.indices.first(
                    where: { nativeTableColumns[$0].identifier == identifier }),
                let data = table?.data.value[index],
                let generator = table?.columns[index] {
                let view = generator(data)

                /// Prevent constraints from conflicting with NSTableView’s self‐imposed constraints.
                for constraint in view.native.constraints {
                    var priority = constraint.priority.rawValue
                    priority −= 1
                    constraint.priority = NSLayoutConstraint.Priority(rawValue: priority)
                }

                #warning("Need to wrap in order not to lose parent instance.")
                return view.native
            }
        }
        return nil
    }

    internal func tableView(_ tableView: NSTableView, sizeToFitWidthOfColumn column: Int) -> CGFloat {
        if var width = table?.nativeTable.tableColumns[column].headerCell.cellSize.width,
            let numberOfRows = table?.nativeTable.numberOfRows {
            for row in 1 ... numberOfRows {
                if let view = table?.nativeTable.view(atColumn: column, row: row, makeIfNecessary: true) {
                    width.increase(to: view.fittingSize.width)
                }
            }
            return width
        } else {
            return 0
        }
    }
}
#endif
