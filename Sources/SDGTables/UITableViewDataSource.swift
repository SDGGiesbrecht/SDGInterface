/*
 UITableViewDataSource.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit)
import UIKit

internal class UITableViewDataSource<RowData> : NSObject, UIKit.UITableViewDataSource {

    // MARK: - Properties

    internal weak var table: Table<RowData>?

    // MARK: - UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentController.arrangedObjects.count
    }

    private static let reUseIdentifier = "SDGReUseIdentifier"

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: Table.reUseIdentifier) ?? UITableViewCell(style: cellStyle, reuseIdentifier: Table.reUseIdentifier)
        cellUpdator(cell, contentController.arrangedObjects[indexPath.row])
        return cell
    }
}
#endif
