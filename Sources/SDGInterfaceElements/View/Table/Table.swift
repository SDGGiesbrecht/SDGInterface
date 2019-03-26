/*
 Table.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) // #workaround(Temporary.)
import SDGLogic
import SDGMathematics
import SDGLocalization

import SDGInterfaceLocalizations

#if canImport(AppKit)
public typealias TableSuperclass = NSScrollView
#else
public typealias TableSuperclass = UITableView
#endif

/// A table.
open class Table: TableSuperclass {

    // MARK: - Initialization

    /// Creates a table to display content.
    public init(content: [NSObject]) {
        #if canImport(AppKit)
        controller = NSArrayController(content: content)
        #else
        #warning("iOS?")
        #endif
        #if canImport(AppKit)
        super.init(frame: CGRect.zero)
        #else
        super.init(frame: CGRect.zero, style: .plain)
        #endif
        finishInitialization()
    }

    #if canImport(AppKit)
    /// Creates a table managed by an array controller.
    public init(contentController: NSArrayController) {
        controller = contentController
        super.init(frame: NSRect.zero)
        finishInitialization()
    }
    #else
    #warning("iOS?")
    #endif

    private func finishInitialization() {
        #if canImport(AppKit)
        interceptor.delegate = table.delegate
        interceptor.listener = self
        table.delegate = interceptor

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
        #else
        #warning("iOS?")
        #endif
    }

    @available(*, unavailable) public required init?(coder: NSCoder) {
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Table"
            }
        }))
        return nil
    }

    // MARK: - Properties

    #if canImport(AppKit)
    public let table: NSTableView = NSTableView(frame: NSRect.zero)
    public let controller: NSArrayController
    private var viewGenerators: [NSUserInterfaceItemIdentifier: () -> NSTableCellView] = [:]
    #else
    #warning("iOS?")
    #endif

    #if canImport(AppKit)
    // MARK: - Delegation

    private let interceptor = DelegationInterceptor(selectors: [
        #selector(NSTableViewDelegate.tableView(_:viewFor:row:)),
        #selector(NSTableViewDelegate.tableView(_:sizeToFitWidthOfColumn:))
        ])
    public var delegate: NSTableViewDelegate? {
        get {
            return interceptor.delegate as? NSTableViewDelegate
        }
        set {
            interceptor.delegate = newValue
            table.delegate = interceptor
        }
    }
    #else
    #warning("iOS?")
    #endif

    #if canImport(AppKit)
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
    #endif

    // MARK: - Behaviour

    #if canImport(AppKit)
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
    #endif

    #if canImport(AppKit)
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
    #endif

    #if canImport(AppKit)
    /// The sort order for the table.
    public var sortOrder: [NSSortDescriptor] {
        get {
            return controller.sortDescriptors
        }
        set {
            controller.sortDescriptors = newValue
        }
    }
    #else
    #warning("iOS?")
    #endif

    #if canImport(AppKit)
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
    #endif

    // MARK: - Other Behavioural Fixes

    #if canImport(AppKit)
    public final override func setFrameSize(_ newSize: NSSize) {
        super.setFrameSize(newSize)
        for index in table.tableColumns.indices {
            let column = table.tableColumns[index]
            column.width = tableView(table, sizeToFitWidthOfColumn: index)
        }
        table.sizeLastColumnToFit()
    }
    #endif

    // MARK: - Subclassing

    #if canImport(AppKit)
    /// Override in a subclass to use a different class of column.
    open func createColumn(withIdentifier identifier: NSUserInterfaceItemIdentifier) -> NSTableColumn {
        return NSTableColumn(identifier: identifier)
    }
    #endif

    #if canImport(AppKit)
    /// Override in a subclass to use a different class of header.
    open func createHeader() -> NSTableHeaderView {
        return NSTableHeaderView(frame: NSZeroRect)
    }
    #endif
}

#if canImport(AppKit)
extension Table : NSTableViewDelegate {

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
}
#endif
#endif
