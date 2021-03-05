/*
 MenuEntry.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGControlFlow
  import SDGLogic
  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

  /// A menu entry.
  @available(tvOS 14, watchOS 6, *)
  public struct MenuEntry<L>: AnyMenuEntry where L: Localization {

    // MARK: - Initialization

    /// Creates a menu entry.
    ///
    /// - Parameters:
    ///   - label: The label.
    ///   - hotKeyModifiers: Optional. The hot key modifiers.
    ///   - hotKey: Optional. The hot key.
    ///   - action: The action.
    ///   - isDisabled: Optional. A closure that determines whether or not the menu item is disabled.
    public init(
      label: UserFacing<StrictString, L>,
      hotKeyModifiers: KeyModifiers = [],
      hotKey: Character? = nil,
      action: @escaping () -> Void,
      isDisabled: @escaping () -> Bool = { return false }
    ) {
      self.init(
        label: label,
        hotKeyModifiers: hotKeyModifiers,
        hotKey: hotKey,
        action: action,
        isDisabled: isDisabled,
        isHidden: Shared(false),
        platformTag: nil
      )
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
        hotKey: Character? = nil,
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
        self.init(
          label: label,
          hotKeyModifiers: hotKeyModifiers,
          hotKey: hotKey,
          action: {
            NSApplication.shared.sendAction(selector, to: target, from: proxy())
          },
          isDisabled: {
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
                return
                  ¬responder
                  .validateMenuItem(proxy())  // @exempt(from: tests) Unreachable from tests.
              } else {
                return ¬NSApplication.shared.validateMenuItem(proxy())
              }
            }
          },
          isHidden: Shared(false),
          platformTag: platformTag
        )
      }
    #endif

    #if canImport(UIKit) && !os(watchOS)
      /// Creates a menu entry with a Cocoa selector.
      ///
      /// - Parameters:
      ///   - label: The label.
      ///   - selector: The selector.
      public init(
        label: UserFacing<StrictString, L>,
        selector: Selector
      ) {
        self.init(
          label: label,
          hotKeyModifiers: [],
          hotKey: nil,
          action: {
            UIApplication.shared.sendAction(selector, to: nil, from: nil, for: nil)
          },
          isDisabled: { false },
          isHidden: Shared(false),
          platformTag: nil
        )
      }
    #endif

    private init(
      label: UserFacing<StrictString, L>,
      hotKeyModifiers: KeyModifiers = [],
      hotKey: Character? = nil,
      action: @escaping () -> Void,
      isDisabled: @escaping () -> Bool,
      isHidden: Shared<Bool> = Shared(false),
      platformTag: Int? = nil
    ) {
      self.label = label
      #if DEBUG
        _ = label.resolved()  // Eager execution to simplify testing.
      #endif
      self.hotKeyModifiers = hotKeyModifiers
      self.hotKey = hotKey
      self.action = action
      self.isDisabled = isDisabled
      #if DEBUG
        _ = isDisabled()  // Eager execution to simplify testing.
      #endif
      self.isHidden = isHidden
      self.tag = platformTag
    }

    // MARK: - Properties

    private let label: UserFacing<StrictString, L>
    private let hotKeyModifiers: KeyModifiers
    private let hotKey: Character?
    private let action: () -> Void
    private let tag: Int?
    private let isDisabled: () -> Bool
    private let isHidden: Shared<Bool>

    // MARK: - Platform‐Specific Adjustements

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

    // MARK: - SwiftUI

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      /// Creates the menu item in SwiftUI.
      @available(macOS 11, iOS 14, *)
      public func swiftUI() -> some SwiftUI.View {
        return SwiftUIImplementation(
          label: label,
          action: action,
          hotKeyModifiers: hotKeyModifiers.swiftUI(),
          hotKey: hotKey,
          isDisabled: isDisabled,
          isHidden: isHidden
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
          hotKey: hotKey.map({ String($0) }),
          action: action,
          isDisabled: isDisabled,
          isHidden: isHidden,
          tag: tag
        )
      }
    #elseif canImport(UIKit) && !os(tvOS) && !os(watchOS)
      public func cocoa() -> UIMenuItem {
        return CocoaImplementation(
          label: label,
          hotKeyModifiers:
            hotKeyModifiers,
          hotKey: hotKey.map({ String($0) }),
          action: action,
          isDisabled: isDisabled,
          isHidden: Shared(false),
          tag: tag
        )
      }
    #endif
  }
#endif

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(macOS 11, tvOS 14, iOS 14, watchOS 6, *)
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
          action: { print("Hello, world!") }  // @exempt(from: tests)
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
          action: { print("Hello, world!") },  // @exempt(from: tests)
          isDisabled: { true }
        ).swiftUI()
          .padding()
          .previewDisplayName("Disabled")
      }
    }
  }
#endif
