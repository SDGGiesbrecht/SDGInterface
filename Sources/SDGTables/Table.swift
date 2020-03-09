/*
 Table.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  #if canImport(AppKit)
    private var columnIdentifiers = sequence(first: 0, next: { $0 &+ 1 })
  #endif

  /// Table.
  @available(iOS 9, *)  // @exempt(from: unicode)
  public final class Table<RowData>: CocoaViewImplementation, SpecificView {

    // MARK: - Initialization

    /// Creates a table.
    ///
    /// - Parameters:
    ///     - data: The data the table represents.
    ///     - columns: An array of closures—each representing a column—which produce a corresponding cell view for a particular data entry.
    ///     - row: The data element represented by the row.
    public init(data: Shared<[RowData]>, columns: [(_ row: RowData) -> AnyView]) {
      self.data = data
      defer {
        dataDidSet()
      }

      self.columns = columns
      defer {
        columnsDidSet()
      }

      #if canImport(AppKit)
        specificCocoaView = NSScrollView()
        specificCocoaView.documentView = CocoaTableView()
        defer {
          delegate.table = self
          nativeTable.delegate = delegate
          nativeTable.dataSource = delegate
        }
      #elseif canImport(UIKit)
        specificCocoaView = UITableView(frame: .zero, style: .plain)
        defer {
          dataSource.table = self
          nativeTable.dataSource = dataSource
        }
      #endif

      defer {
        bindingObserver.table = self
      }

      #if canImport(AppKit)
        nativeTable.headerView = nil
        specificCocoaView.borderType = .bezelBorder
      #endif
      #if canImport(AppKit)
        specificCocoaView.hasHorizontalScroller = true
        specificCocoaView.hasVerticalScroller = true
      #else
        specificCocoaView.showsHorizontalScrollIndicator = true
        specificCocoaView.showsVerticalScrollIndicator = true
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
      refreshBindings()
    }

    /// An array of closures—each representing a column—which produce a corresponding cell view for a particular data entry.
    ///
    /// - Parameters:
    ///     - row: The data entry represented by the row.
    public var columns: [(_ row: RowData) -> AnyView] {
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
            identifier: NSUserInterfaceItemIdentifier("\(columnIdentifiers.next()!)")
          )
          newColumn.title = ""
          newColumn.resizingMask = [.autoresizingMask, .userResizingMask]
          nativeTable.addTableColumn(newColumn)

          let exampleIndex = 0
          if data.value.indices.contains(exampleIndex) {
            let exampleView = columns[index](data.value[exampleIndex])
            nativeTable.rowHeight.increase(to: exampleView.cocoaView.fittingSize.height)
          }
        }
      #endif
      nativeTable.reloadData()
    }

    /// A sort order to impose on the data.
    ///
    /// For example, `{ $0 < $1 }` will sort according to `Comparable`.
    ///
    /// - Parameters:
    ///     - preceding: The element before the inequality sign.
    ///     - following: The element after the inequality sign.
    public var sort: ((_ preceding: RowData, _ following: RowData) -> Bool)? {
      didSet {
        refreshBindings()
      }
    }

    #if canImport(AppKit)
      public var specificCocoaView: NSScrollView
      private var delegate = NSTableViewDelegate<RowData>()
    #elseif canImport(UIKit)
      public var specificCocoaView: UITableView
      private var dataSource = UITableViewDataSource<RowData>()
    #endif

    #if canImport(AppKit)
      internal var nativeTable: NSTableView {
        return specificCocoaView.documentView as? NSTableView
          ?? NSTableView()  // @exempt(from: tests) Never nil.
      }
    #elseif canImport(UIKit)
      internal var nativeTable: UITableView {
        return specificCocoaView
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
