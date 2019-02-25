/*
 Table.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGLocalization

import SDGInterfaceLocalizations

#warning("Rethink finality and subclassing.")
#warning("Rethink binding?")

/// A table.
open class Table: NSScrollView, NSTableViewDelegate {

    // MARK: - Initialization

    private static func initializeTableView() -> NSTableView {
        return NSTableView(frame: NSRect.zero)
    }

    /// Creates a table to display content.
    public init(content: [NSObject]) {
        table = Table.initializeTableView()
        controller = NSArrayController(content: content)
        super.init(frame: NSRect.zero)
        finishInitialization()
    }

    /// Creates a table managed by an array controller.
    public init(contentController: NSArrayController) {
        table = Table.initializeTableView()
        controller = contentController
        super.init(frame: NSRect.zero)
        finishInitialization()
    }

    private func finishInitialization() {
        #warning("Intercept delegation.")
        table.delegate = self

        borderType = .bezelBorder
        hasHorizontalScroller = true
        hasVerticalScroller = true

        table.usesAlternatingRowBackgroundColors = true

        table.columnAutoresizingStyle = .sequentialColumnAutoresizingStyle

        documentView = table

        controller.automaticallyRearrangesObjects = true
        table.bind(.content, to: controller, withKeyPath: #keyPath(NSArrayController.arrangedObjects), options: nil)
        table.bind(.selectionIndexes, to: controller, withKeyPath: NSBindingName.selectionIndexes.rawValue, options: nil)
        table.bind(.sortDescriptors, to: controller, withKeyPath: NSBindingName.sortDescriptors.rawValue, options: nil)
    }

    public required init?(coder: NSCoder) {
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Table"
            }
        }))
        return nil
    }

    // MARK: - Properties

    private let table: NSTableView
    private let controller: NSArrayController
    private var viewGenerators: [NSUserInterfaceItemIdentifier: () -> NSTableCellView] = [:]

    // MARK: - Actions

    /// The click action.
    public var action: Selector? {
        get {
            return table.action
        }
        set {
            table.action = newValue
        }
    }
    /// The double click action.
    public var doubleAction: Selector? {
        get {
            return table.doubleAction
        }
        set {
            table.doubleAction = doubleAction
        }
    }
    /// The target for the click actions.
    public var target: AnyObject? {
        get {
            return table.target
        }
        set {
            table.target = newValue
        }
    }

    // MARK: - Behaviour

    /// Whether or not the table displays column headers.
    public var hasHeader: Bool {
        get {
            return self.table.headerView != nil
        }
        set {
            if newValue {
                self.table.headerView = createHeader()
            } else {
                self.table.headerView = nil
            }
        }
    }

    /// Whether or not the table allows rows to be selected.
    public var allowsSelection: Bool {
        get {
            return table.selectionHighlightStyle ≠ .none
        }
        set {
            if newValue {
                table.selectionHighlightStyle = .regular
            } else {
                table.selectionHighlightStyle = .none
            }
        }
    }

    /// The sort order for the table.
    public var sortOrder: [NSSortDescriptor] {
        get {
            return controller.sortDescriptors
        }
        set {
            controller.sortDescriptors = newValue
        }
    }

    private var identifiers = sequence(first: 0, next: { $0 + 1 })
    /// Creates, adds and returns a new column.
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

    // MARK: - NSTableViewDelegate

    public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let identifier = tableColumn?.identifier {
            if let view = table.makeView(withIdentifier: identifier, owner: self) {
                return view
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
                            return StrictString("Cannot find view generation instructions for “\(identifier)”.")
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

    public func tableView(_ tableView: NSTableView, sizeToFitWidthOfColumn column: Int) -> CGFloat {
        var width = table.tableColumns[column].headerCell.cellSize.width
        for row in 0 ..< table.numberOfRows {
            if let view = table.view(atColumn: column, row: row, makeIfNecessary: true) {
                width.increase(to: view.fittingSize.width)
            }
        }
        return width
    }

    // MARK: - Other Behavioural Fixes

    public final override func setFrameSize(_ newSize: NSSize) {
        super.setFrameSize(newSize)
        for index in table.tableColumns.indices {
            let column = table.tableColumns[index]
            column.width = tableView(table, sizeToFitWidthOfColumn: index)
        }
        table.sizeLastColumnToFit()
    }

    // MARK: - Subclassing

    /// Override in a subclass to use a different class of column.
    open func createColumn(withIdentifier identifier: NSUserInterfaceItemIdentifier) -> NSTableColumn {
        return NSTableColumn(identifier: identifier)
    }

    /// Override in a subclass to use a different class of header.
    open func createHeader() -> NSTableHeaderView {
        return NSTableHeaderView(frame: NSZeroRect)
    }
}
