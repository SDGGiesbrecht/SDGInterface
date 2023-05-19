/*
 CocoaImage.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || canImport(UIKit)
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  /// A Cocoa image.
  public struct CocoaImage {

    // MARK: - Types

    #if canImport(AppKit)
      // @documentation(CocoaImage.NativeType)
      /// The native type of the Cocoa image, which is `NSImage` on macOS and `UIImage` on tvOS and iOS.
      public typealias NativeType = NSImage
    #elseif canImport(UIKit)
      // #documentation(CocoaImage.NativeType)
      /// The native type of the Cocoa image, which is `NSImage` on macOS and `UIImage` on tvOS and iOS.
      public typealias NativeType = UIImage
    #endif

    // MARK: - Initialization

    /// Creates an empty image.
    public init() {
      self.init(NativeType())
    }

    /// Creates an instance with a native Cocoa view.
    ///
    /// - Parameters:
    ///   - native: The native view.
    public init(_ native: NativeType) {
      self.nativeStorage = native.copy() as! NativeType
    }

    #if canImport(AppKit)
      internal init?(systemIdentifier: String) {
        if let image = NSImage(named: systemIdentifier) {
          self.init(image)
        } else {
          return nil
        }
      }
    #endif

    // MARK: - Properties

    private var nativeStorage: NativeType
    /// The native image.
    public var native: NativeType {
      get {
        return nativeStorage.copy() as! NativeType
      }
      set {
        nativeStorage = newValue.copy() as! NativeType
      }
    }
  }
#endif
