/*
 CocoaWindow.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  /// A Cocoa window.
  public struct CocoaWindow: CocoaWindowImplementation {

    // MARK: - Types

    #if canImport(AppKit)
      // @documentation(CocoaView.NativeType)
      /// The native type of the Cocoa window, which is `NSWindow` on macOS and `UIWindow` on tvOS and iOS.
      public typealias NativeType = NSWindow
    #elseif canImport(UIKit)
      // #documentation(CocoaView.NativeType)
      /// The native type of the Cocoa window, which is `NSWindow` on macOS and `UIWindow` on tvOS and iOS.
      public typealias NativeType = UIWindow
    #endif

    // MARK: - Initialization

    /// Creates an instance with a native Cocoa window.
    ///
    /// - Parameters:
    ///   - native: The native window.
    public init(_ native: NativeType) {
      self.native = native
    }

    // MARK: - Properties

    /// The native window.
    public let native: NativeType

    // MARK: - WindowProtocol

    public func cocoa() -> CocoaWindow {
      return self
    }
  }
#endif
