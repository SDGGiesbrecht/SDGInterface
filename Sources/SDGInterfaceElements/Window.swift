/*
 Window.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A window.
open class Window : NSWindow {

    // MARK: - Static Variables

    private static var allWindows = Set<Window>()

    // MARK: - Initialization

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

        interceptor = DelegationInterceptor(selectors: [
            #selector(NSWindowDelegate.windowWillReturnFieldEditor(_:to:))
            ])
        defer {
            interceptor.delegate = super.delegate
            interceptor.listener = self
        }

        var rectangle = NSRect.zero
        rectangle.size = size

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

        super.init(
            contentRect: rectangle,
            styleMask: style,
            backing: .buffered,
            defer: true)

        isReleasedWhenClosed = false

        super.title = String(title)
        titleVisibility = .hidden

        setAutorecalculatesContentBorderThickness(false, for: NSRectEdge.minY)
        setContentBorderThickness(0, for: NSRectEdge.minY)

        randomizeLocation()
    }

    // MARK: - Properties

    // #workaround(Should be a field editor.)
    private var fieldEditor = NSTextView()

    // MARK: - NSWindow

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

    open override var title: String {
        get {
            return super.title
        }
        set {
            super.title = String(StrictString(newValue))
        }
    }

    open override func makeKeyAndOrderFront(_ sender: Any?) {
        Window.allWindows.insert(self)
        super.makeKeyAndOrderFront(sender)
    }

    open override func close() {
        Window.allWindows.remove(self)
        super.close()
    }
}

#if canImport(AppKit)
extension Window : NSWindowDelegate {

    public func windowWillReturnFieldEditor(_ sender: NSWindow, to client: Any?) -> Any? {
        return (interceptor.delegate as? NSWindowDelegate)?.windowWillReturnFieldEditor?(sender, to: client) ?? fieldEditor
    }
}
#endif
