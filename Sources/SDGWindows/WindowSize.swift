/*
 WindowSize.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

extension Window {

    /// A window size.
    public struct Size {

        // MARK: - Static Methods

        #if canImport(AppKit) || canImport(UIKit)
        /// A size that fills the available space on the main screen, without obscuring menu bars, docks, etc.
        public static var fillingAvailable: Size {
            #if canImport(AppKit)
            return Size((NSScreen.main ?? NSScreen()).frame.size)
            #elseif canImport(UIKit)
            return Size(UIScreen.main.bounds.size)
            #endif
        }
        #endif

        #if canImport(AppKit)
        /// The default size of an auxiliary window.
        public static var defaultAuxiliary: Size {
            return Size(width: 480, height: 270)
        }
        #endif

        // MARK: - Initialization

        /// Creates a size.
        ///
        /// - Parameters:
        ///     - width: The width.
        ///     - height: The height.
        public init(width: Double, height: Double) {
            self.width = width
            self.height = height
        }

        /// Creates an empty size.
        public init() {
            width = 0
            height = 0
        }

        #if canImport(CoreGraphics)
        public init(_ native: CGSize) {
            self.init(width: Double(native.width), height: Double(native.height))
        }
        #endif

        // MARK: - Properties

        /// The width.
        var width: Double

        /// The height.
        var height: Double

        #if canImport(CoreGraphics)
        /// The native size.
        public var native: CGSize {
            return CGSize(width: CGFloat(width), height: CGFloat(height))
        }
        #endif
    }
}
