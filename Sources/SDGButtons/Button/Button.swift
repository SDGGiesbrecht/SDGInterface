/*
 Button.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
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

  /// A button.
  @available(watchOS 6, *)
  public struct RefactoredButton<L>: LegacyView where L: Localization {
    #warning("Rename.")

    // MARK: - Initialization

    public init(label: SDGInterfaceBasics.Binding<StrictString, L>) {
      self.label = label
    }

    // MARK: - Properties

    private let label: SDGInterfaceBasics.Binding<StrictString, L>

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        return useSwiftUIOrFallback(to: {
          return CocoaButtonImplementation(label: label).cocoa()
        })
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension RefactoredButton: SDGViews.View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        let labelString: UserFacing<StrictString, L>
        switch label {
        case .binding(let binding):
          labelString = UserFacing({ _ in binding.value })
        case .static(let `static`):
          labelString = `static`
        }
        return SwiftUIImplementation(
          label: .constant(labelString),
          action: {
            #warning("What goes here?")
          },
          localization: LocalizationSetting._observableCurrent
        )
      }
    #endif
  }

  #warning("Reduce and move elsewhere.")
  private typealias CocoaButtonImplementation = Button
#endif

#warning("Remove?")
#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)

  #warning("Protocols?")
  public final class Button<L>: AnyButton, CocoaViewImplementation, SDGViews.View
  where L: Localization {

    // MARK: - Initialization

    /// Creates a button.
    ///
    /// - Parameters:
    ///     - label: The label on the button.
    public init(label: SDGInterfaceBasics.Binding<StrictString, L>) {
      self.label = label
      defer {
        labelDidSet()
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

    /// The label.
    public var label: SDGInterfaceBasics.Binding<StrictString, L> {
      willSet {
        label.shared?.cancel(observer: bindingObserver)
      }
      didSet {
        labelDidSet()
      }
    }
    private func labelDidSet() {
      label.shared?.register(observer: bindingObserver)
    }

    // MARK: - Refreshing

    public func _refreshBindings() {
      let resolved = String(label.resolved())
      #if canImport(AppKit)
        specificCocoaView.title = resolved
      #elseif canImport(UIKit)
        specificCocoaView.titleLabel?.text = resolved
      #endif
    }

    // MARK: - LegacyView

    public func cocoa() -> CocoaView {
      return CocoaView(specificCocoaView)
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
      public let specificCocoaView: NSButton
    #elseif canImport(UIKit)
      public let specificCocoaView: UIButton
    #endif
  }
#endif
