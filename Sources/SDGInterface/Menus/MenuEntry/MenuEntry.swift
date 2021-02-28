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
      action: Selector? = nil
    ) {
      self.label = label
      self.hotKeyModifiers = hotKeyModifiers
      self.hotKey = hotKey
      self.action = action
      #if canImport(AppKit)
        target = nil
        isHidden = Shared(false)
        tag = nil
      #endif
    }

    #if canImport(AppKit)
      private init(
        label: UserFacing<StrictString, L>,
        hotKeyModifiers: KeyModifiers = [],
        hotKey: String? = nil,
        action: Selector? = nil,
        target: AnyObject? = nil,
        isHidden: Shared<Bool> = Shared(false),
        platformTag: Int? = nil
      ) {
        self.label = label
        self.hotKeyModifiers = hotKeyModifiers
        self.hotKey = hotKey
        self.action = action
        self.target = target
        self.isHidden = isHidden
        self.tag = platformTag
      }
    #endif

    // MARK: - Properties

    private let label: UserFacing<StrictString, L>
    private let hotKeyModifiers: KeyModifiers
    private let hotKey: String?
    private let action: Selector?
    #if canImport(AppKit)
      private weak var target: AnyObject?
      private let isHidden: Shared<Bool>
      private let tag: Int?
    #endif

    // MARK: - Platform‐Specific Adjustements

    #if canImport(AppKit)
      /// Returns a menu entry reconfigured to send its action to a specific target.
      ///
      /// - Parameters:
      ///   - target: The target of the action.
      public func target(_ target: AnyObject) -> MenuEntry {
        return MenuEntry(
          label: label,
          hotKeyModifiers: hotKeyModifiers,
          hotKey: hotKey,
          action: action,
          target: target,
          isHidden: isHidden,
          platformTag: tag
        )
      }

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
          target: target,
          isHidden: isHidden,
          platformTag: tag
        )
      }

      /// Returns a menu entry reconfigured with a particular platform tag.
      ///
      /// System actions on some platforms need numeric tag identifiers to provide additional information when the action is triggered. Use of this method is discouraged except when necessary to interact with such system actions.
      ///
      /// - Parameters:
      ///   - platformTag: The platform tag.
      public func tag(_ platformTag: Int) -> MenuEntry {
        return MenuEntry(
          label: label,
          hotKeyModifiers: hotKeyModifiers,
          hotKey: hotKey,
          action: action,
          target: target,
          isHidden: isHidden,
          platformTag: platformTag
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
          target: target,
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
          target: nil,
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
          action: action.action(target: target, sender: self)
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
          action: #selector(TextEditingResponder.normalizeText)
        ).swiftUI()
          .padding()
          .previewDisplayName("Menu Entry")
      }
    }
  }
#endif
