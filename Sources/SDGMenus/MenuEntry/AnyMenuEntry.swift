/*
 AnyMenuEntry.swift

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

  /// A menu entry with no particular localization.
  public protocol AnyMenuEntry: AnyObject {

    #if canImport(AppKit)
      /// The Cocoa menu item.
      var cocoa: NSMenuItem { get }
    #elseif canImport(UIKit)
      /// The Cocoa menu item.
      var cocoa: UIMenuItem { get }
      var _isHidden: Bool { get set }
      var _tag: Int { get set }
    #endif

    func _refreshBindings()
  }

  extension AnyMenuEntry {

    internal func refreshBindings() {
      _refreshBindings()
    }

    /// The action.
    public var action: Selector? {
      get {
        return cocoa.action
      }
      set {
        #if canImport(AppKit)
          cocoa.action = newValue
        #elseif canImport(UIKit)
          if let new = newValue {
            cocoa.action = new
          } else {
            cocoa.action = Selector.none
          }
        #endif
      }
    }

    #if canImport(AppKit)
      /// The target for the action.
      public var target: AnyObject? {
        get {
          return cocoa.target
        }
        set {
          cocoa.target = newValue
        }
      }

      /// The hot key.
      public var hotKey: String {
        get {
          return cocoa.keyEquivalent
        }
        set {
          cocoa.keyEquivalent = newValue
        }
      }

      /// The hot key modifiers.
      public var hotKeyModifiers: KeyModifiers {
        get {
          return KeyModifiers(cocoa.keyEquivalentModifierMask)
        }
        set {
          cocoa.keyEquivalentModifierMask = newValue.cocoa
        }
      }
    #endif

    /// Whether or not the menu entry is hidden and inactive.
    public var isHidden: Bool {
      get {
        #if canImport(AppKit)
          return cocoa.isHidden
        #elseif canImport(UIKit)
          return _isHidden
        #endif
      }
      set {
        #if canImport(AppKit)
          cocoa.isHidden = newValue
        #elseif canImport(UIKit)
          _isHidden = newValue
        #endif
      }
    }

    #if canImport(AppKit)
      /// The indentation level.
      public var indentationLevel: Int {
        get {
          return cocoa.indentationLevel
        }
        set {
          cocoa.indentationLevel = newValue
        }
      }
    #endif

    /// A tag to identify the menu entry.
    public var tag: Int {
      get {
        #if canImport(AppKit)
          return cocoa.tag
        #elseif canImport(UIKit)
          return _tag
        #endif
      }
      set {
        #if canImport(AppKit)
          cocoa.tag = newValue
        #elseif canImport(UIKit)
          _tag = newValue
        #endif
      }
    }
  }
#endif
