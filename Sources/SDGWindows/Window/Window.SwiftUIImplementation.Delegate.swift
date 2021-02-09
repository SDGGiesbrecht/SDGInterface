/*
 Window.SwiftUIImplementation.Delegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit
#endif

@available(macOS 11, tvOS 14, *)
extension Window.SwiftUIImplementation {

  #if canImport(AppKit)
    class Delegate: NSObject, NSWindowDelegate {

      // MARK: - Initialization

      internal init(onClose: @escaping () -> Void) {
        self.onClose = onClose
      }

      // MARK: - Properties

      internal let onClose: () -> Void

      // MARK: - NSWindowDelegate

      func windowWillClose(_ notification: Notification) {
        DispatchQueue.main.async { [onClose = self.onClose] in
          onClose()
        }
      }
    }
  #endif
}
