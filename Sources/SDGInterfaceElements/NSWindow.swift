/*
 NSWindow.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

import SDGControlFlow
import SDGMathematics
import SDGCollections
import SDGInterfaceLocalizations

#if !canImport(AppKit)
/// A `AppKit.NSWindow` or a `UIWindow`.
public typealias NSWindow = UIWindow
#endif

extension NSWindow {

    // MARK: - Options

    #if !canImport(AppKit)
    /// A stand‐in for AppKit’s `StyleMask`.
    public struct StyleMask : OptionSet {
        // MARK: - OptionSet
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
        public let rawValue: UInt8
    }
    #endif

    // MARK: - Fullscreen

    /// Returns whether or not the window is in fullscreen mode.
    ///
    /// For a smoother transition, the effect of setting this property may be delayed until the window is ready to switch.
    ///
    /// - Note: In a UIKit setting, all windows are always fullscreen. Attempting to set this property on a UIKit window will do nothing.
    public var isFullscreen: Bool {
        get {
            #if canImport(AppKit)
            return styleMask.contains(.fullScreen)
            #else
            return true
            #endif
        }
        set {
            #if canImport(AppKit)
            let observer = FullscreenObserver(window: self)
            observer.setFullscreenModeSettingAsSoonAsPossible(newValue)
            #endif
        }
    }

    private var nearestScreen: Screen {
        #if canImport(AppKit)
        if let theScreen = screen {
            return theScreen
        } else if let theScreen = Screen.main {
            return theScreen
        } else {
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unable to locate any screen.")
            }
            return NSScreen()
        }
        #else
        return screen
        #endif
    }

    // MARK: - Location

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

    #if canImport(AppKit)
    /// Moves the window smoothly to a specific location.
    ///
    /// - Parameters:
    ///     - position: The new position for the window.
    public func move(to position: NSRect) {
        if isVisible {
            setFrame(position, display: true, animate: true)
        } else {
            setFrame(position, display: true, animate: false)
        }
    }
    #endif

    // MARK: - NSWindow

    #if canImport(UIKit)
    // @documentation(makeKeyAndOrderFront(_:))
    /// Displays the window, moving it in front of other windows and making it the key window.
    ///
    /// - Parameters:
    ///     - sender: The message’s sender.
    public func makeKeyAndOrderFront(_ sender: Any?) { // @exempt(from: tests) UIKit raises an exception.
        makeKeyAndVisible()
    }
    #endif
}

#endif
