/*
 Colour.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

/// A colour.
public struct Colour {

    // MARK: - Static Properties

    /// Black.
    public static var black: Colour {
        return Colour(white: 0)
    }
    /// White.
    public static var white: Colour {
        return Colour(white: 1)
    }

    /// Blue.
    public static var blue: Colour {
        return Colour(red: 0, green: 0, blue: 1)
    }
    /// Green.
    public static var green: Colour {
        return Colour(red: 0, green: 1, blue: 0)
    }
    /// Cyan.
    public static var cyan: Colour {
        return Colour(red: 0, green: 1, blue: 1)
    }
    /// Red.
    public static var red: Colour {
        return Colour(red: 1, green: 0, blue: 0)
    }
    /// Magenta.
    public static var magenta: Colour {
        return Colour(red: 1, green: 0, blue: 1)
    }
    /// Yellow.
    public static var yellow: Colour {
        return Colour(red: 1, green: 1, blue: 0)
    }

    // MARK: - Initialization

    /// Creates a colour.
    ///
    /// - Parameters:
    ///     - red: The red component. (0–1)
    ///     - green: The green component. (0–1)
    ///     - blue: The blue component. (0–1)
    ///     - opacity: The opacity. (0–1)
    public init(red: Double, green: Double, blue: Double, opacity: Double = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }

    /// Creates a greyscale colour with zero saturation.
    ///
    /// - Parameters:
    ///     - white: The brightness component. (0–1)
    ///     - opacity: The opacity. (0–1)
    public init(white: Double, opacity: Double = 1) {
        self.red = white
        self.green = white
        self.blue = white
        self.opacity = opacity
    }

    #if canImport(AppKit)
    // @documentation(Colour.init(native:))
    /// Creates a colour from a native colour.
    ///
    /// - Parameters:
    ///     - native: The native colour.
    public init(native: NSColor) {
        self.native = native
    }
    #elseif canImport(UIKit)
    // #documentation(Colour.init(native:))
    /// Creates a colour from a native colour.
    ///
    /// - Parameters:
    ///     - native: The native colour.
    public init(native: UIColor) {
        self.native = native
    }
    #endif

    // MARK: - Properties

    /// The red component. (0–1)
    public var red: Double = 0

    /// The green component. (0–1)
    public var green: Double = 0

    /// The blue component. (0–1)
    public var blue: Double = 0

    /// The opacity. (0–1)
    public var opacity: Double = 0

    #if canImport(AppKit)
    // @documentation(Colour.native)
    /// The native colour.
    public var native: NSColor {
        get {
            return NSColor(
                calibratedRed: CGFloat(red),
                green: CGFloat(green),
                blue: CGFloat(blue),
                alpha: CGFloat(opacity))
        }
        set {
            if let converted = newValue.usingColorSpace(.genericRGB) {
                red = Double(converted.redComponent)
                green = Double(converted.greenComponent)
                blue = Double(converted.blueComponent)
                opacity = Double(converted.alphaComponent)
            }
        }
    }
    #elseif canImport(UIKit)
    // #documentation(Colour.native)
    /// The native colour.
    public var native: UIColor {
        get {
            return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(opacity))
        }
        set {
            var convertedRed: CGFloat = 0
            var convertedGreen: CGFloat = 0
            var convertedBlue: CGFloat = 0
            var convertedAlpha: CGFloat = 0
            newValue.getRed(&convertedRed, green: &convertedGreen, blue: &convertedBlue, alpha: &convertedAlpha)
            red = Double(convertedRed)
            green = Double(convertedGreen)
            blue = Double(convertedBlue)
            opacity = Double(convertedAlpha)
        }
    }
    #endif
}
