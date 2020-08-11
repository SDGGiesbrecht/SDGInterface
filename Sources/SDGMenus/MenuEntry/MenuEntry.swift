/*
 MenuEntry.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGInterfaceBasics

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
    ///   - target: The target of the action.
    ///   - isHidden: A binding indicating whether the menu item should be hidden.
    ///   - tag: A platform tag. System actions on some platforms need numeric tag identifiers to provide additional information when the action is triggered. Use of this parameter is discouraged except when necessary to interact with such system actions.
    public init(
      label: UserFacing<StrictString, L>,
      hotKeyModifiers: KeyModifiers = [],
      hotKey: String? = nil,
      action: Selector? = nil,
      target: AnyObject? = nil,
      isHidden: Shared<Bool> = Shared(false),
      indentationLevel: Int = 0,
      tag: Int? = nil
    ) {
      self.label = label
      self.hotKeyModifiers = hotKeyModifiers
      self.hotKey = hotKey
      self.action = action
      self.isHidden = isHidden
      self.tag = tag
    }

    // MARK: - Properties

    private let label: UserFacing<StrictString, L>
    private let hotKeyModifiers: KeyModifiers
    private let hotKey: String?
    private let action: Selector?
    private weak var target: AnyObject?
    private let isHidden: Shared<Bool>
    private let tag: Int?

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
          target: target,
          isHidden: isHidden,
          tag: tag
        )
      }
    #endif
  }
#endif
