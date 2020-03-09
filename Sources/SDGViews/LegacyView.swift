/*
 LegacyView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGLogic

  import SDGInterfaceBasics

  /// The subset of the `View` protocol that can be conformed to even on platform versions preceding SwiftUI’s availability.
  @available(watchOS 6, *)
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

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      /// A type‐erased version of the SwiftUI view.
      ///
      /// `View`’s `swiftUIView` is preferred instead whenever possible, since the erasing of the associated type affects performance. This property exists for use cases that would be impossible with an associated type.
      @available(macOS 10.15, tvOS 13, iOS 13, *)
      var anySwiftUIView: SwiftUI.AnyView { get }
    #endif
  }

  @available(watchOS 6, *)
  extension LegacyView {

    // MARK: - Cocoa Interoperability

    /// Returns a stabilized version of the view which behaves with consistent reference semantics.
    ///
    /// Wrap unknown `View` conformers with this method before using repeated accesses of `cocoaView` that assume the same instance will be returned each time.
    @available(watchOS 6, *)
    public func stabilize() -> Stabilized<Self> {
      return Stabilized(content: self)
    }

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      @available(macOS 10.15, tvOS 13, iOS 13, *)
      public var anySwiftUIView: SwiftUI.AnyView {
        if let view = self as? ViewProtocolShims {
          return view._swiftUIImplementation
        }
        return SwiftUI.AnyView(CocoaViewRepresentableWrapper(cocoaView))
      }
    #endif

    #if !os(watchOS)
      internal func useSwiftUIOrFallback(to fallback: () -> NativeCocoaView) -> NativeCocoaView {
        #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
          if #available(macOS 10.15, tvOS 13, iOS 13, *),
            ¬legacyMode
          {
            return anySwiftUIView.cocoaView
          } else {
            return fallback()
          }
        #else
          return fallback()
        #endif
      }
    #endif

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      @available(macOS 10.15, tvOS 13, iOS 13, *)
      internal func adjustForLegacyMode() -> SwiftUI.AnyView {
        #if os(watchOS)
          return anySwiftUIView
        #else
          if legacyMode {
            return AnyCocoaView(cocoaView).anySwiftUIView
          } else {
            return anySwiftUIView
          }
        #endif
      }
    #endif

    // MARK: - Layout

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
      return Padded(content: self, edges: edges, width: width)
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
      return Proportioned(content: self, aspectRatio: aspectRatio, contentMode: contentMode)
    }

    /// A shimmed version of `SwiftUI.View.frame(minWidth:idealWidth:maxWidth:minHeight:idealHeight:maxHeight:alignment:)` with no availability constraints.
    ///
    /// - Parameters:
    ///   - minWidth: The minimum width.
    ///   - idealWidth: The ideal width.
    ///   - maxWidth: The maximum width.
    ///   - minHeight: The minimum height.
    ///   - idealHeight: The ideal height.
    ///   - maxHeight: The maximum height.
    ///   - alignment: The alignment.
    @available(watchOS 6, *)
    public func frame(
      minWidth: Double? = nil,
      idealWidth: Double? = nil,
      maxWidth: Double? = nil,
      minHeight: Double? = nil,
      idealHeight: Double? = nil,
      maxHeight: Double? = nil,
      alignment: SDGInterfaceBasics.Alignment = .centre
    ) -> Framed<Self> {
      return Framed(
        content: self,
        minWidth: minWidth,
        idealWidth: idealWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        idealHeight: idealHeight,
        maxHeight: maxHeight,
        alignment: alignment
      )
    }

    /// Letter or pillarboxes a view, locking it to an aspect ratio and filling in the empty bars along the edges with a background.
    ///
    /// The resulting view
    ///
    /// - Parameters:
    ///   - aspectRatio: The aspect ratio.
    ///   - background: The background view.
    @available(watchOS 6, *)
    public func letterboxed<Background>(
      aspectRatio: Double,
      background: Background
    ) -> Layered<Framed<Proportioned<Self>>, Background> where Background: LegacyView {
      return
        self
        .aspectRatio(aspectRatio, contentMode: .fit)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .centre)
        .background(background)
    }
  }
#endif
