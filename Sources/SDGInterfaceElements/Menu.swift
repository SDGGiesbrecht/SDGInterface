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
/// :nodoc:
public typealias Menu = NSMenu
#endif

extension Menu {

    // MARK: - Related Items

    /// Returns the parent menu item.
    public var parentMenuItem: MenuItem? {
        if let index = supermenu?.indexOfItem(withSubmenu: self),
            let parent = supermenu?.item(at: index) {

            return parent
        }
        return nil
    }
}
