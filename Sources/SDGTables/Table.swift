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

import SDGViews

/// Table.
public class Table<RowData> : SpecificView {

    // MARK: - Initialization

    public init(data: Shared<[RowData]>, columns: [(RowData) -> View]) {
        self.data = data
        defer {
            dataDidSet()
        }

        self.columns = columns

        #if canImport(AppKit)
        specificNative = NSScrollView()
        specificNative.documentView = NSTableView()
        #elseif canImport(UIKit)
        specificNative = UITableView(frame: .zero, style: .plain)
        #endif

        #if canImport(AppKit)
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

    // MARK: - SpecificView

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
            nativeTable.reloadData()
        }
    }

    /// A sort order to impose on the data.
    public var sort: ((RowData, RowData) -> Bool)?

    #if canImport(AppKit)
    public var specificNative: NSScrollView
    #elseif canImport(UIKit)
    public var specificNative: UITableView
    #endif

    #if canImport(AppKit)
    private var nativeTable: NSTableView {
        get {
            return specificNative.documentView as? NSTableView ?? NSTableView()
        }
    }
    #elseif canImport(UIKit)
    public var nativeTable: UITableView {
        get {
            return specificNative
        }
    }
    #endif

    // MARK: - Refreshing

    private func refreshBindings() {
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
    }
}
#endif
