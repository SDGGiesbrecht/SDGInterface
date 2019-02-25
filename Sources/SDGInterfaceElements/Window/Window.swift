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

#if canImport(AppKit)
private typealias WindowConformances = NSWindowDelegate
#else
private protocol WindowConformances {}
#endif

private var allWindows = Set<NSWindow>()
/// A window.
open class Window<L> : NSWindow, SharedValueObserver, WindowConformances where L : Localization {

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
        title: Shared<UserFacing<StrictString, L>>,
        size: CGSize,
        additionalStyles: NSWindow.StyleMask = [],
        disabledStyles: NSWindow.StyleMask = []) {

        localizedTitle = title

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
    public init(title: Shared<UserFacing<StrictString, L>>) {
        localizedTitle = title
        super.init(frame: Window.initializeContentRectangle(size: Screen.main.bounds.size))
        finishInitialization(title: title)
    }
    #endif

    private func finishInitialization(title: Shared<UserFacing<StrictString, L>>) {

        title.register(observer: self)
        LocalizationSetting.current.register(observer: self)

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

    /// The title of the window.
    public var localizedTitle: Shared<UserFacing<StrictString, L>> {
        didSet {
            oldValue.cancel(observer: self)
            localizedTitle.register(observer: self)
        }
    }

    #if canImport(AppKit)
    private let fieldEditor = FieldEditor()
    #endif

    // MARK: - NSWindow

    #if canImport(AppKit)
    private let interceptor: DelegationInterceptor
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
        Window.allWindows.remove(self)
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

    // MARK: - SharedValueObserver

    public func valueChanged(for identifier: String) {
        #if canImport(AppKit)
        title = String(localizedTitle.value.resolved())
        #endif
    }
}

#endif
