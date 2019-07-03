/*
 Window.swift

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

import SDGLogic
import SDGText
import SDGLocalization

import SDGInterfaceBasics
import SDGViews

#if canImport(AppKit)
public var _getFieldEditor: () -> NSTextView = {
    return NSTextView()
}
#endif

/// A window.
public final class Window<L> : AnyWindow where L : Localization {

    // MARK: - Generators

    /// Creates a primary window.
    ///
    /// - Parameters:
    ///     - name: The name of the window. (Used in places like the title bar or dock.)
    ///     - view: The view.
    public static func primaryWindow(name: Binding<StrictString, L>, view: View) -> Window {
        let window = Window(name: name, view: view)
        window.size = availableSize
        #if canImport(AppKit)
        window.isPrimary = true
        #endif
        return window
    }

    #if canImport(AppKit)
    /// Creates an auxiliary window.
    ///
    /// - Parameters:
    ///     - name: The name of the window. (Used in places like the title bar or dock.)
    ///     - view: The view.
    public static func auxiliaryWindow(name: Binding<StrictString, L>, view: View) -> Window {
        let window = Window(name: name, view: view)
        window.size = auxiliarySize
        window.isAuxiliary = true
        return window
    }

    /// Creates a fullscreen window.
    ///
    /// - Parameters:
    ///     - name: The name of the window. (Used in places like the title bar or dock.)
    ///     - view: The view.
    public static func fullscreenWindow(name: Binding<StrictString, L>, view: View) -> Window {
        let window = primaryWindow(name: name, view: view)
        window.isFullscreen = true
        return window
    }
    #endif

    // MARK: - Initialization

    /// Creates a window.
    ///
    /// - Parameters:
    ///     - name: The name of the window. (Used in places like the title bar or dock.)
    ///     - view: The view.
    public init(name: Binding<StrictString, L>, view: View) {
        defer {
            randomizeLocation()
        }

        self.name = name
        defer {
            nameDidSet()
            LocalizationSetting.current.register(observer: bindingObserver)
        }

        self.view = view
        defer {
            viewDidSet()
        }

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

        defer {
            bindingObserver.window = self
        }

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
    }

    // MARK: - Properties

    private let bindingObserver = BindingObserver()

    public var name: Binding<StrictString, L> {
        willSet {
            name.shared?.cancel(observer: bindingObserver)
        }
        didSet {
            nameDidSet()
        }
    }
    private func nameDidSet() {
        name.shared?.register(observer: bindingObserver)
    }

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

    #if canImport(AppKit)
    /// The native window.
    public var native: NSWindow
    private let delegate = NSWindowDelegate()
    public var _fieldEditor = _getFieldEditor()
    #elseif canImport(UIKit)
    /// The native window.
    public var native: UIWindow
    #endif

    // MARK: - Refreshing

    public func _refreshBindings() {
        #if canImport(AppKit)
        native.title = String(name.resolved())
        #endif
    }
}
#endif
