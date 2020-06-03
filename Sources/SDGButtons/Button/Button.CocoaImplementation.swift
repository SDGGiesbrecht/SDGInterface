/*
 Button.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  import SDGInterfaceBasics
  import SDGViews

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
            self.action = #selector(triggerAction)
          #else
            let event: UIControl.Event
            if #available(iOS 9, *) {
              event = .primaryActionTriggered
            } else {  // @exempt(from: tests)
              event = .touchUpInside
            }
            self.addTarget(
              self,
              action: #selector(triggerAction),
              for: event
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
      }

      internal required init?(coder decoder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private var label: UserFacing<StrictString, L>
      private var actionClosure: () -> Void

      // MARK: - NSButton

      @objc private func triggerAction() {  // @exempt(from: tests)
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
