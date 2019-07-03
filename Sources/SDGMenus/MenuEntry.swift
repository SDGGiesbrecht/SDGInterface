/*
 MenuEntry.swift

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
import SDGText
import SDGLocalization

import SDGInterfaceBasics

/// A menu entry.
public final class MenuEntry<L> : AnyMenuEntry where L : Localization {

    // MARK: - Initialization

    /// Creates a menu entry.
    ///
    /// - Parameters:
    ///     - label: The label.
    public init(label: Binding<StrictString, L>) {
        self.label = label
        bindingObserver.entry = self
        labelDidSet()
        LocalizationSetting.current.register(observer: bindingObserver)
    }

    #if canImport(AppKit)
    /// Creates an unlocalized menu entry with a native menu item.
    ///
    /// - Parameters:
    ///     - native: The native menu item.
    public init(native: NSMenuItem) {
        let title = native.title

        self.native = native
        defer { refreshNative() }
        self.label = .binding(Shared(StrictString(title)))
        labelDidSet()
    }
    #endif

    // MARK: - Properties

    /// The label.
    public var label: Binding<StrictString, L> {
        willSet {
            label.shared?.cancel(observer: bindingObserver)
        }
        didSet {
            labelDidSet()
        }
    }
    private func labelDidSet() {
        label.shared?.register(observer: bindingObserver)
    }

    private var bindingObserver = MenuEntryBindingObserver()

    // MARK: - Refreshing

    private func refreshNative() {
        refreshLabel()
    }
    private func refreshLabel() {
        native.title = String(label.resolved())
    }
    public func _refreshBindings() {
        refreshLabel()
    }

    // MARK: - AnyMenuEntry

    #if canImport(AppKit)
    public var native: NSMenuItem = NSMenuItem() {
        didSet {
            refreshNative()
        }
    }
    #elseif canImport(UIKit)
    public var native: UIMenuItem = UIMenuItem() {
        didSet {
            refreshNative()
        }
    }
    public var _isHidden: Bool = false
    public var _tag: Int = 0
    #endif
}
#endif
