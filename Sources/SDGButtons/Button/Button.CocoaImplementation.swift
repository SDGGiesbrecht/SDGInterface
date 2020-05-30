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
    internal final class CocoaImplementation: AnyButton, CocoaViewImplementation, SDGViews.View {

      // MARK: - Initialization

      internal init(label: UserFacing<StrictString, L>, action: @escaping () -> Void) {
        #warning("Deal with action.")
        self.label = label
        defer {
          LocalizationSetting.current.register(observer: bindingObserver)
        }

        #if canImport(AppKit)
          specificCocoaView = NSButton()
        #elseif canImport(UIKit)
          specificCocoaView = UIButton()
        #endif
        defer {
          bindingObserver.button = self
        }

        #if canImport(AppKit)
          specificCocoaView.bezelStyle = .rounded
          specificCocoaView.setButtonType(.momentaryPushIn)
        #endif

        #if canImport(AppKit)
          specificCocoaView.font = NSFont.from(Font.forLabels)
        #elseif canImport(UIKit)
          specificCocoaView.titleLabel?.font = UIFont.from(Font.forLabels)
        #endif
      }

      // MARK: - Properties

      private let bindingObserver = ButtonBindingObserver()

      private var label: UserFacing<StrictString, L>

      // MARK: - Refreshing

      internal func _refreshBindings() {
        let resolved = String(label.resolved())
        #if canImport(AppKit)
          specificCocoaView.title = resolved
        #elseif canImport(UIKit)
          specificCocoaView.titleLabel?.text = resolved
        #endif
      }

      // MARK: - LegacyView

      internal func cocoa() -> CocoaView {
        return CocoaView(specificCocoaView)
      }

      // MARK: - SpecificView

      #if canImport(AppKit)
        internal let specificCocoaView: NSButton
      #elseif canImport(UIKit)
        internal let specificCocoaView: UIButton
      #endif
    }
  }
#endif
