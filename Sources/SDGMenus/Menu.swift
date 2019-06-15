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

/// A menu.
public final class Menu {

    // MARK: - Initialization

    #if canImport(NSMenu)
    /// Creates a menu from a native menu.
    ///
    /// - Parameters:
    ///     - native: The native menu.
    public init(native: NSMenu) {
        self.native = native
    }
    #endif

    public init() {
        #if canImport(AppKit)
        native = NSMenu()
        #endif
    }

    // MARK: - Properties

    #if canImport(AppKit)
    /// The native menu.
    public let native: NSMenu
    #endif
}
