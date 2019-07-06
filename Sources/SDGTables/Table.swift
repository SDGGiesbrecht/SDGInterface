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

import SDGViews

/// Table.
public class Table<RowData> : SpecificView {

    // MARK: - Initialization

    public init(data: Shared<[RowData]>) {
        self.data = data
        defer {
            dataDidSet()
        }

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

        contentController.automaticallyRearrangesObjects = true
        #if canImport(AppKit)
        table.bind(.content, to: contentController, withKeyPath: #keyPath(NSArrayController.arrangedObjects), options: nil)
        table.bind(.selectionIndexes, to: contentController, withKeyPath: NSBindingName.selectionIndexes.rawValue, options: nil)
        table.bind(.sortDescriptors, to: contentController, withKeyPath: NSBindingName.sortDescriptors.rawValue, options: nil)
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
    }

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
        #warning("Not implemented yet.")
    }
}
#endif
