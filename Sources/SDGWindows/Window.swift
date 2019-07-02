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

import SDGGeometry
import SDGViews

/// A window.
public final class Window {

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
        native.isReleasedWhenClosed = false
        #endif

        #if canImport(AppKit)
        native.titleVisibility = .hidden
        native.setAutorecalculatesContentBorderThickness(false, for: NSRectEdge.minY)
        native.setContentBorderThickness(0, for: NSRectEdge.minY)
        #endif

        self.view = view
        viewDidSet()
    }

    // MARK: - Properties

    #if canImport(AppKit)
    /// The native window.
    public var native: NSWindow
    #elseif canImport(UIKit)
    /// The native window.
    public var native: UIWindow
    #endif

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

    // MARK: - Computed Properties

    /// The size of the window.
    ///
    /// Changing this value when the window is visible results in a smooth animation.
    public var size: Size {
        get {
            return Size(frame.size)
        }
        set {
            frame.size = newValue.native
        }
    }

    // MARK: - Location

    /// The location of the window.
    ///
    /// Changing this value when the window is visible results in a smooth animation.
    public var location: TwoDimensionalPoint<Double> {
        get {
            return TwoDimensionalPoint(frame.size)
        }
        set {
            frame.size = newValue.native
        }
    }

    #if canImport(AppKit) || canImport(UIKit)
    private var frame: NSRect {
        get {
            return native.frame
        }
        set {
            #if canImport(AppKit)
            if native.isVisible {
                native.setFrame(newValue, display: true, animate: true)
            } else {
                native.setFrame(newValue, display: true, animate: false)
            }
            #elseif canImport(UIKit)
            native.frame = newValue
            #endif
        }
    }
    #endif

    /// Moves the window smoothly to the centre of the screen.
    public func centreInScreen() {
        #if canImport(AppKit)
        var windowRect = frame
        let screenRect = nearestScreen.frame

        windowRect.origin.x = ((screenRect.size.width − windowRect.size.width) ÷ 2)
        windowRect.origin.y = ((screenRect.size.height − windowRect.size.height) × 2 ÷ 3)

        move(to: windowRect)
        #else
        frame = nearestScreen.bounds
        #endif
    }

    /// Moves the window smoothly to a random location on the screen.
    ///
    /// - Note: In a UIKit setting, windows always fill the entire screen.
    public func randomizeLocation() {
        #if canImport(AppKit)
        var windowRect = frame
        let screenRect = nearestScreen.frame

        var rangeX = screenRect.size.width − windowRect.size.width
        rangeX.increase(to: 0)
        var rangeY = screenRect.size.height − windowRect.size.height
        rangeY.increase(to: 0)

        windowRect.origin.x = CGFloat.random(in: 0 ... rangeX)
        windowRect.origin.y = CGFloat.random(in: 0 ... rangeY)

        move(to: windowRect)
        #else
        frame = nearestScreen.bounds
        #endif
    }
}
#endif
