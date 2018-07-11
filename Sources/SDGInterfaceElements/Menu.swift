/*
 Menu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
// #if canImport(AppKit)
// [_Define Documentation: Menu_]
/// An alias for `NSMenu` or `UIMenuController`.
public typealias Menu = NSMenu
#elseif canImport(UIKit)
// [_Inherit Documentation: Menu_]
public typealias Menu = UIMenuController
#endif

extension Menu {

    // MARK: - Related Items

    /// Returns the parent menu item.
    public var parentMenuItem: MenuItem? {
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
    #endif

    // MARK: - Subclassing

    /// Override in a subclass to use a different class of menu entry.
    open func createEntry<E>(labelled label: Shared<UserFacing<StrictString, E>>, action: Selector?) -> LocalizedMenuItem<E> {
        return LocalizedMenuItem(label: label, action: action)
    }

    #if canImport(AppKit)
    /// Override in a subclass to use a different class of menu entry.
    open func createSeparator() -> MenuItem {
        return MenuItem.separator()
    }

    /// Override in a subclass to use a different class of sub menu.
    open func createSubmenu<S>(labelled label: Shared<UserFacing<StrictString, S>>) -> LocalizedMenu<S> where S : Localization {
        return LocalizedMenu<S>(label: label)
    }
    #endif
}
