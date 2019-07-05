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
public final class ImageView : SpecificView {

    // MARK: - Initialization

    /// Creates an image view displaying an image.
    ///
    /// - Parameters:
    ///     - image: The image.
    public init(image: Image) {
        self.image = image
        #if canImport(AppKit)
        specificNative = NSImageView(image: image.native)
        #elseif canImport(UIKit)
        specificNative = UIImageView(image: image.native)
        #endif

        #if canImport(AppKit)
        specificNative.setContentCompressionResistancePriority(.windowSizeStayPut, for: .horizontal)
        specificNative.setContentCompressionResistancePriority(.windowSizeStayPut, for: .vertical)
        #endif
    }

    // MARK: - Properties

    /// The image.
    public var image: Image

    // MARK: - SpecificView

    #if canImport(AppKit)
    public var specificNative: NSImageView
    #elseif canImport(UIKit)
    public var specificNative: UIImageView
    #endif
}
#endif
