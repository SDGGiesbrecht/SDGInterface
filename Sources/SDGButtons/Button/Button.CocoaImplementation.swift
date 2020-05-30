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

  import SDGText
  import SDGLocalization

  import SDGInterfaceBasics
  import SDGViews

  extension Button {

    #warning("Remove?")
    #warning("Re‐do access control.")
    #warning("Protocols?")
    #warning("Handle support types.")
    #if canImport(AppKit)
      internal typealias Superclass = NSButton
    #else
      internal typealias Superclass = UIButton
    #endif
    internal final class CocoaImplementation: Superclass, AnyButton {

      // MARK: - Initialization

      internal init(label: UserFacing<StrictString, L>, action: @escaping () -> Void) {
        self.label = label
        defer {
          bindingObserver.button = self
          LocalizationSetting.current.register(observer: bindingObserver)
        }

        self.actionClosure = action
        defer {
          self.target = self
          self.action = #selector(triggerAction)
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

      required init?(coder: NSCoder) {
        #warning("What to do with this?")
        fatalError("init(coder:) has not been implemented")
      }

      // MARK: - Properties

      private var label: UserFacing<StrictString, L>
      private var actionClosure: () -> Void

      private let bindingObserver = ButtonBindingObserver()

      // MARK: - NSButton

      @objc private func triggerAction() {
        actionClosure()
      }

      // MARK: - Refreshing

      internal func _refreshBindings() {
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
