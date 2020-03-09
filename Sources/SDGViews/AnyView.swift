/*
 AnyView.swift

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

  import SDGInterfaceBasics

  /// A type‐erased view.
  @available(watchOS 6, *)
  public struct AnyView: LegacyView {

    // MARK: - Initialization

    /// Creates a type‐erases version of the view.
    public init(_ contents: LegacyView) {
      legacyView = contents
    }

    // MARK: - Properties

    let legacyView: LegacyView

    // MARK: - LegacyView

    #if canImport(AppKit)
      public var cocoaView: NSView {
        return legacyView.cocoaView
      }
    #elseif canImport(UIKit) && !os(watchOS)
      public var cocoaView: UIView {
        return legacyView.cocoaView
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, *)
  extension AnyView: View {

    // MARK: - View

    public var swiftUIView: SwiftUI.AnyView {
      if let view = legacyView as? CastableView {
        return view._anySwiftUIView
      }
      return SwiftUI.AnyView(CocoaViewRepresentableWrapper(cocoaView))
    }
  }
#endif
