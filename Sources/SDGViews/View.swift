/*
 View.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #elseif canImport(UIKit)
    import UIKit
  #endif

  import SDGLogic

  import SDGInterfaceBasics

  /// A view.
  ///
  /// When conforming to `View`, it is simplest (though not necessary) for a type to either:
  ///
  /// - implement `swiftUIView` and conform to `SwiftUIViewImplementation`, or
  /// - implement `cocoaView` and conform to `CocoaViewImplementation`.
  ///
  /// In each case, default implementations will cover the rest of the conformance to `View`.
  public protocol View {

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      /// The SwiftUI view.
      @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
      var swiftUIView: SwiftUI.AnyView { get }
    #endif

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

  extension View {

    // MARK: - Aspect Ratio

    /// A shimmed version of `SwiftUI.View.aspectRatio(_:contentMode:)` with no availability constraints.
    @available(watchOS 6, *)
    public func aspectRatio(
      _ aspectRatio: Double? = nil,
      contentMode: SDGInterfaceBasics.ContentMode
    ) -> View {
      #if os(watchOS)
        return AnyView(
          swiftUIView.aspectRatio(
            aspectRatio.map({ CGFloat($0) }),
            contentMode: SwiftUI.ContentMode(contentMode)
          )
        )
      #elseif canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, iOS 13, tvOS 13, *),
          ¬legacyMode
        {
          return AnyView(
            swiftUIView.aspectRatio(
              aspectRatio.map({ CGFloat($0) }),
              contentMode: SwiftUI.ContentMode(contentMode)
            )
          )
        } else {
          return AspectRatioContainer.constraining(
            self,
            toAspectRatio: aspectRatio,
            contentMode: contentMode
          )
        }
      // @exempt(from: tests) Returned already, but the uncompiled text below confuses Xcode.
      #else
        return AspectRatioContainer.constraining(
          self,
          toAspectRatio: aspectRatio,
          contentMode: contentMode
        )
      #endif
    }
  }
#endif
