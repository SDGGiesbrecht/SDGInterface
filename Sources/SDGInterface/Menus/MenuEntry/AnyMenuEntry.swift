/*
 AnyMenuEntry.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow

  /// A menu entry with no particular localization.
  public protocol AnyMenuEntry {

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      #warning("Make generic?")
      /// Constructs a type‐erased SwiftUI view.
      @available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
      func swiftUIAnyView() -> SwiftUI.AnyView
    #endif

    #if canImport(AppKit)
      /// Contsructs a Cocoa menu item.
      func cocoa() -> NSMenuItem
    #elseif canImport(UIKit) && !os(tvOS) && !os(watchOS)
      /// Contsructs a Cocoa menu item.
      func cocoa() -> UIMenuItem
    #endif
  }
#endif
