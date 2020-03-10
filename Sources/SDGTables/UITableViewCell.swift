/*
 UITableViewCell.swift

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
  internal class UITableViewCell: UIKit.UITableViewCell {

    // MARK: - Initialization

    internal init(columns: [AnyView]) {
      self.row = HorizontalStack(spacing: 8, content: columns).stabilize()
      super.init(style: .default, reuseIdentifier: UITableViewDataSource<Bool>.reUseIdentifier)
      let wrapped = AnyCocoaView(self)
      wrapped.fill(with: row, margin: .specific(0))
    }

    internal required init?(coder decoder: NSCoder) {  // @exempt(from: tests)
      return nil
    }

    // MARK: - Properties

    internal var row: Stabilized<HorizontalStack>
  }
#endif
