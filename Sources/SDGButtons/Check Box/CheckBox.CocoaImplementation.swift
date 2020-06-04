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
        isChecked: Shared<Bool>
      ) {
        self.label = label
        defer {
          LocalizationSetting.current.register(observer: self, identifier: localizationIdentifier)
        }

        self.isChecked = isChecked
        defer {
          self.isChecked.register(observer: self, identifier: isCheckedIdentifier)
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
      private let isChecked: Shared<Bool>

      // MARK: - NSButton

      override var state: NSControl.StateValue {
        didSet {
          let booleanState = (state == .on)
          if isChecked.value ≠ booleanState {
            isChecked.value = booleanState
          }
        }
      }

      // MARK: - SharedValueObserver

      private var localizationIdentifier: String { "localization" }
      private var isCheckedIdentifier: String { "is checked" }
      internal func valueChanged(for identifier: String) {
        if identifier == localizationIdentifier {
          title = String(label.resolved())
        } else if identifier == isCheckedIdentifier {
          let expected: NSControl.StateValue = isChecked.value ? .on : .off
          if state ≠ expected {
            state = expected
          }
        }
      }
    }
  }
#endif