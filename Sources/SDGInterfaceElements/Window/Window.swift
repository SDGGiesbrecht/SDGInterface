/*
 Window.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

import SDGInterfaceLocalizations

/// A window.
open class Window : NSWindow {

    // MARK: - Static Variables

    private static var allWindows = Set<Window>()

    // MARK: - Initialization

    private static func initializeInterceptor() -> DelegationInterceptor {
        return DelegationInterceptor(selectors: [
            #selector(NSWindowDelegate.windowWillReturnFieldEditor(_:to:))
            ])
    }

    private static func initializeContentRectangle(size: NSSize) -> NSRect {
        var rectangle = CGRect.zero
        rectangle.size = size
        return rectangle
    }

    private static func initializeStyleMask(additionalStyles: NSWindow.StyleMask, disabledStyles: NSWindow.StyleMask) -> NSWindow.StyleMask {
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
        return style
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
        interceptor = Window.initializeInterceptor()
        #endif

        #if canImport(AppKit)
        super.init(
            contentRect: Window.initializeContentRectangle(size: size),
            styleMask: Window.initializeStyleMask(additionalStyles: additionalStyles, disabledStyles: disabledStyles),
            backing: .buffered,
            defer: true)
        #else
        _title = String(title)
        super.init(frame: Window.initializeContentRectangle(size: size))
        #endif

        finishInitialization(title: title)
    }

    #if canImport(UIKit)
    /// Creates a window.
    ///
    /// - Parameters:
    ///     - title: The title of the window.
    public init(title: StrictString) {
        super.init(frame: Window.initializeContentRectangle(size: Screen.main.bounds.size))
        finishInitialization(title: title)
    }
    #endif

    private func finishInitialization(title: StrictString) {
        #if canImport(AppKit)
        interceptor.delegate = super.delegate
        interceptor.listener = self
        #endif

        #if canImport(AppKit)
        isReleasedWhenClosed = false
        #endif

        #if canImport(AppKit)
        super.title = String(title)
        titleVisibility = .hidden
        #endif

        #if canImport(AppKit)
        setAutorecalculatesContentBorderThickness(false, for: NSRectEdge.minY)
        setContentBorderThickness(0, for: NSRectEdge.minY)
        #endif

        randomizeLocation()
    }

    #if canImport(UIKit)
    @available(*, unavailable) public required init(coder decoder: NSCoder) { // @exempt(from: unicode)
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Window"
            }
        }))
    }
    #endif

    // MARK: - Properties

    #if canImport(AppKit)
    private var fieldEditor = FieldEditor()
    #endif

    // MARK: - NSWindow

    #if canImport(AppKit)
    private var interceptor: DelegationInterceptor
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
    open override var title: String {
        get {
            return super.title
        }
        set {
            super.title = String(StrictString(newValue))
        }
    }
    #else
    private var _title: String
    /// The title of the window.
    open var title: String {
        get {
            return _title
        }
        set {
            _title = String(StrictString(newValue))
        }
    }
    #endif

    #if canImport(AppKit)
    open override func makeKeyAndOrderFront(_ sender: Any?) {
        Window.allWindows.insert(self)
        super.makeKeyAndOrderFront(sender)
    }
    #else
    open override func makeKeyAndVisible() { // @exempt(from: tests) Causes exception during tests.
        Window.allWindows.insert(self)
        super.makeKeyAndVisible()
    }
    #endif

    #if canImport(AppKit)
    open override func close() {
        Window.allWindows.remove(self)
        super.close()
    }
    #else
    /// Closes the window, allowing it to be deallocated.
    open func close() {
        Window.allWindows.remove(self)
    }
    #endif
}

#if canImport(AppKit)
extension Window : NSWindowDelegate {

    /// Determines the window’s field editor.
    ///
    /// - Parameters:
    ///     - sender: The window requesting the field editor.
    ///     - client: A text‐displaying object to be associated with the field editor.
    public func windowWillReturnFieldEditor(_ sender: NSWindow, to client: Any?) -> Any? {
        return (interceptor.delegate as? NSWindowDelegate)?.windowWillReturnFieldEditor?(sender, to: client) ?? fieldEditor
    }
}
#endif

#endif
