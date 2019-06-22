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
    #if !os(watchOS) && !os(tvOS)
    /// The native menu item.
    var native: UIMenuItem { get set }
    #endif
    var _tag: Int { get set }
    #endif
}

extension AnyMenuEntry {

    /// The action.
    public var action: Selector? {
        get {
            #if os(watchOS) || os(tvOS)
            return nil
            #else
            return native.action
            #endif
        }
        set {
            #if canImport(AppKit)
            native.action = newValue
            #elseif canImport(UIKit) && !os(watchOS) && !os(tvOS)
            if let new = newValue {
                native.action = new
            } else {
                native.action = Selector.none
            }
            #endif
        }
    }

    /// The desired target for the action.
    ///
    /// - Note: Targets are only supported on some platforms, others may ignore this property.
    public var target: AnyObject? {
        get {
            #if canImport(AppKit)
            return native.target
            #else
            return nil
            #endif
        }
        set {
            #if canImport(AppKit)
            native.target = newValue
            #endif
        }
    }

    /// The hot key.
    ///
    /// - Note: Hot keys are only supported on some platforms, others may ignore this property.
    public var hotKey: String {
        get {
            #if canImport(AppKit)
            return native.keyEquivalent
            #elseif canImport(UIKit)
            return ""
            #endif
        }
        set {
            #if canImport(AppKit)
            native.keyEquivalent = newValue
            #endif
        }
    }

    /// The hot key modifiers.
    ///
    /// - Note: Hot keys are only supported on some platforms, others may ignore this property.
    public var hotKeyModifiers: KeyModifiers {
        get {
            #if canImport(AppKit)
            return KeyModifiers(native.keyEquivalentModifierMask)
            #elseif canImport(UIKit)
            return []
            #endif
        }
        set {
            #if canImport(AppKit)
            native.keyEquivalentModifierMask = newValue.native
            #endif
        }
    }

    /// Whether or not the menu entry is hidden and inactive.
    ///
    /// - Note: Hiding is only supported on some platforms, others may ignore this property.
    public var isHidden: Bool {
        get {
            #if canImport(AppKit)
            return native.isHidden
            #elseif canImport(UIKit)
            return false
            #endif
        }
        set {
            #if canImport(AppKit)
            native.isHidden = newValue
            #endif
        }
    }

    /// The indentation level to use if the menu is layed out vertically.
    ///
    /// - Note: Indentation is only supported on some platforms, others may ignore this property.
    public var indentationLevel: Int {
        get {
            #if canImport(AppKit)
            return native.indentationLevel
            #elseif canImport(UIKit)
            return 0
            #endif
        }
        set {
            #if canImport(AppKit)
            native.indentationLevel = newValue
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
