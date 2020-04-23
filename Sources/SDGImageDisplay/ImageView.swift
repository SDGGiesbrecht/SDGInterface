/*
 ImageView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)

  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGViews

  /// An image view.
  public final class ImageView: CocoaViewImplementation, View {

    // MARK: - Initialization

    /// Creates an image view displaying an image.
    ///
    /// - Parameters:
    ///     - image: The image.
    public init(image: Image) {
      self.image = image
      #if canImport(AppKit)
        let imageView = NSImageView()
        imageView.image = image.cocoa
        nativeView = imageView
      #elseif canImport(UIKit)
        nativeView = UIImageView(image: image.cocoa)
      #endif

      #if canImport(AppKit)
        nativeView.setContentCompressionResistancePriority(
          .windowSizeStayPut,
          for: .horizontal
        )
        nativeView.setContentCompressionResistancePriority(
          .windowSizeStayPut,
          for: .vertical
        )
      #endif
    }

    // MARK: - Properties

    #if canImport(AppKit)
      private let nativeView: NSImageView
    #elseif canImport(UIKit)
      private let nativeView: UIImageView
    #endif

    /// The image.
    public var image: Image

    // MARK: - LegacyView

    public func cocoa() -> CocoaView {
      return CocoaView(nativeView)
    }
  }
#endif
