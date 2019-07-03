/*
 AnyMenuEntry.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS) && !os(tvOS)
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

import SDGControlFlow

/// A menu entry with no particular localization.
public protocol AnyMenuEntry : AnyObject {

    #if canImport(AppKit)
    /// The native menu item.
    var native: NSMenuItem { get set }
    #elseif canImport(UIKit)
    /// The native menu item.
    var native: UIMenuItem { get set }
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

    #if canImport(AppKit)
    /// The target for the action.
    public var target: AnyObject? {
        get {
            return native.target
        }
        set {
            native.target = newValue
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
    #endif

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

    #if canImport(AppKit)
    /// The indentation level.
    public var indentationLevel: Int {
        get {
            return native.indentationLevel
        }
        set {
            native.indentationLevel = newValue
        }
    }
    #endif

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
#endif
