/*
 MenuEntry.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
        isDisabled: @escaping () -> Bool,
        isHidden: Shared<Bool>,
        tag: Int?
      ) {
        self.label = label
        defer {
          LocalizationSetting.current.register(observer: self, identifier: localizationIdentifier)
        }

        self.actionClosure = action
        self.isDisabled = isDisabled
        self.closureSelector = ClosureSelector(action: action, isDisabled: isDisabled)

        #if canImport(AppKit)
          self.isHiddenBinding = isHidden
          defer {
            isHiddenBinding.register(observer: self, identifier: isHiddenIdentifier)
          }
        #endif

        #if canImport(AppKit)
          super.init(
            title: "" /* temporary placeholder */,
            action: #selector(ClosureSelector.send),
            keyEquivalent: hotKey ?? ""
          )
          self.keyEquivalentModifierMask = hotKeyModifiers.cocoa()
          self.target = self.closureSelector
        #else
          super.init(title: "" /* temporary placeholder */, action: action ?? .none)
        #endif

        #if canImport(AppKit)
          if let tag = tag {
            self.tag = tag
          }
        #endif
      }

      internal required init(coder: NSCoder) {
        codingNotSupported()
      }

      // MARK: - Properties

      private let label: UserFacing<StrictString, L>
      private let actionClosure: () -> Void
      private let isDisabled: () -> Bool
      private let closureSelector: ClosureSelector
      #if canImport(AppKit)
        private let isHiddenBinding: Shared<Bool>
      #endif

      #if canImport(AppKit)
        // MARK: - NSCopying

        internal override func copy(with zone: NSZone?) -> Any {
          // Prevents the superclass from attempting to call an unavailable initializer.
          return CocoaImplementation(
            label: label,
            hotKeyModifiers: KeyModifiers(keyEquivalentModifierMask),
            hotKey: keyEquivalent,
            action: actionClosure,
            isDisabled: isDisabled,
            isHidden: isHiddenBinding,
            tag: tag
          )
        }
      #endif

      // MARK: - SharedValueObserver

      private var localizationIdentifier: String { "localization" }
      #if canImport(AppKit)
        private var isHiddenIdentifier: String { "is hidden" }
      #endif
      internal func valueChanged(for identifier: String) {
        switch identifier {
        case localizationIdentifier:
          self.title = String(label.resolved())
        #if canImport(AppKit)
          case isHiddenIdentifier:
            self.isHidden = isHiddenBinding.value
        #endif
        default:  // @exempt(from: tests)
          break  // @exempt(from: tests)
        }
      }
    }
  }
#endif
