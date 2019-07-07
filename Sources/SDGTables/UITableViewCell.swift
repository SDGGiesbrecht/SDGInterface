/*
 UITableViewCell.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit)
import UIKit

import SDGViews

internal class UITableViewCell : UIKit.UITableViewCell {

    // MARK: - Initialization

    internal init(columns: [View]) {
        self.row = RowView(views: columns)
        super.init(style: .default, reuseIdentifier: UITableViewDataSource<Bool>.reUseIdentifier)
        let wrapped = AnyNativeView(self)
        wrapped.fill(with: row, margin: .specific(0))
    }

    internal required init?(coder decoder: NSCoder) {
        return nil
    }

    // MARK: - Properties

    internal let row: RowView
}
#endif
