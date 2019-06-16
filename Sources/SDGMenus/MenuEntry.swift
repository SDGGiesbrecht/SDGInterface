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

/// A menu entry.
public final class MenuEntry {

    // MARK: - Initialization

    #if canImport(NSMenu)
    /// Creates a menu from a native menu item.
    ///
    /// - Parameters:
    ///     - native: The native menu item.
    public init(native: NSMenuItem) {
        self.native = native
    }
    #endif

    #if canImport(UIKit)
    /// Creates a menu from a native menu item.
    ///
    /// - Parameters:
    ///     - native: The native menu item.
    public init(native: UIMenuItem) {
        self.native = native
    }
    #endif

    public init() {
        #if canImport(AppKit)
        native = NSMenuItem()
        #elseif canImport(UIKit)
        native = UIMenuItem()
        #endif
    }

    // MARK: - Properties

    #if canImport(AppKit)
    /// The native menu item.
    public let native: NSMenuItem
    #endif

    #if canImport(UIKit)
    /// The native menu item.
    public let native: UIMenuItem
    #endif
}
