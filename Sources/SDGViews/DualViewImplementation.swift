/*
 DualViewImplementation.swift

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

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal protocol DualViewImplementation: LegacyView {

    #if canImport(SwiftUI)
      var swiftUIImplementation: SwiftUI.AnyView { get }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension DualViewImplementation where Self: View {

    internal var swiftUIImplementation: SwiftUI.AnyView {
      return SwiftUI.AnyView(swiftUIView)
    }
  }
#endif
