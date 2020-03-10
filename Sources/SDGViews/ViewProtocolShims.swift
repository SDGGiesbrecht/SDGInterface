/*
 ViewProtocolShims.swift

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

  /// An implementation detail of the `View` protocol.
  ///
  /// This protocol is only part of the API because the compiler requires it to be referred to by name when conditionally conforming to `View`. Aside from this, you should never need to use it.
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  public protocol ViewProtocolShims {

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      var _swiftUIImplementation: SwiftUI.AnyView { get }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension ViewProtocolShims where Self: View {

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public var _swiftUIImplementation: SwiftUI.AnyView {
        return SwiftUI.AnyView(swiftUIView)
      }
    #endif
  }
#endif
