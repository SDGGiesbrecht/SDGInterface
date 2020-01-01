/*
 NSWindowDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  internal final class NSWindowDelegate: NSObject, AppKit.NSWindowDelegate {

    // MARK: - Properties

    internal weak var window: AnyWindow?

    // MARK: - NSWindowDelegate

    internal func windowWillReturnFieldEditor(_ sender: NSWindow, to client: Any?) -> Any? {
      return window?._fieldEditor
    }

    internal func windowWillClose(_ notification: Notification) {
      window?.finishClosing()
    }
  }
#endif
