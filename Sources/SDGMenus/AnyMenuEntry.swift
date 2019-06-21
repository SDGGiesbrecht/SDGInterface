/*
 AnyMenuEntry.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import SDGControlFlow

/// A menu entry with no particular localization.
public protocol AnyMenuEntry : SharedValueObserver {

    #if canImport(AppKit)
    /// The native menu item.
    var native: NSMenuItem { get set }
    #elseif canImport(UIKit)
    /// The native menu item.
    var native: UIMenuItem { get set }
    var _target: AnyObject? { get set }
    var _hotKey: String { get set }
    var _hotKeyModifiers: KeyModifiers { get set }
    var _isHidden: Bool { get set }
    var _indentationLevel: Int { get set }
    var _tag: Int { get set }
    #endif
}

extension AnyMenuEntry {

    /// The action.
    public var action: Selector? {
        get {
            return native.action
        }
        set {
            #if canImport(AppKit)
            native.action = newValue
            #elseif canImport(UIKit)
            if let new = newValue {
                native.action = new
            } else {
                native.action = Selector.none
            }
            #endif
        }
    }

    /// The desired action target.
    ///
    /// - Note: The target may not be recognized by all platforms. Some may use the responder chain regardless of the value of this property.
    public var target: AnyObject? {
        get {
            #if canImport(AppKit)
            return native.target
            #elseif canImport(UIKit)
            return _target
            #endif
        }
        set {
            #if canImport(AppKit)
            native.target = newValue
            #elseif canImport(UIKit)
            _target = newValue
            #endif
        }
    }

    /// The desired hot key.
    ///
    /// - Note: Hot keys may not be recognized by all platforms.
    public var hotKey: String {
        get {
            #if canImport(AppKit)
            return native.keyEquivalent
            #elseif canImport(UIKit)
            return _hotKey
            #endif
        }
        set {
            #if canImport(AppKit)
            native.keyEquivalent = newValue
            #elseif canImport(UIKit)
            _hotKey = newValue
            #endif
        }
    }

    /// The desired hot key modifiers.
    ///
    /// - Note: Hot keys may not be recognized by all platforms.
    public var hotKeyModifiers: KeyModifiers {
        get {
            #if canImport(AppKit)
            return KeyModifiers(native.keyEquivalentModifierMask)
            #elseif canImport(UIKit)
            return _hotKeyModifiers
            #endif
        }
        set {
            #if canImport(AppKit)
            native.keyEquivalentModifierMask = newValue.native
            #elseif canImport(UIKit)
            _hotKeyModifiers = newValue
            #endif
        }
    }

    /// Whether or not the menu entry is hidden and inactive.
    public var isHidden: Bool {
        get {
            #if canImport(AppKit)
            return native.isHidden
            #elseif canImport(UIKit)
            return _isHidden
            #endif
        }
        set {
            #if canImport(AppKit)
            native.isHidden = newValue
            #elseif canImport(UIKit)
            _isHidden = newValue
            #endif
        }
    }

    /// The desired indentation level for when the menu is layed out vertically.
    ///
    /// - Note: Indentation may not be recognized on all platforms.
    public var indentationLevel: Int {
        get {
            #if canImport(AppKit)
            return native.indentationLevel
            #elseif canImport(UIKit)
            return _indentationLevel
            #endif
        }
        set {
            #if canImport(AppKit)
            native.indentationLevel = newValue
            #elseif canImport(UIKit)
            _indentationLevel = newValue
            #endif
        }
    }

    /// A tag to identify the menu entry.
    public var tag: Int {
        get {
            #if canImport(AppKit)
            return native.tag
            #elseif canImport(UIKit)
            return _tag
            #endif
        }
        set {
            #if canImport(AppKit)
            native.tag = newValue
            #elseif canImport(UIKit)
            _tag = newValue
            #endif
        }
    }
}
