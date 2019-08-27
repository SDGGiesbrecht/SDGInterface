/*
 ProgressBar.swift

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
public final class ProgressBar : SpecificView {

    // MARK: - Initialization

    /// Creates an image view displaying an image.
    ///
    /// - Parameters:
    ///     - image: The image.
    public init() {
        #if canImport(AppKit)
        specificNative = NSProgressIndicator()
        #elseif canImport(UIKit)
        specificNative = UIProgressIndicator()
        #endif

        specificNative.usesThreadedAnimation = true

        progressValue = nil
    }

    // MARK: - Properties

    /// The value indicated by the start of the progress bar.
    public var startValue: Double {
        get {
            return specificNative.minValue
        }
        set {
            specificNative.minValue = newValue
        }
    }

    /// The value indicated by the start of the progress bar.
    public var endValue: Double {
        get {
            return specificNative.maxValue
        }
        set {
            specificNative.maxValue = newValue
        }
    }

    /// The value indicated by the progress bar. `nil` represents an indeterminate value.
    public var progressValue: Double? {
        get {
            return specificNative.isIndeterminate ? nil : specificNative.doubleValue
        }
        set {
            if let value = newValue {
                specificNative.isIndeterminate = false
                specificNative.stopAnimation(nil)
                specificNative.doubleValue = value
            } else {
                specificNative.doubleValue = 0
                specificNative.isIndeterminate = true
                specificNative.startAnimation(nil)
            }
        }
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
    public let specificNative: NSProgressIndicator
    #elseif canImport(UIKit)
    public let specificNative: UIProgressIndicator
    #endif
}
#endif
