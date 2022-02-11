/*
 Window.SwiftUIImplementation.Delegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  @available(macOS 11, tvOS 13, iOS 13, watchOS 6, *)
  extension Window.SwiftUIImplementation {

    internal class Delegate: NSObject, NSWindowDelegate {

      // MARK: - Initialization

      internal init(onClose: @escaping () -> Void) {
        self.onClose = onClose
      }

      // MARK: - Properties

      internal let onClose: () -> Void

      // MARK: - NSWindowDelegate

      internal func windowWillClose(_ notification: Notification) {
        // @exempt(from: tests) Unreachable in tests.
        DispatchQueue.main.async { [onClose = self.onClose] in
          onClose()
        }
      }
    }
  }
#endif
