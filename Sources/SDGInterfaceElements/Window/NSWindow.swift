/*
 NSWindow.swift

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

import SDGControlFlow
import SDGMathematics
import SDGCollections
import SDGInterfaceLocalizations

extension NSWindow {

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

    // MARK: - NSWindow

    #if canImport(UIKit)
    /// The window’s content view.
    public var contentView: View? {
        return rootViewController?.view
    }

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
