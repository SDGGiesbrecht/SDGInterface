/*
 MenuEntry.swift

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
import SDGText
import SDGLocalization

/// A menu entry.
public final class MenuEntry<L> : SharedValueObserver where L : Localization {

    // MARK: - Initialization

    /// Creates a menu.
    ///
    /// - Parameters:
    ///     - label: The label.
    public init(label: Binding<StrictString, L>) {
        #if canImport(AppKit)
        native = NSMenuItem()
        #elseif canImport(UIKit)
        native = UIMenuItem()
        #endif

        self.label = label
        LocalizationSetting.current.register(observer: self)
    }

    // MARK: - Properties

    #if canImport(AppKit)
    /// The native menu item.
    public var native: NSMenuItem {
        didSet {
            refresh()
        }
    }
    #endif

    #if canImport(UIKit)
    /// The native menu item.
    public var native: UIMenuItem {
        didSet {
            refresh()
        }
    }
    #endif

    /// The label.
    public var label: Binding<StrictString, L> {
        willSet {
            label.shared?.cancel(observer: self)
        }
        didSet {
            label.shared?.register(observer: self)
        }
    }

    /// The action.
    public var action: Selector? {
        get {
            return native.action
        }
        set {
            native.action = newValue
        }
    }

    private func refresh() {
        native.title = String(label.resolved())
    }

    // MARK: - SharedValueObserver

    public func valueChanged(for identifier: String) {
        refresh()
    }
}
