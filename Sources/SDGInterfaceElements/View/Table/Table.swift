/*
 Table.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)

/// A table.
open class Table : _TableSuperclass {

    #if canImport(AppKit)

    // MARK: - Behaviour

    #if canImport(AppKit)
    private var identifiers = sequence(first: 0, next: { $0 + 1 })
    /// Creates, adds and returns a new column.
    ///
    /// - Parameters:
    ///     - header: The header for the column.
    ///     - viewGenerator: A closure which generates the view to use for each cell.
    @discardableResult public func newColumn(header: StrictString, viewGenerator: @escaping () -> NSTableCellView) -> NSTableColumn {
        let identifier = NSUserInterfaceItemIdentifier("\(identifiers.next()!)")
        viewGenerators[identifier] = viewGenerator
        let column = createColumn(withIdentifier: identifier)
        column.header = header
        column.resizingMask = [.autoresizingMask, .userResizingMask]
        table.addTableColumn(column)

        let exampleView = viewGenerator()
        table.rowHeight.increase(to: exampleView.minimumHeight)

        return column
    }
    #endif

    // MARK: - Other Behavioural Fixes


    // MARK: - Subclassing

    #if canImport(AppKit)
    /// Override in a subclass to use a different class of column.
    ///
    /// - Parameters:
    ///     - identifier: An identifier for the column.
    open func createColumn(withIdentifier identifier: NSUserInterfaceItemIdentifier) -> NSTableColumn {
        return NSTableColumn(identifier: identifier)
    }
    #endif

    #if canImport(AppKit)
    /// Override in a subclass to use a different class of header.
    open func createHeader() -> NSTableHeaderView {
        return NSTableHeaderView(frame: CGRect.zero)
    }
    #endif
}

#if canImport(AppKit)
extension Table : NSTableViewDelegate {

    /// Returns the view for a particular column. (See `NSTableViewDelegate`.)
    ///
    /// - Parameters:
    ///     - tableView: The table view.
    ///     - tableColumn: The column.
    /// 	- row: The row.
    public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let identifier = tableColumn?.identifier {
            if let view = table.makeView(withIdentifier: identifier, owner: self) {
                return view // @exempt(from: tests)
            } else {
                if let generator = viewGenerators[identifier] {
                    let view = generator()

                    /// Prevent constraints from conflicting with NSTableView’s self‐imposed constraints.
                    for constraint in view.constraints {
                        var priority = constraint.priority.rawValue
                        priority −= 1
                        constraint.priority = NSLayoutConstraint.Priority(rawValue: priority)
                    }

                    return view
                } else {
                    preconditionFailure(UserFacing<StrictString, APILocalization>({ localization in
                        switch localization {
                        case .englishCanada:
                            return "Cannot find view generation instructions for “\(arbitraryDescriptionOf: identifier)”."
                        }
                    }))
                }
            }
        } else {
            preconditionFailure(UserFacing<StrictString, APILocalization>({ localization in
                switch localization {
                case .englishCanada:
                    return "Column identifier is missing."
                }
            }))
        }
    }

    /// Returns the size of a particular column. (See `NSTableViewDelegate`.)
    ///
    /// - Parameters:
    ///     - tableView: The table view.
    ///     - column: The column.
    public func tableView(_ tableView: NSTableView, sizeToFitWidthOfColumn column: Int) -> CGFloat {
        var width = table.tableColumns[column].headerCell.cellSize.width
        for row in 0 ..< table.numberOfRows {
            if let view = table.view(atColumn: column, row: row, makeIfNecessary: true) {
                width.increase(to: view.fittingSize.width)
            }
        }
        return width
    }
}
#else
extension Table : UITableViewDataSource {

    // MARK: - UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentController.arrangedObjects.count
    }

    private static let reUseIdentifier = "SDGReUseIdentifier"

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: Table.reUseIdentifier) ?? UITableViewCell(style: cellStyle, reuseIdentifier: Table.reUseIdentifier)
        cellUpdator(cell, contentController.arrangedObjects[indexPath.row])
        return cell
    }
}
#endif

#endif
