/*
 Image.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || canImport(UIKit)
  #if canImport(SwiftUI)
    import SwiftUI
  #endif

  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  /// An image.
  public struct Image {  // @exempt(from: swiftFormat[UseEnumForNamespacing])

    /// Returns an empty image.
    public static var empty: Image {
      #if canImport(AppKit)
        return Image(NSImage())
      #elseif canImport(UIKit)
        return Image(UIImage())
      #endif
    }

    #if canImport(AppKit)
      /// The system image indicating “go left”.
      public static var goLeft: Image {
        return Image(systemIdentifier: NSImage.goLeftTemplateName)!
      }

      /// The system image indicating “go right”.
      public static var goRight: Image {
        return Image(systemIdentifier: NSImage.goRightTemplateName)!
      }
    #endif

    // MARK: - Initialization

    #if canImport(AppKit)
      /// Creates an image from a Cocoa image.
      ///
      /// - Parameters:
      ///     - cocoa: The Cocoa image.
      public init(_ cocoa: NSImage) {
        self.cocoa = cocoa
      }
    #elseif canImport(UIKit)
      /// Creates an image from a Cocoa image.
      ///
      /// - Parameters:
      ///     - cocoa: The Cocoa image.
      public init(_ cocoa: UIImage) {
        self.cocoa = cocoa
      }
    #endif

    #if canImport(AppKit)
      /// Creates an image from a system image identifier.
      ///
      /// - Parameters:
      ///   - systemIdentifier: The system identifier.
      public init?(systemIdentifier: String) {
        if let image = NSImage(named: systemIdentifier) {
          self.init(image)
        } else {
          return nil
        }
      }
    #endif

    // MARK: - Properties

    #if canImport(AppKit)
      /// The Cocoa image.
      public var cocoa: NSImage
    #elseif canImport(UIKit)
      /// The Cocoa image.
      public var cocoa: UIImage
    #endif

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      /// The SwiftUI image.
      @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
      public func swiftUI() -> SwiftUI.Image {
        #if canImport(AppKit)
          return SwiftUI.Image(nsImage: cocoa)
        #elseif canImport(UIKit)
          return SwiftUI.Image(uiImage: cocoa)
        #endif
      }
    #endif
  }
#endif
