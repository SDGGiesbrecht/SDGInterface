/*
 CocoaWindowImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(AppKit)
    import AppKit
  #else
    import UIKit
  #endif

  /// A window that is implemented using Cocoa.
  ///
  /// If a type provides an implementation of `cocoa()`, conformance to this protocol can be declared in order to use default implementations for all the other requirements of `SDGSwift.WindowProtocol`.
  public protocol CocoaWindowImplementation: LegacyWindow {}

  extension CocoaWindowImplementation where Self: CocoaWindow.NativeType {
    public func cocoa() -> CocoaWindow {
      return CocoaWindow(self)
    }
  }
#endif
