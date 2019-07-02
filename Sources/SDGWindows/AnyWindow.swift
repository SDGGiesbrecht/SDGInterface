/*
 AnyWindow.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit))
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

import SDGMathematics
import SDGGeometry

import SDGViews

import SDGInterfaceBasics

/// A menu entry with no particular localization.
public protocol AnyWindow : AnyObject {

    /// The root view.
    var view: View { get set }

    #if canImport(AppKit)
    /// The native window.
    var native: NSWindow { get set }
    #elseif canImport(UIKit)
    /// The native window.
    var native: UIWindow { get set }
    #endif
}

extension AnyWindow {

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

    // MARK: - Display

    /// Displays the window.
    public func display() {
        #if canImport(AppKit)
        native.makeKeyAndOrderFront(nil)
        #elseif canImport(UIKit)
        native.makeKeyAndVisible()
        #endif
    }

    /// Whether or not the window is visible. (It may still be obscured by other elements on the screen.)
    public var isVisible: Bool {
        get {
            #if canImport(AppKit)
            return native.isVisible
            #elseif canImport(UIKit)
            return native.isHidden
            #endif
        }
    }

    // MARK: - Size & Location

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

    private var frame: CGRect {
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
        return native.screen.bounds
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

    // MARK: - Fullscreen

    #if canImport(AppKit)
    /// Returns whether or not the window is in fullscreen mode.
    ///
    /// For a smoother transition, the effect of setting this property may be delayed until the window is ready to switch.
    public var isFullscreen: Bool {
        get {
            return native.styleMask.contains(.fullScreen)
        }
        set {
            let observer = FullscreenObserver(window: self)
            observer.setFullscreenModeSettingAsSoonAsPossible(newValue)
        }
    }
    #endif
}
#endif
