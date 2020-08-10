/*
 MenuEntry.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(tvOS) && !os(watchOS)
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  extension MenuEntry {

    #if canImport(AppKit)
      internal typealias Superclass = NSMenuItem
    #else
      internal typealias Superclass = UIMenuItem
    #endif
    internal class CocoaImplementation: Superclass, SharedValueObserver {

      // MARK: - Initialization

      internal init(
        label: UserFacing<StrictString, L>,
        hotKeyModifiers: KeyModifiers,
        hotKey: String?,
        action: @escaping () -> Void,
        isHidden: Shared<Bool>,
        tag: Int?
      ) {
        self.label = label
        defer {
          LocalizationSetting.current.register(observer: self)
        }

        self.actionClosure = action

        self.isHiddenBinding = isHidden

        super.init(
          title: "" /* temporary placeholder */,
          action: #selector(CocoaImplementation.triggerAction),
          keyEquivalent: hotKey ?? ""
        )
        self.keyEquivalentModifierMask = hotKeyModifiers.cocoa
        self.target = self

        if let tag = tag {
          self.tag = tag
        }
      }

      required init(coder: NSCoder) {
        codingNotSupported()
      }

      // MARK: - Properties

      private let label: UserFacing<StrictString, L>
      private let actionClosure: () -> Void
      private let isHiddenBinding: Shared<Bool>

      // MARK: - NSMenuItem

      @objc private func triggerAction() {  // @exempt(from: tests)
        // Exempt from tests because tvOS cannot dispatch actions during tests.
        actionClosure()
      }

      // MARK: - SharedValueObserver

      private var localizationIdentifier: String { "localization" }
      private var isHiddenIdentifier: String { "is hidden" }
      internal func valueChanged(for identifier: String) {
        switch identifier {
        case localizationIdentifier:
          self.title = String(label.resolved())
        case isHiddenIdentifier:
          self.isHidden = isHiddenBinding.value
        default:  // @exempt(from: tests)
          break
        }
      }
    }
  }
#endif
