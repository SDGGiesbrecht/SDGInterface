/*
 FullscreenObserver.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)

import Dispatch

import SDGLogic

internal class FullscreenObserver {

    // MARK: - Initialization

    internal init(window: NSWindow) {
        self.window = window
    }

    // MARK: - Properties

    private weak var window: NSWindow?

    // MARK: - Fullscreen

    internal func setFullscreenModeSettingAsSoonAsPossible(_ setting: Bool) {
        if window?.isFullscreen ≠ setting {
            if window?.isVisible == true {
                setFullscreenMode(setting: setting)
            } else {
                DispatchQueue.global(qos: .userInitiated).async {
                    while DispatchQueue.main.sync(execute: { self.window ≠ nil ∧ self.window?.isVisible ≠ true }) { // @exempt(from: tests)
                        Thread.sleep(forTimeInterval: 0.1)
                    }
                    DispatchQueue.main.async {
                        self.setFullscreenMode(setting: setting)
                    }
                }
            }
        }
    }

    private func setFullscreenMode(setting: Bool) {
        if self.window?.isFullscreen ≠ setting {
            self.window?.toggleFullScreen(self)
        }
    }
}

#endif
