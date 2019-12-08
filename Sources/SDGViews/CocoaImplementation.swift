/*
 CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(AppKit)
    import SwiftUI
  #else
    import UIKit
  #endif

  /// A view that is implemented using Cocoa.
  ///
  /// If a type provides an implementation of `cocoaView`, conformance to this protocol can be declared in order to use default implementations for all the other requirements of `SDGSwift.View`.
  public protocol CocoaImplementation: View {}

  extension CocoaImplementation {

    @available(macOS 10.15, iOS 13, tvOS 13, *)
    public var swiftUIView: AnyView {
      return AnyView(SDGView(self))
    }
  }

  #if canImport(AppKit)
    extension CocoaImplementation where Self: NSView {
      public var cocoaView: NSView {
        return self
      }
    }
  #else
    extension CocoaImplementation where Self: UIView {
      public var cocoaView: UIView {
        return self
      }
    }
  #endif
#endif