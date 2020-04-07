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
  import SDGText
  import SDGLocalization

  import SDGInterfaceBasics

  import SDGInterfaceLocalizations

  /// The subset of the `View` protocol that can be conformed to even on platform versions preceding SwiftUI’s availability.
  ///
  /// - Important: On watchOS, every `LegacyView` must also conform to `View`.
  @available(watchOS 6, *)
  public protocol LegacyView {

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      /// Constructs a Cocoa representation of the view.
      ///
      /// - Warning: This method may not return the same instance each time it is called. If you want to use the view in a way that requires consistent refrence semantics—such as applying Cocoa constraints or bindings—call this method only once and store the result for re‐use.
      func cocoa() -> CocoaView
    #endif

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      /// A type‐erased version of the SwiftUI view.
      ///
      /// `View`’s `swiftUI()` is preferred instead whenever possible, since the erasing of the associated type affects performance. This method exists for use cases that would be impossible with an associated type.
      @available(macOS 10.15, tvOS 13, iOS 13, *)
      func swiftUIAnyView() -> SwiftUI.AnyView
    #endif
  }

  @available(watchOS 6, *)
  extension LegacyView {

    // MARK: - Cocoa Interoperability

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      @available(macOS 10.15, tvOS 13, iOS 13, *)
      public func swiftUIAnyView() -> SwiftUI.AnyView {
        if let view = self as? ViewShims {
          return view._swiftUIImplementation()
        }
        #if os(watchOS)
          preconditionFailure(
            UserFacing<StrictString, APILocalization>({ localization in
              switch localization {
              case .englishCanada:
                return "On watchOS, every “LegacyView” must also conform to “View”."
              }
            })
          )
        #else
          return SwiftUI.AnyView(CocoaViewRepresentableWrapper(cocoa()))
        #endif
      }
    #endif

    #if !os(watchOS)
      internal func useSwiftUIOrFallback(to fallback: () -> CocoaView) -> CocoaView {
        #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
          if #available(macOS 10.15, tvOS 13, iOS 13, *),
            ¬legacyMode
          {
            return swiftUIAnyView().cocoa()
          } else {
            return fallback()
          }
        #else  // @exempt(from: tests) watchOS
          return fallback()
        #endif
      }
    #endif

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      @available(macOS 10.15, tvOS 13, iOS 13, *)
      internal func adjustForLegacyMode() -> SwiftUI.AnyView {
        #if os(watchOS)
          return swiftUIAnyView()
        #else
          if legacyMode {
            return cocoa().swiftUIAnyView()
          } else {
            return swiftUIAnyView()
          }
        #endif  // @exempt(from: tests)
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
    public func letterbox<Background>(
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