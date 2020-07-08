/*
 Table.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  @available(iOS 9, *)
  extension Table {

    #if canImport(AppKit)
      internal typealias Superclass = NSScrollView
    #else
      internal typealias Superclass = UITableView
    #endif
    internal final class CocoaImplementation: Superclass, SharedValueObserver {

      // MARK: - Initialization

      internal init(
        data: Shared<[RowData]>,
        columns: [(_ row: RowData) -> AnyView],
        sort: ((_ preceding: RowData, _ following: RowData) -> Bool)?
      ) {
        self.data = data
        defer {
          data.register(observer: self)
        }

        self.columns = columns
        defer {
          #if canImport(AppKit)
            var columnIdentifierGenerator = sequence(first: 0, next: { $0 + 1 })
            while cocoaTable.tableColumns.count < columns.count {
              let index = cocoaTable.tableColumns.count
              let newColumn = NSTableColumn(
                identifier: NSUserInterfaceItemIdentifier("\(columnIdentifierGenerator.next()!)")
              )
              newColumn.title = ""
              newColumn.resizingMask = [.autoresizingMask, .userResizingMask]
              cocoaTable.addTableColumn(newColumn)

              let exampleIndex = 0
              if data.value.indices.contains(exampleIndex) {
                let exampleView = columns[index](data.value[exampleIndex])
                cocoaTable.rowHeight.increase(to: exampleView.cocoa().native.fittingSize.height)
              }
            }
          #endif
        }

        self.sort = sort

        #if canImport(AppKit)
          super.init(frame: .zero)
          documentView = CocoaTableView()
          defer {
            delegate.table = self
            cocoaTable.delegate = delegate
            cocoaTable.dataSource = delegate
          }
        #elseif canImport(UIKit)
          super.init(frame: .zero, style: .plain)
          defer {
            dataSourceStorage.table = self
            cocoaTable.dataSource = dataSourceStorage
          }
        #endif

        #if canImport(AppKit)
          cocoaTable.headerView = nil
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
          cocoaTable.usesAlternatingRowBackgroundColors = true
        #endif

        #if canImport(AppKit)
          cocoaTable.columnAutoresizingStyle = .sequentialColumnAutoresizingStyle
        #endif
      }

      internal required init?(coder decoder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let data: Shared<[RowData]>
      private let columns: [(_ row: RowData) -> AnyView]
      private let sort: ((_ preceding: RowData, _ following: RowData) -> Bool)?

      #if canImport(AppKit)
        private var delegate = NSTableViewDelegate<RowData>()
      #else
        private var dataSourceStorage = UITableViewDataSource<RowData>()
      #endif

      #if canImport(AppKit)
        internal var cocoaTable: NSTableView {
          return documentView as! NSTableView
        }
      #elseif canImport(UIKit)
        internal var cocoaTable: UITableView {
          return self
        }
      #endif

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
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
        cocoaTable.reloadData()
      }
    }
  }
#endif
