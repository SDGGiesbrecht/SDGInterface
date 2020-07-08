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

  import SDGViews

  extension Table {

    #if canImport(AppKit)
      internal typealias Superclass = NSScrollView
    #else
      internal typealias Superclass = UITableView
    #endif
    internal final class CocoaImplementation: Superclass, SharedValueObserver {

      // MARK: - Initialization

      internal init(data: Shared<[RowData]>, columns: [(_ row: RowData) -> AnyView]) {
        #warning("Not implemented yet.")
        self.data = data
        self.columns = columns
        super.init(frame: .zero)
      }

      internal required init?(coder decoder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let data: Shared<[RowData]>
      private let columns: [(_ row: RowData) -> AnyView]

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        #warning("Not implemented yet.")
      }
    }
  }
#endif
