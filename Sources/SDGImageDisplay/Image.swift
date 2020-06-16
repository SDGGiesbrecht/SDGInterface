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
  public struct Image: LegacyView {

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
        definition = .cocoa(cocoa)
      }
    #endif

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      /// Creates an image from a SwiftUI image.
      ///
      /// - Parameters:
      ///     - swiftUI: The SwiftUI image.
      @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
      public init(_ swiftUI: SwiftUI.Image) {
        definition = .swiftUI(swiftUI)
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

    private var definition: Definition

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      /// Returns the image converted into a SwiftUI image.
      @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
      public func swiftUIImage() -> SwiftUI.Image {
        switch definition {
        case .cocoa(let image):
          return SwiftUI.Image(image)
        case .swiftUI(let image):
          return image
        }
      }
    #endif

    #if canImport(AppKit) || canImport(UIKit)
      /// Returns the image converted into a Cocoa image, if possible.
      public func cocoaImage() -> CocoaImage? {
        switch definition {
        case .cocoa(let image):
          return image
        #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
          case .swiftUI:
            return nil
        #endif
        }
      }
    #endif

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        return useSwiftUIOrFallback(to: {
          #if canImport(AppKit)
            typealias CocoaImageView = NSImageView
          #else
            typealias CocoaImageView = UIImageView
          #endif
          let view = CocoaImageView(frame: .zero)
          view.image = cocoaImage()?.native

          #if canImport(AppKit)
            view.setContentCompressionResistancePriority(
              .windowSizeStayPut,
              for: .horizontal
            )
            view.setContentCompressionResistancePriority(
              .windowSizeStayPut,
              for: .vertical
            )
          #endif
          return CocoaView(view)
        })
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension Image: View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        return swiftUIImage()
      }
    #endif
  }
#endif
