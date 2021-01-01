/*
 AnyMenu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || (canImport(UIKit) && !os(tvOS) && !os(watchOS))
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow

  /// A menu with no particular localization.
  public protocol AnyMenu {

    #if canImport(AppKit)
      /// Generates an `NSMenu` instance representing the menu.
      func cocoa() -> NSMenu
    #endif

    #if canImport(UIKit)
      /// Generates a list of `UIMenuItem` instances representing the menu.
      func cocoa() -> [UIMenuItem]
    #endif
  }
#endif
