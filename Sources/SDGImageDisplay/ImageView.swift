/*
 ImageView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
public class ImageView : View {

    // MARK: - Initialization

    /// Creates an image view displaying an image.
    ///
    /// - Parameters:
    ///     - image: The image.
    public init(image: Image) {
        self.image = image
        #if canImport(AppKit)
        nativeImageView = NSImageView(image: image.native)
        #elseif canImport(UIKit)
        nativeImageView = UIImageView(image: image.native)
        #endif

        #if canImport(AppKit)
        nativeImageView.setContentCompressionResistancePriority(.windowSizeStayPut, for: .horizontal)
        nativeImageView.setContentCompressionResistancePriority(.windowSizeStayPut, for: .vertical)
        #endif
    }

    // MARK: - Properties

    /// The image.
    public var image: Image

    #if canImport(AppKit)
    /// The native image view.
    public var nativeImageView: NSImageView
    #elseif canImport(UIKit)
    /// The native image view.
    public var nativeImageView: UIImageView
    #endif

    // MARK: - View

    public var native: NSView {
        return nativeImageView
    }
}
#endif
