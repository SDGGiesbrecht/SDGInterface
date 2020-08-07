/*
 Menu.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

      init(
        label: UserFacing<StrictString, L>,
        entries: [MenuComponent]
      ) {
        self.label = label
        defer {
          LocalizationSetting.current.register(observer: self)
        }
        super.init(title: String(label.resolved()))

        items = entries.map { component in
          switch component {
          case .entry(let entry):
            if let index = entry.cocoa.menu?.index(of: entry.cocoa) {
              entry.cocoa.menu?.removeItem(at: index)
            }
            return entry.cocoa
          case .submenu(let menu):
            let entry = NSMenuItem()
            entry.submenu = menu.cocoa()
            entry.title = entry.submenu!.title
            return entry
          case .separator:
            return NSMenuItem.separator()
          }
        }
      }

      // MARK: - Properties

      private let label: UserFacing<StrictString, L>

      // MARK: - NSMenu

      internal required init(coder: NSCoder) {  // @exempt(from: tests)
        fatalError(
          UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
              return "Coding is not supported."
            }
          })
        )
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
