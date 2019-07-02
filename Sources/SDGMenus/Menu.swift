/*
 Menu.swift

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

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGInterfaceBasics

import SDGInterfaceLocalizations

/// A menu.
public final class Menu<L> : AnyMenu, SharedValueObserver where L : Localization {
    #warning("Remove shared value observer.")

    // MARK: - Initialization

    /// Creates a menu.
    ///
    /// - Parameters:
    ///     - label: The label.
    public init(label: Binding<StrictString, L>) {
        self.label = label
        labelDidSet()
        LocalizationSetting.current.register(observer: self)
    }

    #if canImport(AppKit)
    /// Creates an unlocalized menu with a native menu.
    ///
    /// - Parameters:
    ///     - native: The native menu.
    public init(native: NSMenu) {
        let title = native.title
        let items = native.items

        self.native = native
        defer { refreshNative() }

        self.label = .binding(Shared(StrictString(title)))
        labelDidSet()

        self.entries = items.map { item in
            if item.isSeparatorItem {
                return .separator
            } else if let submenu = item.submenu {
                return .submenu(Menu<InterfaceLocalization>(native: submenu))
            } else {
                return .entry(MenuEntry<InterfaceLocalization>(native: item))
            }
        }
        refreshEntries()
    }
    #endif

    // MARK: - Properties

    /// The label.
    public var label: Binding<StrictString, L> {
        willSet {
            label.shared?.cancel(observer: self)
        }
        didSet {
            labelDidSet()
        }
    }
    private func labelDidSet() {
        label.shared?.register(observer: self)
    }

    // MARK: - Refreshing

    #if canImport(AppKit)
    private func refreshNative() {
        refreshLabel()
        refreshEntries()
    }
    #endif
    public func _refreshLabel() {
        #if canImport(AppKit)
        native.title = String(label.resolved())
        if let index = native.supermenu?.indexOfItem(withSubmenu: native) {
            native.supermenu?.item(at: index)?.title = String(label.resolved())
        }
        #endif
    }
    private func refreshEntries() {
        #if canImport(AppKit)
        native.items = entries.map { component in
            switch component {
            case .entry(let entry):
                if let index = entry.native.menu?.index(of: entry.native) {
                    entry.native.menu?.removeItem(at: index)
                }
                return entry.native
            case .submenu(let menu):
                if let index = menu.native.supermenu?.indexOfItem(withSubmenu: menu.native) {
                    menu.native.supermenu?.removeItem(at: index)
                }
                let entry = NSMenuItem()
                entry.submenu = menu.native
                return entry
            case .separator:
                return NSMenuItem.separator()
            }
        }
        #endif
        for entry in entries {
            #if canImport(AppKit)
            if case .submenu(let menu) = entry {
                menu.refreshLabel()
            }
            #endif
        }
    }

    // MARK: - AnyMenu

    public var entries: [MenuComponent] = [] {
        didSet {
            refreshEntries()
        }
    }

    #if canImport(AppKit)
    public var native: NSMenu = NSMenu() {
        didSet {
            refreshNative()
        }
    }
    #endif

    // MARK: - SharedValueObserver

    public func valueChanged(for identifier: String) {
        refreshLabel()
    }
}
#endif
