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
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

import SDGControlFlow
import SDGLogic
import SDGMathematics

import SDGViews

private var columnIdentifiers = sequence(first: 0, next: { $0 &+ 1 })

/// Table.
public final class Table<RowData> : SpecificView {

    // MARK: - Initialization

    public init(data: Shared<[RowData]>, columns: [(RowData) -> View]) {
        self.data = data
        defer {
            dataDidSet()
        }

        self.columns = columns
        defer {
            columnsDidSet()
        }

        #if canImport(AppKit)
        specificNative = NSScrollView()
        specificNative.documentView = CocoaTableView()
        defer {
            delegate.table = self
            nativeTable.delegate = delegate
            nativeTable.dataSource = delegate
        }
        #elseif canImport(UIKit)
        specificNative = UITableView(frame: .zero, style: .plain)
        defer {
            dataSource.table = self
            nativeTable.dataSource = dataSource
        }
        #endif

        #if canImport(AppKit)
        nativeTable.headerView = nil
        specificNative.borderType = .bezelBorder
        #endif
        #if canImport(AppKit)
        specificNative.hasHorizontalScroller = true
        specificNative.hasVerticalScroller = true
        #else
        specificNative.showsHorizontalScrollIndicator = true
        specificNative.showsVerticalScrollIndicator = true
        #endif

        #if canImport(AppKit)
        nativeTable.usesAlternatingRowBackgroundColors = true
        #endif

        #if canImport(AppKit)
        nativeTable.columnAutoresizingStyle = .sequentialColumnAutoresizingStyle
        #endif
    }

    // MARK: - Properties

    private let bindingObserver = BindingObserver<RowData>()

    /// The data.
    public var data: Shared<[RowData]> {
        willSet {
            data.cancel(observer: bindingObserver)
        }
        didSet {
            dataDidSet()
        }
    }
    private func dataDidSet() {
        data.register(observer: bindingObserver)
        nativeTable.reloadData()
    }

    public var columns: [(RowData) -> View] {
        didSet {
            columnsDidSet()
        }
    }
    private func columnsDidSet() {
        #if canImport(AppKit)
        while nativeTable.tableColumns.count > columns.count {
            nativeTable.removeTableColumn(nativeTable.tableColumns.last!)
        }
        while nativeTable.tableColumns.count < columns.count {
            let index = nativeTable.tableColumns.count
            let newColumn = NSTableColumn(
                identifier: NSUserInterfaceItemIdentifier("\(columnIdentifiers.next()!)"))
            newColumn.title = ""
            newColumn.resizingMask = [.autoresizingMask, .userResizingMask]
            nativeTable.addTableColumn(newColumn)

            let exampleView = columns[index](data.value[index])
            nativeTable.rowHeight.increase(to: exampleView.native.fittingSize.height)
        }
        #endif
        nativeTable.reloadData()
    }

    /// A sort order to impose on the data.
    public var sort: ((RowData, RowData) -> Bool)?

    #if canImport(AppKit)
    public var specificNative: NSScrollView
    private var delegate = NSTableViewDelegate<RowData>()
    #elseif canImport(UIKit)
    public var specificNative: UITableView
    private var dataSource = UITableViewDataSource<RowData>()
    #endif

    #if canImport(AppKit)
    internal var nativeTable: NSTableView {
        get {
            return specificNative.documentView as? NSTableView ?? NSTableView()
        }
    }
    #elseif canImport(UIKit)
    internal var nativeTable: UITableView {
        get {
            return specificNative
        }
    }
    #endif

    // MARK: - Refreshing

    internal func refreshBindings() {
        if let areSorted = self.sort {
            let value = data.value
            var alreadySorted = true
            for (preceding, following) in zip(value.dropLast(), value.dropFirst()) {
                if ¬areSorted(preceding, following) {
                    alreadySorted = false
                    break
                }
            }
            if ¬alreadySorted {
                data.value.sort(by: areSorted)
            }
        }
        nativeTable.reloadData()
    }
}
#endif
