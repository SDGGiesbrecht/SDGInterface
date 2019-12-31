/*
 SwiftUIViewImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  /// A view that is implemented using SwiftUI.
  ///
  /// If a type already conforms to `SwiftUI.View`, conformance to this protocol can be declared in order to use default implementations for all the other requirements of `SDGSwift.View`.
  @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
  public protocol SwiftUIViewImplementation: View {}

  @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
  extension SwiftUIViewImplementation {

    #if canImport(AppKit)
      public var cocoaView: NSView {
        return NSHostingView(rootView: swiftUIView)
      }
    #elseif canImport(UIKit) && !os(watchOS)
      public var cocoaView: UIView {
        let controller = UIHostingController(rootView: swiftUIView)
        return controller.view
      }
    #endif
  }

  @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
  extension SwiftUIViewImplementation where Self: SwiftUI.View {
    public var swiftUIView: AnyView {
      return AnyView(self)
    }
  }
#endif
