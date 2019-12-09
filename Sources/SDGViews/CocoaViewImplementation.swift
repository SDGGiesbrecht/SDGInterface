/*
 CocoaViewImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #else
    import UIKit
  #endif

  /// A view that is implemented using Cocoa.
  ///
  /// If a type provides an implementation of `cocoaView`, conformance to this protocol can be declared in order to use default implementations for all the other requirements of `SDGSwift.View`.
  public protocol CocoaViewImplementation: View {}

  extension CocoaViewImplementation {

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      @available(macOS 10.15, iOS 13, tvOS 13, *)
      public var swiftUIView: AnyView {
        // @exempt(from: tests) #workaround(workspace version 0.27.0, macOS 10.15 is unavailable in CI.)
        return AnyView(CocoaViewRepresentableWrapper(self))
      }
    #endif
  }

  #if canImport(AppKit)
    extension CocoaViewImplementation where Self: NSView {
      public var cocoaView: NSView {
        return self
      }
    }
  #else
    extension CocoaViewImplementation where Self: UIView {
      public var cocoaView: UIView {
        return self
      }
    }
  #endif
#endif
