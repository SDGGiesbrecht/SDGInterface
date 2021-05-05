/*
 LegacyCocoaViewImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #else
    import UIKit
  #endif

  /// The subset of the `CocoaViewImplementation` protocol that can be conformed to even on platform versions preceding SwiftUI’s availability.
  public protocol LegacyCocoaViewImplementation: LegacyView {}

  #if canImport(AppKit)
    extension LegacyCocoaViewImplementation where Self: NSView {
      public func cocoa() -> CocoaView {
        return CocoaView(self)
      }
    }
  #else
    extension LegacyCocoaViewImplementation where Self: UIView {
      public func cocoa() -> CocoaView {
        return CocoaView(self)
      }
    }
  #endif
#endif
