/*
 CocoaView.swift

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

  /// A Cocoa view.
  public struct CocoaView {

    // MARK: - Types

    #if canImport(AppKit)
      // @documentation(CocoaView.NativeType)
      /// The native type of the Cocoa view, which is `NSView` on macOS and `UIView` on tvOS and iOS.
      public typealias NativeType = NSView
    #elseif canImport(UIKit)
      // #documentation(CocoaView.NativeType)
      /// The native type of the Cocoa view, which is `NSView` on macOS and `UIView` on tvOS and iOS.
      public typealias NativeType = UIView
    #endif

    // MARK: - Initialization

    /// Creates an instance with a native Cocoa view.
    ///
    /// - Parameters:
    ///   - native: The native view.
    public init(_ native: NativeType) {
      self.native = native
    }

    // MARK: - Properties

    /// The native view.
    public let native: NativeType
  }
#endif
