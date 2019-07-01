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
#elseif canImport(UIKit)
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

    // MARK: - Initialization

    private static func initializeContentRectangle(size: CGSize) -> CGRect {
        var rectangle = CGRect.zero
        rectangle.size = size
        return rectangle
    }

    /// Creates a window.
    ///
    /// - Parameters:
    ///     - title: The title of the window.
    ///     - size: The size of the window.
    ///     - additionalStyles: Window styles to opt into.
    ///     - disabledStyles: Window styles to opt out of.
    public init(
        title: StrictString,
        size: CGSize,
        additionalStyles: NSWindow.StyleMask = [],
        disabledStyles: NSWindow.StyleMask = []) {

        #if canImport(AppKit)
        var style: NSWindow.StyleMask = [
            .titled,
            .closable,
            .miniaturizable,
            .resizable,
            .texturedBackground,
            .unifiedTitleAndToolbar
        ]
        style.formUnion(additionalStyles)
        style.subtract(disabledStyles)
        #endif

        #if canImport(AppKit)
        super.init(
            contentRect: AbstractWindow.initializeContentRectangle(size: size),
            styleMask: style,
            backing: .buffered,
            defer: true)
        #else
        super.init(frame: AbstractWindow.initializeContentRectangle(size: size))
        #endif

        finishInitialization()
    }

    #if canImport(UIKit)
    /// Creates a window.
    ///
    /// - Parameters:
    ///     - title: The title of the window.
    public init(title: StrictString) {
        super.init(frame: AbstractWindow.initializeContentRectangle(size: Screen.main.bounds.size))
        finishInitialization()
    }
    #endif

    private func finishInitialization() {

        #if canImport(AppKit)
        interceptor.delegate = super.delegate
        interceptor.listener = self
        #endif

        #if canImport(AppKit)
        isReleasedWhenClosed = false
        #endif

        #if canImport(AppKit)
        titleVisibility = .hidden
        #endif

        #if canImport(AppKit)
        setAutorecalculatesContentBorderThickness(false, for: NSRectEdge.minY)
        setContentBorderThickness(0, for: NSRectEdge.minY)
        #endif

        #if canImport(UIKit)
        if rootViewController == nil {
            rootViewController = UIViewController()
        }
        #endif

        randomizeLocation()
    }

    #if canImport(UIKit)
    @available(*, unavailable) public required init(coder decoder: NSCoder) { // @exempt(from: unicode)
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "UserOwnedWindow"
            }
        }))
        preconditionFailure()
    }
    #endif

    // MARK: - Properties

    #if canImport(AppKit)
    private let fieldEditor = FieldEditor()
    #endif

    // MARK: - NSWindow

    #if canImport(AppKit)
    private let interceptor = DelegationInterceptor(selectors: [
        #selector(NSWindowDelegate.windowWillReturnFieldEditor(_:to:))
        ])
    open override var delegate: NSWindowDelegate? {
        get {
            return interceptor.delegate as? NSWindowDelegate
        }
        set {
            interceptor.delegate = newValue
            super.delegate = interceptor
        }
    }
    #endif

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
