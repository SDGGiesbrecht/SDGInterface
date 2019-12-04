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

  /// A view.
  public protocol View: AnyObject {

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

    #if canImport(SwiftUI) && !os(watchOS) && !(os(iOS) && arch(arm))
      @available(macOS 10.15, iOS 13, tvOS 13, *)
      public var swiftUIView: AnyView {
        // @exempt(from: tests) #workaround(workspace version 0.27.0, macOS 10.15 is unavailable in CI.)
        return AnyView(SDGView(self))
      }
    #endif

    // MARK: - Aspect Ratio

    #if !os(watchOS)
    // #workaround(Can this be done with SwiftUI?)
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
