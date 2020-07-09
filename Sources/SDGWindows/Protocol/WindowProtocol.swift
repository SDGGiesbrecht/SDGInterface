/*
 WindowProtocol.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  /// A window.
  public protocol WindowProtocol {

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      /// Constructs a Cocoa representation of the window.
      ///
      /// - Warning: This method may not return the same instance each time it is called. If you want to use the window in a way that requires consistent refrence semantics, call this method only once and store the result for re‐use.
      func cocoa() -> CocoaWindow
    #endif
  }

#endif
