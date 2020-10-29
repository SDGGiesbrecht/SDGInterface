/*
 Table.CocoaImplementation.Cell.swift

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

  extension Table.CocoaImplementation {

    internal class Cell: UIKit.UITableViewCell {

      // MARK: - Initialization

      internal init(columns: [AnyView]) {
        self.row = HorizontalStack(spacing: 8, content: columns).cocoa()
        super.init(style: .default, reuseIdentifier: reUseIdentifier)
        let wrapped = CocoaView(self)
        wrapped.fill(with: row, margin: 0)
      }

      internal required init?(coder decoder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      internal var row: CocoaView
    }
  }
#endif
