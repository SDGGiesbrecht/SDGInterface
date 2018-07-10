/*
 LocalizedMenu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization
import SDGInterfaceLocalizations

open class LocalizedMenu<L : Localization> : Menu, SharedValueObserver {

    // MARK: - Initialization

    public init(label: Shared<UserFacing<StrictString, L>>) {
        self.label = label
        super.init(title: String(label.value.resolved()))
        LocalizationSetting.current.register(observer: self)
    }

    @available(*, unavailable) public required init(coder decoder: NSCoder) {
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Menu"
            }
        }))
    }

    // MARK: - Properties

    /// The label.
    public var label: Shared<UserFacing<StrictString, L>>

    // MARK: - Modifications

    /// Creates, inserts and returns a new entry.
    @discardableResult public func newEntry<E>(labelled label: Shared<UserFacing<StrictString, E>>, action: Selector? = nil, keyEquivalent: String? = nil, modifierMask: NSEvent.ModifierFlags = [], target: AnyObject? = nil) -> LocalizedMenuItem<E> {
        let entry = createEntry(labelled: label, action: action, keyEquivalent: keyEquivalent, modifierMask: modifierMask, target: target)
        addItem(entry)
        return entry
    }

    /// Creates, inserts and returns a new separator.
    @discardableResult public func newSeparator() -> MenuItem {
        let separator = createSeparator()
        addItem(separator)
        return separator
    }

    /// Creates, inserts and returns a new submenu.
    @discardableResult public func newSubmenu<S>(labelled label: Shared<UserFacing<StrictString, S>>) -> LocalizedMenu<S> {
        let header = newEntry(labelled: label)
        let submenu = createSubmenu(labelled: label)
        header.submenu = submenu
        return submenu
    }

    // MARK: - Subclassing

    /// Override in a subclass to use a different class of menu entry.
    open func createEntry<E>(labelled label: Shared<UserFacing<StrictString, E>>, action: Selector?, keyEquivalent: String?, modifierMask: NSEvent.ModifierFlags, target: AnyObject?, indented: Bool = false) -> LocalizedMenuItem<E> {
        return LocalizedMenuItem(label: label, action: action, keyEquivalent: keyEquivalent, modifierMask: modifierMask, target: target, indented: indented)
    }

    /// Override in a subclass to use a different class of menu entry.
    open func createSeparator() -> NSMenuItem {
        return MenuItem.separator()
    }

    /// Override in a subclass to use a different class of sub menu.
    open func createSubmenu<S>(labelled label: Shared<UserFacing<StrictString, S>>) -> LocalizedMenu<S> where S : Localization {
        return LocalizedMenu<S>(label: label)
    }

    // MARK: - SharedValueObserver

    // [_Inherit Documentation: SDGCornerstone.SharedValueObserver.valueChanged(for:)_]
    /// Called when a value changes.
    ///
    /// - Parameters:
    ///     - identifier: The identifier that was specified when the observer was registered. This can be used to differentiate between several values watched by the same observer.
    ///
    /// - SeeAlso: `register(observer:identifier)`
    public func valueChanged(for identifier: String) {
        self.title = String(label.value.resolved())
    }
}
