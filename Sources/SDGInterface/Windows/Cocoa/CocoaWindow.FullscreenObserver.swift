/*
 CocoaWindow.FullscreenObserver.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import Dispatch
  import AppKit

  import SDGLogic

  extension CocoaWindow {

    internal class FullscreenObserver {

      // MARK: - Initialization

      internal init(window: CocoaWindow) {
        self.nativeWindow = window.native
      }

      // MARK: - Properties

      private weak var nativeWindow: CocoaWindow.NativeType?
      private var window: CocoaWindow? {
        return nativeWindow.map({ CocoaWindow($0) })
      }

      // MARK: - Fullscreen

      internal func setFullscreenModeSettingAsSoonAsPossible(_ setting: Bool) {
        if window?.isFullscreen ≠ setting {
          if window?.isVisible == true {
            setFullscreenMode(setting: setting)
          } else {
            DispatchQueue.global(qos: .userInitiated).async {
              while DispatchQueue.main.sync(execute: {
                self.window ≠ nil ∧ self.window?.isVisible ≠ true
              }) {
                Thread.sleep(forTimeInterval: 0.1)  // @exempt(from: tests)
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
          self.window?.native.toggleFullScreen(self)
        }
      }
    }
  }
#endif
