/*
 Table.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

import SDGLogic
import SDGMathematics
import SDGCollections
import SDGLocalization

import SDGInterfaceLocalizations

#if canImport(AppKit)
public typealias _TableSuperclass = NSScrollView
#else
public typealias _TableSuperclass = UITableView
#endif

/// A table.
open class Table : _TableSuperclass {

    // MARK: - Initialization

    /// Creates a table to display content.
    ///
    /// - Parameters:
    ///     - content: An array of data for the table. Each element of the array reperestents the data for one row of the table.
    public init(content: [NSObject]) {
        contentController = NSArrayController(content: content)
        #if canImport(AppKit)
        super.init(frame: CGRect.zero)
        #else
        super.init(frame: CGRect.zero, style: .plain)
        #endif
        finishInitialization()
    }

    /// Creates a table managed by an array controller.
    ///
    /// - Parameters:
    ///     - contentController: An array controller representing the table content.
    public init(contentController: NSArrayController) {
        self.contentController = contentController
        #if canImport(AppKit)
        super.init(frame: CGRect.zero)
        #else
        super.init(frame: CGRect.zero, style: .plain)
        #endif
        finishInitialization()
    }

    private func finishInitialization() {
        #if canImport(AppKit)
        delegateInterceptor.delegate = table.delegate
        #else
        delegateInterceptor.delegate = self.delegate
        #endif
        delegateInterceptor.listener = self
        #if canImport(AppKit)
        table.delegate = delegateInterceptor
        #else
        self.delegate = delegateInterceptor
        #endif

        #if canImport(AppKit)
        borderType = .bezelBorder
        #endif
        #if canImport(AppKit)
        hasHorizontalScroller = true
        hasVerticalScroller = true
        #else
        showsHorizontalScrollIndicator = true
        showsVerticalScrollIndicator = true
        #endif

        #if canImport(AppKit)
        table.usesAlternatingRowBackgroundColors = true
        #endif

        #if canImport(AppKit)
        table.columnAutoresizingStyle = .sequentialColumnAutoresizingStyle
        #endif

        #if canImport(AppKit)
        documentView = table
        #endif

        contentController.automaticallyRearrangesObjects = true
        #if canImport(AppKit)
        table.bind(.content, to: controller, withKeyPath: #keyPath(NSArrayController.arrangedObjects), options: nil)
        table.bind(.selectionIndexes, to: controller, withKeyPath: NSBindingName.selectionIndexes.rawValue, options: nil)
        table.bind(.sortDescriptors, to: controller, withKeyPath: NSBindingName.sortDescriptors.rawValue, options: nil)
        #endif
    }

    @available(*, unavailable) public required init?(coder: NSCoder) { // @exempt(from: unicode)
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
    /// The actual `NSTableView` instance.
    public let table: NSTableView = NSTableView(frame: NSRect.zero)
    #endif

    /// The array controller which manages the content.
    public let contentController: NSArrayController

    #if canImport(AppKit)
    private var viewGenerators: [NSUserInterfaceItemIdentifier: () -> NSTableCellView] = [:]
    #else
    #warning("Not implemented yet.")
    #endif

    // MARK: - Delegation

    private static func interceptedDelegateSelectors() -> Set<Selector> {
        var selectors: Set<Selector> = []
        #if canImport(AppKit)
        selectors ∪= [
            #selector(NSTableViewDelegate.tableView(_:viewFor:row:)),
            #selector(NSTableViewDelegate.tableView(_:sizeToFitWidthOfColumn:))
            ]
        #endif
        return selectors
    }
    private let delegateInterceptor = DelegationInterceptor(selectors: Table.interceptedDelegateSelectors())
    #if canImport(AppKit)
    /// The table view’s delegate.
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
    open override var delegate: UITableViewDelegate? {
        get {
            return delegateInterceptor.delegate as? UITableViewDelegate
        }
        set {
            delegateInterceptor.delegate = newValue
            super.delegate = delegateInterceptor
        }
    }
    #endif

    #if canImport(UIKit)
    private let dataSourceInterceptor = DelegationInterceptor(selectors: [
        #selector(UITableViewDataSource.tableView(_:numberOfRowsInSection:)),
        #selector(UITableViewDataSource.tableView(_:cellForRowAt:))
        ])
    open override var dataSource: UITableViewDataSource? {
        get {
            return dataSourceInterceptor.delegate as? UITableViewDataSource
        }
        set {
            dataSourceInterceptor.delegate = newValue
            super.dataSource = dataSourceInterceptor
        }
    }
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
            return self.table.headerView ≠ nil
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
    #endif

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
#warning("Not implemented yet.")
#endif

#endif
