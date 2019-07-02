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

import SDGMathematics
import SDGGeometry

import SDGInterfaceBasics
import SDGViews

/// A window.
public final class Window {

    // MARK: - Static Properties

    /// A size that fills the available space on the main screen, without obscuring menu bars, docks, etc.
    public static var availableSize: Size {
        #if canImport(AppKit)
        return Size((NSScreen.main ?? NSScreen()).frame.size)
        #elseif canImport(UIKit)
        return Size(UIScreen.main.bounds.size)
        #endif
    }

    #if canImport(AppKit)
    /// The default size of an auxiliary window.
    public static var auxiliarySize: Size {
        return Size(width: 480, height: 270)
    }
    #endif

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

    /// The location of the window’s origin.
    ///
    /// Changing this value when the window is visible results in a smooth animation.
    public var location: TwoDimensionalPoint<Double> {
        get {
            return TwoDimensionalPoint(frame.origin)
        }
        set {
            frame.origin = newValue.native
        }
    }

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

    private var nearestScreenFrame: CGRect {
        #if canImport(AppKit)
        let screen: NSScreen
        if let theScreen = native.screen {
            screen = theScreen
        } else if let theScreen = NSScreen.main {
            screen = theScreen
        } else { // @exempt(from: tests)
            screen = NSScreen()
        }
        return screen.frame
        #elseif canImport(UIKit)
        return native.screen.frame
        #endif
    }

    /// Moves the window smoothly to the centre of the screen.
    public func centreInScreen() {
        var windowFrame = frame
        let screenFrame = nearestScreenFrame

        windowFrame.origin.x = ((screenFrame.size.width − windowFrame.size.width) ÷ 2)
        windowFrame.origin.y = ((screenFrame.size.height − windowFrame.size.height) × 2 ÷ 3)

        frame = windowFrame
    }

    /// Moves the window smoothly to a random location on the screen.
    public func randomizeLocation() {
        var windowFrame = frame
        let screenFrame = nearestScreenFrame

        var rangeX = screenFrame.size.width − windowFrame.size.width
        rangeX.increase(to: 0)
        var rangeY = screenFrame.size.height − windowFrame.size.height
        rangeY.increase(to: 0)

        windowFrame.origin.x = CGFloat.random(in: 0 ... rangeX)
        windowFrame.origin.y = CGFloat.random(in: 0 ... rangeY)

        frame = windowFrame
    }
}
#endif
