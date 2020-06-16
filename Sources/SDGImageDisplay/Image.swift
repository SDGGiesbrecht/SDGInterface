/*
 Image.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGViews

  /// An image.
  public struct Image: LegacyView {  // @exempt(from: swiftFormat[UseEnumForNamespacing])

    /// Returns an empty image.
    public static var empty: Image {
      return Image(CocoaImage())
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

    #if canImport(AppKit) || canImport(UIKit)
      /// Creates an image from a Cocoa image.
      ///
      /// - Parameters:
      ///     - cocoa: The Cocoa image.
      public init(_ cocoa: CocoaImage) {
        self.cocoaImage = cocoa
      }
    #endif

    #if canImport(AppKit)
      internal init?(systemIdentifier: String) {
        if let image = CocoaImage(systemIdentifier: systemIdentifier) {
          self.init(image)
        } else {
          return nil
        }
      }
    #endif

    // MARK: - Properties

    #if canImport(AppKit) || canImport(UIKit)
      /// The Cocoa image.
      public var cocoaImage: CocoaImage
    #endif

    // MARK: - LegacyView

    public func cocoa() -> CocoaView {
      return useSwiftUIOrFallback(to: {
        return CocoaView(CocoaImplementation(image: self))
      })
    }
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension Image: View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        return SwiftUIImplementation(image: self)
      }
    #endif
  }
#endif
