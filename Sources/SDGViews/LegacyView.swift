/*
 LegacyView.swift

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
#if canImport(UIKit)
  import UIKit
#endif

/// The subset of the `View` protocol that can be conformed to even on platform versions preceding SwiftUI’s availability.
public protocol LegacyView {

  #if canImport(AppKit)
    // @documentation(View.cocoaView)
    /// The `NSView` or `UIView`.
    ///
    /// - Warning: A `View` may not always return the same instance when queried for a `cocoaView` representation. If you want to use the view in a way that requires refrence semantics, such as applying Cocoa constraints or bindings, wrap the view in a `StabilizedView` and use it’s stable `cocoaView` property.
    var cocoaView: NSView { get }
  #endif

  #if canImport(UIKit) && !os(watchOS)
    // #documentation(View.cocoaView)
    /// The `NSView` or `UIView`.
    ///
    /// - Warning: A `View` may not always return the same instance when queried for a `cocoaView` representation. If you want to use the view in a way that requires refrence semantics, such as applying Cocoa constraints or bindings, wrap the view in a `StabilizedView` and use it’s stable `cocoaView` property.
    var cocoaView: UIView { get }
  #endif
}
