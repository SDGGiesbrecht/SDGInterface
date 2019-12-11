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
      var cocoaView: NSView { get }
    #elseif canImport(UIKit) && !os(watchOS)
      // #documentation(View.cocoaView)
      /// The `NSView` or `UIView`.
      var cocoaView: UIView { get }
    #endif
  }

  extension View {

    // MARK: - Aspect Ratio

    /// A shimmed version of `SwiftUI.View.aspectRatio(_:contentMode:)` with no availability constraints.
    public func shimmedAspectRatio(
      _ aspectRatio: Double? = nil,
      contentMode: SDGInterfaceBasics.ContentMode) -> View {
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *),
        ¬legacyMode {
        return AnyView(swiftUIView.aspectRatio(aspectRatio.map({ CGFloat($0) }), contentMode: SwiftUI.ContentMode(contentMode)))
      } else {
        return legacyAspectRatio(aspectRatio, contentMode: contentMode)
      }
      #else
      return legacyAspectRatio(aspectRatio, contentMode: contentMode)
      #endif
    }

    private func legacyAspectRatio(_ aspectRatio: Double? = nil, contentMode: SDGInterfaceBasics.ContentMode) -> View {
      #warning("Copy?")
      let stabilized = StabilizedView(self)
      let cocoa = stabilized.cocoaView
      if let aspectRatio = aspectRatio {
        let constraint = NSLayoutConstraint(
          item: cocoa,
          attribute: .width,
          relatedBy: .equal,
          toItem: cocoa,
          attribute: .height,
          multiplier: CGFloat(aspectRatio),
          constant: 0
        )
        cocoa.addConstraint(constraint)
      }
      switch contentMode {
      case .fill:
        #warning("What is fill?")
      case .fit:
        #warning("What is fit?")
      }
      return stabilized
    }
    #if !os(watchOS)
      #warning("Remove.")
      /// Locks the aspect ratio of the view.
      ///
      /// - Parameters:
      ///     - aspectRatio: The aspect ratio. (*width* ∶ *height*)
      public func lockAspectRatio(to aspectRatio: Double) {
        let constraint = NSLayoutConstraint(
          item: self.cocoaView,
          attribute: .width,
          relatedBy: .equal,
          toItem: self.cocoaView,
          attribute: .height,
          multiplier: CGFloat(aspectRatio),
          constant: 0
        )
        cocoaView.addConstraint(constraint)
      }
    #endif
  }
#endif
