/*
 BindingObserver.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  import SDGControlFlow

  @available(iOS 9, *)  // @exempt(from: unicode)
  internal final class BindingObserver<RowData>: SharedValueObserver {

    // MARK: - Properties

    internal weak var table: Table<RowData>?

    // MARK: - SharedValueObserver

    internal func valueChanged(for identifier: String) {
      table?.refreshBindings()
    }
  }
#endif
