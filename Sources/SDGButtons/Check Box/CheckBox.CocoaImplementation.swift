/*
 CheckBox.CocoaImplementation.swift

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

  extension CheckBox {

    internal final class CocoaImplementation: NSButton, SharedValueObserver {

      // MARK: - Initialization

      public init(label: UserFacing<StrictString, L>) {
        self.label = label
        defer {
          LocalizationSetting.current.register(observer: self)
        }

        super.init(frame: CGRect.zero)

        bezelStyle = .rounded
        setButtonType(.switch)

        lineBreakMode = .byTruncatingTail

        font = NSFont.from(Font.forLabels)
      }

      internal required init?(coder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let label: UserFacing<StrictString, L>

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        title = String(label.resolved())
      }
    }
  }
#endif
