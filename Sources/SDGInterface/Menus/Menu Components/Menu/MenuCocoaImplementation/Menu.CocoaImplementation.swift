/*
 Menu.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

    internal class CocoaImplementation: NSMenuItem, SharedValueObserver {

      // MARK: - Initialization

      internal init(
        label: UserFacing<StrictString, L>,
        entries: Components
      ) {
        self.label = label
        defer {
          LocalizationSetting.current.register(observer: self)
        }

        menuObject = CocoaMenu(label: label, entries: entries)
        defer { submenu = menuObject }

        let temporaryPlaceholderTitle = ""
        super.init(title: temporaryPlaceholderTitle, action: nil, keyEquivalent: "")
      }

      // MARK: - Properties

      private let label: UserFacing<StrictString, L>
      private let menuObject: CocoaMenu

      // MARK: - NSMenuItem

      internal required init(coder: NSCoder) {  // @exempt(from: tests)
        codingNotSupported()
      }

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        self.title = String(label.resolved())
      }
    }
  }
#endif
