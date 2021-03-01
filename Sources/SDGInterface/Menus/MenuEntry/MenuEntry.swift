/*
 MenuEntry.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(tvOS) && !os(watchOS)
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow
  import SDGLogic
  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

  /// A menu entry.
  public struct MenuEntry<L>: AnyMenuEntry where L: Localization {

    // MARK: - Initialization

    /// Creates a menu entry.
    ///
    /// - Parameters:
    ///   - label: The label.
    ///   - hotKeyModifiers: The hot key modifiers.
    ///   - hotKey: The hot key.
    ///   - action: The action.
    public init(
      label: UserFacing<StrictString, L>,
      hotKeyModifiers: KeyModifiers = [],
      hotKey: String? = nil,
      action: @escaping () -> Void,
      isDisabled: @escaping () -> Bool = { return false }
    ) {
      self.label = label
      self.hotKeyModifiers = hotKeyModifiers
      self.hotKey = hotKey
      self.action = action
      self.isDisabled = isDisabled
      #if canImport(AppKit)
        isHidden = Shared(false)
        tag = nil
      #endif
    }

    #if canImport(AppKit)
      /// Creates a menu entry with a Cocoa selector.
      ///
      /// - Parameters:
      ///   - label: The label.
      ///   - hotKeyModifiers: The hot key modifiers.
      ///   - hotKey: The hot key.
      ///   - selector: The selector.
      ///   - target: Optional. A target.
      ///   - platformTag: Optional. Some platforms require tags in order to identify some of the actions they offer. This parameter should not otherwise be used.
      public init(
        label: UserFacing<StrictString, L>,
        hotKeyModifiers: KeyModifiers = [],
        hotKey: String? = nil,
        selector: Selector,
        target: Any? = nil,
        platformTag: Int? = nil
      ) {
        let proxy = { () -> NSMenuItem in
          let item = NSMenuItem(title: "", action: selector, keyEquivalent: "")
          if let tag = platformTag {
            item.tag = tag
          }
          return item
        }
        self.label = label
        self.hotKeyModifiers = hotKeyModifiers
        self.hotKey = hotKey
        self.action = {
          NSApplication.shared.sendAction(selector, to: target, from: proxy())
        }
        self.isDisabled = {
          if let target = target {
            if let custom = target as? NSMenuItemValidation {
              return ¬custom.validateMenuItem(proxy())
            } else {
              return false
            }
          } else {
            if let window = NSApplication.shared.keyWindow,
              let responder = window.firstResponder as? NSMenuItemValidation
            {
              return ¬responder.validateMenuItem(proxy())
            } else {
              return ¬NSApplication.shared.validateMenuItem(proxy())
            }
          }
        }
        isHidden = Shared(false)
        tag = platformTag
      }
    #endif

    #if canImport(AppKit)
      private init(
        label: UserFacing<StrictString, L>,
        hotKeyModifiers: KeyModifiers = [],
        hotKey: String? = nil,
        action: @escaping () -> Void,
        isDisabled: @escaping () -> Bool,
        isHidden: Shared<Bool> = Shared(false),
        platformTag: Int? = nil
      ) {
        self.label = label
        self.hotKeyModifiers = hotKeyModifiers
        self.hotKey = hotKey
        self.action = action
        self.isDisabled = isDisabled
        self.isHidden = isHidden
        self.tag = platformTag
      }
    #endif

    // MARK: - Properties

    #warning("Properties need switching to SwiftUI style.")
    private let label: UserFacing<StrictString, L>
    private let hotKeyModifiers: KeyModifiers
    private let hotKey: String?
    private let action: () -> Void
    #if canImport(AppKit)
      private let tag: Int?
    #endif
    private let isDisabled: () -> Bool
    #if canImport(AppKit)
      private let isHidden: Shared<Bool>
    #endif

    // MARK: - Platform‐Specific Adjustements

    #if canImport(AppKit)
      /// Returns a menu entry reconfigured to hide itself according to the state of a binding.
      ///
      /// - Parameters:
      ///   - isHidden: A binding indicating whether the menu item should be hidden.
      public func hidden(when isHidden: Shared<Bool>) -> MenuEntry {
        return MenuEntry(
          label: label,
          hotKeyModifiers: hotKeyModifiers,
          hotKey: hotKey,
          action: action,
          isDisabled: isDisabled,
          isHidden: isHidden,
          platformTag: tag
        )
      }
    #endif

    // MARK: - AnyMenuEntry

    #if canImport(AppKit)
      public func cocoa() -> NSMenuItem {
        return CocoaImplementation(
          label: label,
          hotKeyModifiers:
            hotKeyModifiers,
          hotKey: hotKey,
          action: action,
          isDisabled: isDisabled,
          isHidden: isHidden,
          tag: tag
        )
      }
    #elseif canImport(UIKit)
      public func cocoa() -> UIMenuItem {
        return CocoaImplementation(
          label: label,
          hotKeyModifiers:
            hotKeyModifiers,
          hotKey: hotKey,
          action: action,
          isHidden: Shared(false),
          tag: nil
        )
      }
    #endif

    #warning("This type’s methods need organizing.")
    #if canImport(SwiftUI)
      @available(macOS 10.15, *)
      public func swiftUI() -> some SwiftUI.View {
        #warning("Parameters missing.")
        return SwiftUIImplementation(
          label: label,
          action: action,
          isDisabled: isDisabled
        )
      }
    #endif
  }
#endif

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct MenuEntryPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      Group {

        MenuEntry(
          label: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Do Something"
            case .deutschDeutschland:
              return "Etwas machen"
            }
          }),
          hotKeyModifiers: [.command],
          hotKey: "d",
          action: { print("Hello, world!") }
        ).swiftUI()
          .padding()
          .previewDisplayName("Menu Entry")

        MenuEntry(
          label: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Disabled"
            case .deutschDeutschland:
              return "Deaktiviert"
            }
          }),
          hotKeyModifiers: [.command],
          hotKey: "d",
          action: { print("Hello, world!") },
          isDisabled: { true }
        ).swiftUI()
          .padding()
          .previewDisplayName("Disabled")
      }
    }
  }
#endif
