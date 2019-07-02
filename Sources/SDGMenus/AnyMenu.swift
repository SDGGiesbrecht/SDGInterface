/*
 AnyMenu.swift

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

/// A menu with no particular localization.
public protocol AnyMenu : SharedValueObserver {

    #if canImport(AppKit)
    /// The native menu.
    var native: NSMenu { get set }
    #endif

    /// The entries.
    var entries: [MenuComponent] { get set }

    func _refreshLabel()
}

extension AnyMenu {

    internal func refreshLabel() {
        _refreshLabel()
    }
}
#endif
