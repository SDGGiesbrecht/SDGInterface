/*
 AbstractWindow.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)

#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

import SDGText
import SDGLocalization

import SDGInterfaceLocalizations

#if canImport(AppKit)
private typealias WindowConformances = NSWindowDelegate
#else
private protocol WindowConformances {}
#endif

internal var allWindows = Set<AbstractWindow>()
/// A superclass of `Window` providing all of the non‐generic functionality.
///
/// This superclass can be referenced in order to use functionality common to all `Window` instances regardless of their generic arguments.
open class AbstractWindow : NSWindow, WindowConformances {

    // MARK: - Properties

    #if canImport(AppKit)
    private let fieldEditor = FieldEditor()
    #endif

    // MARK: - NSWindow

    #if canImport(AppKit)
    open override func makeKeyAndOrderFront(_ sender: Any?) {
        allWindows.insert(self)
        super.makeKeyAndOrderFront(sender)
    }
    #else
    open override func makeKeyAndVisible() { // @exempt(from: tests) Causes exception during tests.
        allWindows.insert(self)
        super.makeKeyAndVisible()
    }
    #endif

    #if canImport(AppKit)
    open override func close() {
        allWindows.remove(self)
        super.close()
    }
    #else
    /// Closes the window, allowing it to be deallocated.
    open func close() {
        allWindows.remove(self)
    }
    #endif

    #if canImport(AppKit)
    // MARK: - NSWindowDelegate

    /// Determines the window’s field editor.
    ///
    /// - Parameters:
    ///     - sender: The window requesting the field editor.
    ///     - client: A text‐displaying object to be associated with the field editor.
    public func windowWillReturnFieldEditor(_ sender: NSWindow, to client: Any?) -> Any? {
        return (interceptor.delegate as? NSWindowDelegate)?.windowWillReturnFieldEditor?(sender, to: client) ?? fieldEditor
    }
    #endif
}
#endif
