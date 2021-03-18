/*
 LegacyView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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
import SDGLogic
import SDGText
import SDGLocalization

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
    /// Constructs a Cocoa view, preferring to use SwiftUI for the implementation.
    ///
    /// - Important: This method should only be used on a view within its own `cocoa()` method. The view must also provide an independent implementation of `swiftUI()`.
    ///
    /// This convenience method is intended to aid in conforming to `View`. By wrapping the implementation of the `cocoa()` method in this, the implementation can be diverted to SwiftUI wherever it is available.
    ///
    /// - On platform versions which have SwiftUI, this method wraps the `swiftUI()` view in a Cocoa view and returns it.
    /// - On platform versions which do not have SwiftUI, the fallback implementation will be used instead.
    ///
    /// - Parameters:
    ///   - fallback: A closure which constructs the fallback Cocoa view. It will be called if SwiftUI is unavailable.
    ///   - useFallbackRegardless: Pass `true` to force the fallback to be called regardless of whether SwiftUI is available. This is useful as a means to call the fallback implementation out from underneath SwiftUI during testing.
    public func useSwiftUIOrFallback(
      to fallback: () -> CocoaView,
      useFallbackRegardless: Bool = false
    ) -> CocoaView {
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, *),
          ¬useFallbackRegardless
        {
          return swiftUIAnyView().cocoa()
        } else {
          return fallback()
        }
      #else  // @exempt(from: tests) watchOS
        return fallback()
      #endif
    }

    internal func useSwiftUIOrFallback(to fallback: () -> CocoaView) -> CocoaView {
      return useSwiftUIOrFallback(to: fallback, useFallbackRegardless: legacyMode)
    }

    /// Constructs a Cocoa view, preferring to use SwiftUI 2 for the implementation.
    ///
    /// - Important: This method should only be used on a view within its own `cocoa()` method. The view must also provide an independent implementation of `swiftUI()`.
    ///
    /// This convenience method is intended to aid in conforming to `View`. By wrapping the implementation of the `cocoa()` method in this, the implementation can be diverted to SwiftUI 2 wherever it is available.
    ///
    /// - On platform versions which have SwiftUI 2, this method wraps the `swiftUI()` view in a Cocoa view and returns it.
    /// - On platform versions which do not have SwiftUI 2, the fallback implementation will be used instead.
    ///
    /// - Parameters:
    ///   - fallback: A closure which constructs the fallback Cocoa view. It will be called if SwiftUI 2 is unavailable.
    ///   - useFallbackRegardless: Pass `true` to force the fallback to be called regardless of whether SwiftUI is available. This is useful as a means to call the fallback implementation out from underneath SwiftUI 2 during testing.
    public func useSwiftUI2OrFallback(
      to fallback: () -> CocoaView,
      useFallbackRegardless: Bool = false
    ) -> CocoaView {
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 11, tvOS 14, iOS 14, watchOS 7, *),
          ¬useFallbackRegardless
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
    /// Returns a resolved SwiftUI view, redirecting through the Cocoa implementation if requested.
    ///
    /// The method is intended for use during testing and previewing as a means to call fallback implementations out from underneath SwiftUI.
    ///
    /// - Warning: Do not call this method on a view you do not own. Doing so is likely to circumvent the view’s intended behaviour.
    ///
    /// A request to divert through Cocoa will simply be ignored on platforms where Cocoa is not available.
    ///
    /// - SeeAlso: useSwiftUIOrFallback(to:useFallbackRegardless:)
    ///
    /// - Parameters:
    ///   - usingCocoa: Pass `true` to return the `cocoa()` view wrapped in a SwiftUI view. Pass `false` to return the standard SwiftUI implementation from `swiftUI()`.
    @available(macOS 10.15, tvOS 13, iOS 13, *)
    public func resolved(usingCocoa: Bool) -> SwiftUI.AnyView {
      #if os(watchOS)
        return swiftUIAnyView()
      #else
        if usingCocoa {
          return cocoa().swiftUIAnyView()
        } else {
          return swiftUIAnyView()
        }
      #endif  // @exempt(from: tests)
    }
    @available(macOS 10.15, tvOS 13, iOS 13, *)
    internal func adjustForLegacyMode() -> SwiftUI.AnyView {
      return resolved(usingCocoa: legacyMode)
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
    _ edges: SDGInterface.Edge.Set = .all,
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
    alignment: SDGInterface.Alignment = .centre
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
    contentMode: SDGInterface.ContentMode
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
    alignment: SDGInterface.Alignment = .centre
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

  // MARK: - Pop‐Overs

  /// A shimmed version of `SwiftUI.View.popover(isPresented:attachmentAnchor:arrowEdge:content:)` with no availability constraints.
  ///
  /// - Parameters:
  ///   - isPresented: Whether the pop‐over is presented.
  ///   - attachmentAnchor: The anchor where the pop‐over is attached.
  ///   - arrowEdge: The edge where the pop‐over’s arrow is located.
  ///   - content: The content of the pop‐over.
  @available(watchOS, unavailable)
  public func popOver<Content>(
    isPresented: Shared<Bool>,
    attachmentAnchor: AttachmentAnchor = .rectangle(.bounds),
    arrowEdge: SDGInterface.Edge = .top,
    content: @escaping () -> Content
  ) -> PopOver<Self, Content> {
    return PopOver(
      anchor: self,
      isPresented: isPresented,
      attachmentAnchor: attachmentAnchor,
      arrowEdge: arrowEdge,
      content: content
    )
  }
}
