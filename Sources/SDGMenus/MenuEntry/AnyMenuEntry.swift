/*
 AnyMenuEntry.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(tvOS) && !os(watchOS)
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow

  /// A menu entry with no particular localization.
  public protocol AnyMenuEntry {

    #if canImport(AppKit)
      /// Contsructs a Cocoa menu item.
      func cocoa() -> NSMenuItem
    #elseif canImport(UIKit)
      /// Contsructs a Cocoa menu item.
      func cocoa() -> UIMenuItem
    #endif
  }
#endif
