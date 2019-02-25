/*
 Menu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS) && !os(tvOS)

#if !canImport(AppKit)
/// An `AppKit.NSMenu` or a `UIMenuController`.
public typealias NSMenu = UIMenuController
#endif

extension NSMenu {

    // MARK: - Related Items

    /// Returns the parent menu item.
    public var parentMenuItem: NSMenuItem? {
        #if canImport(AppKit)
        if let index = supermenu?.indexOfItem(withSubmenu: self),
            let parent = supermenu?.item(at: index) {

            return parent
        }
        #endif
        return nil
    }

    // MARK: - Modifications

    /// Creates, inserts and returns a new entry.
    ///
    /// - Parameters:
    ///     - label: A label for the entry.
    ///     - action: Optional. An action for the entry.
    @discardableResult public func newEntry<E>(labelled label: Shared<UserFacing<StrictString, E>>, action: Selector? = nil) -> LocalizedMenuItem<E> {
        let entry = createEntry(labelled: label, action: action)
        #if canImport(AppKit)
        addItem(entry)
        #elseif canImport(UIKit)
        if menuItems == nil {
            menuItems = []
        }
        menuItems?.append(entry)
        #endif
        return entry
    }

    #if canImport(AppKit)
    /// Creates, inserts and returns a new separator.
    @discardableResult public func newSeparator() -> NSMenuItem {
        let separator = createSeparator()
        addItem(separator)
        return separator
    }

    /// Creates, inserts and returns a new submenu.
    ///
    /// - Parameters:
    ///     - label: A label for the submenu.
    @discardableResult public func newSubmenu<S>(labelled label: Shared<UserFacing<StrictString, S>>) -> LocalizedMenu<S> {
        let header = newEntry(labelled: label)
        let submenu = createSubmenu(labelled: label)
        header.submenu = submenu
        return submenu
    }
    #endif

    // MARK: - Subclassing

    /// Override in a subclass to use a different class of menu entry.
    ///
    /// - Parameters:
    ///     - label: A label for the entry.
    ///     - action: Optional. An action for the entry.
    open func createEntry<E>(labelled label: Shared<UserFacing<StrictString, E>>, action: Selector?) -> LocalizedMenuItem<E> {
        return LocalizedMenuItem(label: label, action: action)
    }

    #if canImport(AppKit)
    /// Override in a subclass to use a different class of menu entry.
    open func createSeparator() -> NSMenuItem {
        return NSMenuItem.separator()
    }

    /// Override in a subclass to use a different class of sub menu.
    ///
    /// - Parameters:
    ///     - label: A label for the submenu.
    open func createSubmenu<S>(labelled label: Shared<UserFacing<StrictString, S>>) -> LocalizedMenu<S> where S : Localization {
        return LocalizedMenu<S>(label: label)
    }
    #endif
}

#endif
