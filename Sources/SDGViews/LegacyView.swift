/*
 LegacyView.swift

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

  import SDGInterfaceBasics

  /// The subset of the `View` protocol that can be conformed to even on platform versions preceding SwiftUI’s availability.
  public protocol LegacyView {

    #if canImport(AppKit)
      // @documentation(View.cocoaView)
      /// The `NSView` or `UIView`.
      ///
      /// - Warning: A `View` may not always return the same instance when queried for a `cocoaView` representation. If you want to use the view in a way that requires refrence semantics, such as applying Cocoa constraints or bindings, wrap the view in a `StabilizedView` and use it’s stable `cocoaView` property.
      var cocoaView: NSView { get }
    #elseif canImport(UIKit) && !os(watchOS)
      // #documentation(View.cocoaView)
      /// The `NSView` or `UIView`.
      ///
      /// - Warning: A `View` may not always return the same instance when queried for a `cocoaView` representation. If you want to use the view in a way that requires refrence semantics, such as applying Cocoa constraints or bindings, wrap the view in a `StabilizedView` and use it’s stable `cocoaView` property.
      var cocoaView: UIView { get }
    #endif
  }

  extension LegacyView {

    /// A shimmed version of `SwiftUI.View.padding(_:_:)` with no availability constraints.
    ///
    /// - Parameters:
    ///   - edges: The edges along which to apply the padding.
    ///   - width: The width of the padding.
    @available(watchOS 6, *)
    public func padding(
      _ edges: SDGInterfaceBasics.Edge.Set = .all,
      _ width: Double? = nil
    ) -> Padded<Self> {
      return Padded(contents: self, edges: edges, width: width)
    }

    /// A shimmed version of `SwiftUI.View.background(_:alignment:)` with no availability constraints.
    ///
    /// - Parameters:
    ///   - background: The background view.
    ///   - alignment: The alignment of the background.
    @available(watchOS 6, *)
    public func background<Background>(
      _ background: Background,
      alignment: SDGInterfaceBasics.Alignment = .centre
    ) -> Layered<Self, Background> {
      return Layered(foreground: self, background: background, alignment: alignment)
    }

    /// A shimmed version of `SwiftUI.View.aspectRatio(_:contentMode:)` with no availability constraints.
    ///
    /// - Parameters:
    ///   - aspectRatio: The aspect ratio. Pass `nil` to use the aspect ratio of the view’s intrinsic size. Views with no intrinsic size will be unaffected by this method if no aspect ratio is specified.
    ///   - contentMode: The content mode. `.fit` performs letterboxing or pillarboxing; `.fill` crops the view to achieve the aspect ratio.
    @available(watchOS 6, *)
    public func aspectRatio(
      _ aspectRatio: Double? = nil,
      contentMode: SDGInterfaceBasics.ContentMode
    ) -> Proportioned<Self> {
      return Proportioned(contents: self, aspectRatio: aspectRatio, contentMode: contentMode)
    }
  }
#endif
