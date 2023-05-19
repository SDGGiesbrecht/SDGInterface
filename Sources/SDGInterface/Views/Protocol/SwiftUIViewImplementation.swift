/*
 SwiftUIViewImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI

  /// A view that is implemented using SwiftUI.
  ///
  /// If a type already conforms to `SwiftUI.View`, conformance to this protocol can be declared in order to use default implementations for all the other requirements of `SDGSwift.View`.
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  public protocol SwiftUIViewImplementation: View {}

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension SwiftUIViewImplementation {

    // MARK: - View

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        #if canImport(AppKit)
          return CocoaView(NSHostingView(rootView: swiftUI()))
        #else
          let controller = UIHostingController(rootView: swiftUI())
          return CocoaView(controller.view)
        #endif
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension SwiftUIViewImplementation where Self: SwiftUI.View {

    // MARK: - View

    public func swiftUI() -> some SwiftUI.View {
      return self
    }
  }
#endif
