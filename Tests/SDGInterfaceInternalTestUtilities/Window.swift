/*
 Window.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@testable import SDGInterface

#if PLATFORM_HAS_COCOA_INTERFACE
  public func forEachWindow(_ closure: (CocoaWindow) -> Void) {
    for window in Array(allWindows.values) {
      closure(CocoaWindow(window))
    }
  }
#endif
