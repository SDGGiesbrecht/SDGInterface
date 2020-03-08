/*
 View.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#warning("Audit.")

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
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

  /// A view.
  ///
  /// When conforming to `View`, it is simplest (though not necessary) for a type to either:
  ///
  /// - implement `swiftUIView` and conform to `SwiftUIViewImplementation`, or
  /// - implement `cocoaView` and conform to `CocoaViewImplementation`.
  ///
  /// In each case, default implementations will cover the rest of the conformance to `View`.
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  public protocol View: LegacyView {

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      /// The type of the SwiftUIView
      associatedtype SwiftUIView: SwiftUI.View

      /// The SwiftUI view.
      var swiftUIView: SwiftUIView { get }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension View {

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
    ) -> View {
      #if os(watchOS)
        return AnyView(
          swiftUIView.frame(
            minWidth: minWidth.map({ CGFloat($0) }),
            idealWidth: idealWidth.map({ CGFloat($0) }),
            maxWidth: maxWidth.map({ CGFloat($0) }),
            minHeight: minHeight.map({ CGFloat($0) }),
            idealHeight: idealHeight.map({ CGFloat($0) }),
            maxHeight: maxHeight.map({ CGFloat($0) }),
            alignment: SwiftUI.Alignment(alignment)
          )
        )
      #elseif (canImport(SwiftUI) && !(os(iOS) && arch(arm)))
        if #available(macOS 10.15, tvOS 13, iOS 13, *),
          ¬legacyMode
        {
          return AnyView(
            swiftUIView.frame(
              minWidth: minWidth.map({ CGFloat($0) }),
              idealWidth: idealWidth.map({ CGFloat($0) }),
              maxWidth: maxWidth.map({ CGFloat($0) }),
              minHeight: minHeight.map({ CGFloat($0) }),
              idealHeight: idealHeight.map({ CGFloat($0) }),
              maxHeight: maxHeight.map({ CGFloat($0) }),
              alignment: SwiftUI.Alignment(alignment)
            )
          )
        } else {
          return FrameContainer(
            contents: self,
            minWidth: minWidth,
            idealWidth: idealWidth,
            maxWidth: maxWidth,
            minHeight: minHeight,
            idealHeight: idealHeight,
            maxHeight: maxHeight,
            alignment: alignment
          )
        }
      // @exempt(from: tests) Returned already, but the uncompiled text below confuses Xcode.
      #else
        return FrameContainer(
          contents: self,
          minWidth: minWidth,
          idealWidth: idealWidth,
          maxWidth: maxWidth,
          minHeight: minHeight,
          idealHeight: idealHeight,
          maxHeight: maxHeight,
          alignment: alignment
        )
      #endif
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
    ) -> View where Background: View {
      return
        self
        .aspectRatio(aspectRatio, contentMode: .fit)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .centre)
        .shimmedBackground(background)
    }
  }
#endif
