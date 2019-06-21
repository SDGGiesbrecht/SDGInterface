/*
 Menu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#endif

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGInterfaceBasics

#warning("Hide observation.")
/// A menu.
public final class Menu<L> : AnyMenu, SharedValueObserver where L : Localization {

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
            if case .submenu(let menu) = entry {
                menu.refreshLabel()
            }
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
