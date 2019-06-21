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
    /// Some platforms do not recognize the target, and may use the responder chain regardless of the value of this property.
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

    /// The hot key.
    public var hotKey: String {
        get {
            return native.keyEquivalent
        }
        set {
            native.keyEquivalent = newValue
        }
    }

    /// The hot key modifiers.
    public var hotKeyModifiers: KeyModifiers {
        get {
            return KeyModifiers(native.keyEquivalentModifierMask)
        }
        set {
            native.keyEquivalentModifierMask = newValue.native
        }
    }

    /// Whether or not the menu entry is hidden and inactive.
    public var isHidden: Bool {
        get {
            return native.isHidden
        }
        set {
            native.isHidden = newValue
        }
    }

    /// The indentation level.
    public var indentationLevel: Int {
        get {
            return native.indentationLevel
        }
        set {
            native.indentationLevel = newValue
        }
    }

    /// A tag to identify the menu entry.
    public var tag: Int {
        get {
            return native.tag
        }
        set {
            native.tag = newValue
        }
    }
}
