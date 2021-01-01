/*
 MenuComponent.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  /// A menu component.
  public enum MenuComponent {

    /// A menu entry.
    case entry(AnyMenuEntry)

    #if canImport(AppKit)
      /// A submenu.
      case submenu(AnyMenu)

      /// A group separator.
      case separator
    #endif

    // MARK: - Properties

    /// Returns the associated value if the component is a entry.
    public var asEntry: AnyMenuEntry? {
      switch self {
      case .entry(let entry):
        return entry
      #if canImport(AppKit)
        case .submenu, .separator:
          return nil
      #endif
      }
    }

    #if canImport(AppKit)
      /// Returns the associated value if the component is a submenu.
      public var asSubmenu: AnyMenu? {
        switch self {
        case .submenu(let submenu):
          return submenu
        case .entry, .separator:
          return nil
        }
      }
    #endif

    #if canImport(AppKit)
      /// Generates an `NSMenuItem` instance representing the menu component.
      public func cocoa() -> NSMenuItem {
        switch self {
        case .entry(let entry):
          return entry.cocoa()
        case .submenu(let menu):
          let entry = NSMenuItem()
          entry.submenu = menu.cocoa()
          entry.title = entry.submenu!.title
          return entry
        case .separator:
          return NSMenuItem.separator()
        }
      }
    #endif

    #if canImport(UIKit)
      /// Generates an `UIMenuItem` instance representing the menu component.
      public func cocoa() -> UIMenuItem {
        switch self {
        case .entry(let entry):
          return entry.cocoa()
        }
      }
    #endif
  }
#endif
