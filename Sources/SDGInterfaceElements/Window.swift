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
public class Window : NSWindow, NSWindowDelegate {

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
        size: NSSize,
        additionalStyles: NSWindow.StyleMask = [],
        disabledStyles: NSWindow.StyleMask = []) {

        interceptor = DelegationInterceptor(selectors: [])
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

    // MARK: - NSWindow

    private var interceptor: DelegationInterceptor
    public override var delegate: NSWindowDelegate? {
        get {
            return interceptor.delegate as? NSWindowDelegate
        }
        set {
            interceptor.delegate = newValue
            super.delegate = interceptor
        }
    }

    public override var title: String {
        get {
            return super.title
        }
        set {
            super.title = String(StrictString(newValue))
        }
    }

    public override func makeKeyAndOrderFront(_ sender: Any?) {
        Window.allWindows.insert(self)
        super.makeKeyAndOrderFront(sender)
    }

    public override func close() {
        Window.allWindows.remove(self)
        super.close()
    }
}
