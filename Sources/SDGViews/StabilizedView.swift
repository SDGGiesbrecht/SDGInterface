/*
 StabilizedView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  /// Stabilizes a view to behave with consistent reference semantics.
  ///
  /// Wrap unknown `View` conformers in this type before using repeated accesses of `cocoaView` that assume the same instance will be returned each time.
  public struct StabilizedView: View {

    // MARK: - Initialization

    /// Creates a stabilized instance of a view.
    ///
    /// - Parameters:
    ///   - view: The view to stabilize.
    public init(_ view: View) {
      self.view = view
      #if !os(watchOS)
        self.stabilizedCocoaView = AnyCocoaView(view.cocoaView)
      #endif
    }

    // MARK: - Properties

    // Maintains any strong references outside the Cocoa view.
    /// The underlying view.
    public let view: View

    #if !os(watchOS)
      private let stabilizedCocoaView: AnyCocoaView
    #endif

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
      public var swiftUIView: AnyView {
        return view.swiftUIView
      }
    #endif

    #if canImport(AppKit)
      public var cocoaView: NSView {
        return stabilizedCocoaView.cocoaView
      }
    #elseif canImport(UIKit) && !os(watchOS)
      public var cocoaView: UIView {
        return stabilizedCocoaView.cocoaView
      }
    #endif
  }
#endif
