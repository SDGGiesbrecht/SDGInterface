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
    public init<V>(_ contents: V) where V: LegacyView {
      cocoaViewGenerator = { return contents.cocoaView }
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        swiftUIViewGenerator = { () -> SwiftUI.AnyView in
        }
      } else {
        swiftUIViewGenerator = Optional<Bool>.none as Any
      }
    }

    // MARK: - Properties

    private let swiftUIViewGenerator: Any

    #if canImport(AppKit)
      private let cocoaViewGenerator: () -> NSView
    #elseif canImport(UIKit) && !os(watchOS)
      private let cocoaViewGenerator: () -> UIView
    #endif

    // MARK: - LegacyView

    #if canImport(AppKit)
      public var cocoaView: NSView {
        return cocoaViewGenerator()
      }
    #elseif canImport(UIKit) && !os(watchOS)
      public var cocoaView: UIView {
        return cocoaViewGenerator()
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, *)
  extension AnyView: View {

    // MARK: - View

    public var swiftUIView: SwiftUI.AnyView {
      return (swiftUIViewGenerator as? () -> SwiftUI.AnyView)?()
        ?? SwiftUI.AnyView(CocoaViewRepresentableWrapper(cocoaViewGenerator()))
    }
  }
#endif
