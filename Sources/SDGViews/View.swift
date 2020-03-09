/*
 View.swift

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

    public var anySwiftUIView: SwiftUI.AnyView {
      return SwiftUI.AnyView(swiftUIView)
    }
  }
#endif
