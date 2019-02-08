/*
 NSWindow.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics
import SDGCollections
import SDGInterfaceLocalizations

extension NSWindow {

    // MARK: - Fullscreen

    /// Returns whether or not the window is in fullscreen mode.
    ///
    /// For a smoother transition, the effect of setting this property may be delayed until the window is ready to switch.
    public var fullscreen: Bool {
        get {
            return styleMask.contains(.fullScreen)
        }
        set {
            let observer = FullscreenObserver(window: self)
            observer.setFullscreenModeSettingAsSoonAsPossible(newValue)
        }
    }

    private var nearestScreen: NSScreen {
        if let theScreen = screen {
            return theScreen
        } else if let theScreen = NSScreen.main {
            return theScreen
        } else { // @exempt(from: tests)
            if BuildConfiguration.current == .debug {
                print("Unable to locate any screen.")
            }
            return NSScreen()
        }
    }

    // MARK: - Location

    /// Moves the window to the centre of the screen.
    public func centreInScreen() {
        var windowRect = frame
        let screenRect = nearestScreen.frame

        windowRect.origin.x = ((screenRect.size.width − windowRect.size.width) ÷ 2)
        windowRect.origin.y = ((screenRect.size.height − windowRect.size.height) × 2 ÷ 3)

        move(to: windowRect)
    }

    /// Moves the window to a random location on the screen.
    public func randomizeLocation() {
        var windowRect = frame
        let screenRect = nearestScreen.frame

        var rangeX = screenRect.size.width − windowRect.size.width
        rangeX.increase(to: 0)
        var rangeY = screenRect.size.height − windowRect.size.height
        rangeY.increase(to: 0)

        windowRect.origin.x = CGFloat.random(in: 0 ... rangeX)
        windowRect.origin.y = CGFloat.random(in: 0 ... rangeY)

        move(to: windowRect)
    }

    /// Moves the window to a specific location.
    public func move(to position: NSRect) {
        if isVisible {
            setFrame(position, display: true, animate: true)
        } else {
            setFrame(position, display: true, animate: false)
        }
    }
}
