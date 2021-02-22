/*
 Menu.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

  extension Menu {

    internal class CocoaImplementation: NSMenu, SharedValueObserver {

      // MARK: - Initialization

      internal init(
        label: UserFacing<StrictString, L>,
        entries: [MenuComponent]
      ) {
        self.label = label
        defer {
          LocalizationSetting.current.register(observer: self)
        }
        super.init(title: "" /* temporary placeholder */)

        items = entries.map { $0.cocoa() }
      }

      // MARK: - Properties

      private let label: UserFacing<StrictString, L>

      // MARK: - NSMenu

      internal required init(coder: NSCoder) {  // @exempt(from: tests)
        codingNotSupported()
      }

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        title = String(label.resolved())
        if let index = supermenu?.indexOfItem(withSubmenu: self) {
          supermenu?.item(at: index)?.title = String(label.resolved())
        }
      }
    }
  }
#endif
