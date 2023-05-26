/*
 ManagedWindow.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(AppKit)
    import AppKit
  #endif

  internal var allWindows = [ObjectIdentifier: CocoaWindow.NativeType]()

  internal protocol ManagedWindow: AnyObject {
    var onClose: () -> Void { get }
  }

  extension ManagedWindow {

    internal func finishClosing() {
      // Release
      allWindows[ObjectIdentifier(self)] = nil

      onClose()
    }
  }
#endif
