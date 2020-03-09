/*
 CastableView.swift

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

  /// The subset of the `View` protocol that can be used with dynamic casting.
  ///
  /// - Warning: Do not conform to this protocol without also conforming to `View`.
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  public protocol CastableView: LegacyView {

    #if canImport(SwiftUI)
      var _anySwiftUIView: SwiftUI.AnyView { get }
    #endif
  }
#endif
