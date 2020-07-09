/*
 Size.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit
#endif

import SDGInterfaceBasics

extension Size {

  /// A size that fills the available space on the main screen, without obscuring menu bars, docks, etc.
  public static func fillingAvailable() -> Size {
    #if canImport(AppKit)
      return Size(
        (NSScreen.main
          ?? NSScreen()  // @exempt(from: tests) Screen should not be nil.
          ).frame.size
      )
    #elseif canImport(UIKit)
      return Size(UIScreen.main.bounds.size)
    #endif
  }

  #if canImport(AppKit)
    /// The default size of an auxiliary window.
    public static var auxiliaryWindow: Size {
      return Size(width: 480, height: 270)
    }
  #endif
}