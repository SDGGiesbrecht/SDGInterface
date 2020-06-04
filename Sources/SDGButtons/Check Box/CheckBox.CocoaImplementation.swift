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
  import SDGLogic
  import SDGText
  import SDGLocalization

  extension CheckBox {

    internal final class CocoaImplementation: NSButton, SharedValueObserver {

      // MARK: - Initialization

      public init(
        label: UserFacing<StrictString, L>,
        value: Shared<Bool>
      ) {
        self.label = label
        defer {
          LocalizationSetting.current.register(observer: self, identifier: localizationIdentifier)
        }

        self.boolean = value
        defer {
          self.boolean.register(observer: self, identifier: booleanIdentifier)
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
      private let boolean: Shared<Bool>

      // MARK: - NSButton

      override var state: NSControl.StateValue {
        didSet {
          let booleanState = (state == .on)
          if boolean.value ≠ booleanState {
            boolean.value = booleanState
          }
        }
      }

      // MARK: - SharedValueObserver

      private var localizationIdentifier: String { "localization" }
      private var booleanIdentifier: String { "Boolean" }
      internal func valueChanged(for identifier: String) {
        if identifier == localizationIdentifier {
          title = String(label.resolved())
        } else if identifier == booleanIdentifier {
          let expected: NSControl.StateValue = boolean.value ? .on : .off
          if state ≠ expected {
            state = expected
          }
        }
      }
    }
  }
#endif
