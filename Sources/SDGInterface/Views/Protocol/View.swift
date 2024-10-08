/*
 View.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

/// A view.
///
/// When conforming to `View`, it is simplest (though not necessary) for a type to either:
///
/// - implement `swiftUI()` and conform to `SwiftUIViewImplementation`, or
/// - implement `cocoa()` and conform to `CocoaViewImplementation`.
///
/// In each case, default implementations will cover the rest of the conformance to `View`.
@available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
public protocol View: LegacyView, ViewShims {

  #if canImport(SwiftUI)
    /// The type of the SwiftUI view.
    associatedtype SwiftUIView: SwiftUI.View

    // @documentation(View.swiftUI())
    /// Constructs a SwiftUI representation of the view.
    func swiftUI() -> SwiftUIView
  #endif
}

@available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
extension View {

  #if canImport(SwiftUI)
    public func swiftUIAnyView() -> SwiftUI.AnyView {
      return SwiftUI.AnyView(swiftUI())
    }
  #endif
}
