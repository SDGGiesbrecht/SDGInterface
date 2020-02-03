/*
 UITableViewDataSource.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit) && !os(watchOS)
  import UIKit

  import SDGViews

  @available(iOS 9, *)  // @exempt(from: unicode)
  internal class UITableViewDataSource<RowData>: NSObject, UIKit.UITableViewDataSource {

    // MARK: - Properties

    internal weak var table: Table<RowData>?

    // MARK: - UITableViewDataSource

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return table?.data.value.count ?? 0  // @exempt(from: tests) Never nil.
    }

    internal static var reUseIdentifier: String {
      return "row"
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UIKit
      .UITableViewCell
    {
      let cell: UITableViewCell
      if let reUsable = table?.nativeTable.dequeueReusableCell(
        withIdentifier: UITableViewDataSource.reUseIdentifier
      ) as? UITableViewCell {
        cell = reUsable  // @exempt(from: tests) Hard to predicably reproduce.
      } else {
        cell = UITableViewCell(columns: [])
      }

      if let table = self.table {
        cell.row = HorizontalStack(content: table.columns.map({ $0(table.data.value[indexPath.row]) }))
      }
      return cell
    }
  }
#endif
