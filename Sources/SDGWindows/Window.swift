/*
 Window.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || canImport(UIKit)
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

import SDGViews

#if canImport(AppKit)
#warning("Handle field editor.")
public var _getFieldEditor: () -> NSTextView = { return NSTextView() }
#endif

/// A window.
public final class Window : AnyWindow {

    /// Creates a window.
    ///
    /// - Parameters:
    ///     - view: The view.
    ///     - size: The default size for the window.
    public init(view: View) {

        #if canImport(AppKit)
        native = NSWindow(
            contentRect: NSRect.zero,
            styleMask: [
                .titled,
                .closable,
                .miniaturizable,
                .resizable,
                .texturedBackground,
                .unifiedTitleAndToolbar
            ],
            backing: .buffered,
            defer: true)
        #elseif canImport(UIKit)
        native = UIWindow(frame: CGRect.zero)
        #endif

        #if canImport(AppKit)
        defer {
            native.delegate = delegate
            delegate.window = self
        }
        #endif

        #if canImport(AppKit)
        native.isReleasedWhenClosed = false
        #endif

        #if canImport(AppKit)
        native.titleVisibility = .hidden
        native.setAutorecalculatesContentBorderThickness(false, for: NSRectEdge.minY)
        native.setContentBorderThickness(0, for: NSRectEdge.minY)
        #endif

        self.view = view
        viewDidSet()

        randomizeLocation()
    }

    // MARK: - Properties

    #if canImport(AppKit)
    /// The native window.
    public var native: NSWindow
    private let delegate = NSWindowDelegate()
    public let _fieldEditor = _getFieldEditor()
    #elseif canImport(UIKit)
    /// The native window.
    public var native: UIWindow
    #endif

    /// The root view.
    public var view: View {
        didSet {
            viewDidSet()
        }
    }
    private func viewDidSet() {
        #if canImport(AppKit)
        native.contentView = view.native
        #elseif canImport(UIKit)
        if native.rootViewController == nil {
            native.rootViewController = UIViewController()
        }
        native.rootViewController?.view = view.native
        #endif
    }
}
#endif
