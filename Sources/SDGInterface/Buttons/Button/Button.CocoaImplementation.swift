/*
 Button.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if PLATFORM_HAS_COCOA_INTERFACE
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  extension Button {

    #if canImport(AppKit)
      internal typealias Superclass = NSButton
    #else
      internal typealias Superclass = UIButton
    #endif
    internal final class CocoaImplementation: Superclass, SharedValueObserver {

      // MARK: - Initialization

      internal init(label: UserFacing<StrictString, L>, action: @escaping () -> Void) {
        self.label = label
        defer {
          LocalizationSetting.current.register(observer: self)
        }

        self.actionClosure = action
        defer {
          #if canImport(AppKit)
            self.target = self
            self.action = #selector(Button.CocoaImplementation.triggerAction)
          #else
            self.addTarget(
              self,
              action: #selector(triggerAction),
              for: .primaryActionTriggered
            )
          #endif
        }

        super.init(frame: CGRect.zero)

        #if canImport(AppKit)
          bezelStyle = .rounded
          setButtonType(.momentaryPushIn)
        #endif

        #if canImport(AppKit)
          font = NSFont.from(Font.forLabels)
        #elseif canImport(UIKit)
          titleLabel?.font = UIFont.from(Font.forLabels)
        #endif

        setContentHuggingPriority(.required, for: .horizontal)
      }

      internal required init?(coder decoder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let label: UserFacing<StrictString, L>
      private let actionClosure: () -> Void

      // MARK: - NSButton

      @objc private func triggerAction() {  // @exempt(from: tests)
        // Exempt from tests because tvOS cannot dispatch actions during tests.
        actionClosure()
      }

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        let resolved = String(label.resolved())
        #if canImport(AppKit)
          title = resolved
        #elseif canImport(UIKit)
          titleLabel?.text = resolved
        #endif
      }
    }
  }
#endif
