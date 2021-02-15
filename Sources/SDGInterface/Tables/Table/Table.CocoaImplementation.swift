/*
 Table.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  extension Table {

    #if canImport(AppKit)
      internal typealias Superclass = NSScrollView
      internal typealias TableViewDataSource = NSTableViewDataSource
      internal typealias TableViewDelegate = NSTableViewDelegate
    #else
      internal typealias Superclass = UITableView
      internal typealias TableViewDataSource = UITableViewDataSource
      internal typealias TableViewDelegate = UITableViewDelegate
    #endif
    internal final class CocoaImplementation: Superclass, SharedValueObserver, TableViewDataSource,
      TableViewDelegate
    {

      // MARK: - Initialization

      internal init(
        data: Shared<[RowData]>,
        columns: [(_ row: RowData) -> AnyView],
        sort: ((_ preceding: RowData, _ following: RowData) -> Bool)?
      ) {
        #if DEBUG
          for entry in data.value {
            for column in columns {
              _ = column(entry)  // Eager execution to simplify testing.
            }
          }
        #endif

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
          documentView = CocoaImplementation.TableView()
          defer {
            cocoaTable.delegate = self
            cocoaTable.dataSource = self
          }
        #elseif canImport(UIKit)
          super.init(frame: .zero, style: .plain)
          defer {
            cocoaTable.dataSource = self
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
        internal var cocoaTable: NSTableView {
          return documentView as! NSTableView
        }
      #elseif canImport(UIKit)
        internal var cocoaTable: UITableView {
          return self
        }
      #endif

      #if canImport(AppKit)
        // MARK: - NSTableViewDataSource

        internal func numberOfRows(in tableView: NSTableView) -> Int {
          return data.value.count
        }

        // MARK: - NSTableViewDelegate

        internal func tableView(
          _ tableView: NSTableView,
          viewFor tableColumn: NSTableColumn?,
          row: Int
        ) -> NSView? {
          if let identifier = tableColumn?.identifier {
            if let view = cocoaTable.makeView(withIdentifier: identifier, owner: self) {
              return view  // @exempt(from: tests)
            } else if let index = cocoaTable.tableColumns.indices.first(
              where: { cocoaTable.tableColumns[$0].identifier == identifier })
            {
              let data = self.data.value[row]
              let generator = self.columns[index]

              let view = generator(data)

              /// Prevent constraints from conflicting with NSTableView’s self‐imposed constraints.
              for constraint in view.cocoa().native.constraints {
                var priority = constraint.priority.rawValue
                priority −= 1
                constraint.priority = NSLayoutConstraint.Priority(rawValue: priority)
              }

              let cell = CellView(view: view)
              return cell
            }
          }
          return nil  // @exempt(from: tests) Shouldn’t happen.
        }

        internal func tableView(
          _ tableView: NSTableView,
          sizeToFitWidthOfColumn column: Int
        ) -> CGFloat {
          var width = cocoaTable.tableColumns[column].headerCell.cellSize.width
          let numberOfRows = cocoaTable.numberOfRows

          for row in 0..<numberOfRows {
            if let view = cocoaTable.view(
              atColumn: column,
              row: row,
              makeIfNecessary: true
            ) {
              width.increase(to: view.fittingSize.width)
            }
          }
          return width
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

      #if canImport(UIKit)
        // MARK: - UITableViewDataSource

        internal func tableView(
          _ tableView: UITableView,
          numberOfRowsInSection section: Int
        ) -> Int {
          return data.value.count
        }

        internal static var reUseIdentifier: String {
          return "row"
        }

        internal func tableView(
          _ tableView: UITableView,
          cellForRowAt indexPath: IndexPath
        ) -> UIKit.UITableViewCell {
          let cell: Cell
          if let reUsable = cocoaTable.dequeueReusableCell(
            withIdentifier: Self.reUseIdentifier
          ) as? Cell {
            cell = reUsable  // @exempt(from: tests) Hard to predicably reproduce.
          } else {
            cell = Cell(columns: [])
          }

          cell.row = HorizontalStack(
            content: columns.map({ $0(data.value[indexPath.row]) })
          ).cocoa()
          return cell
        }
      #endif
    }
  }
#endif
