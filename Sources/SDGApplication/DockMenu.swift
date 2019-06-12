/*
 DockMenu.swift

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

/// A dock menu.
public final class DockMenu {

    // MARK: - Initialization

    #if canImport(AppKit)
    /// Creates a dock menu from a native dock menu.
    ///
    /// - Parameters:
    ///     - native: The native menu.
    public init(_ native: NSMenu) {
        self.native = native
    }
    #endif

    #if canImport(AppKit)
    /// The native dock menu.
    public let native: NSMenu
    #endif
}
