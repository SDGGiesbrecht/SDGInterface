/*
 Colour.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif
#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

/// A colour.
public struct Colour: Hashable, Sendable {

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
    /// Creates a colour from an `NSColor`.
    ///
    /// - Parameters:
    ///     - colour: The colour.
    public init?(_ colour: NSColor) {
      guard let converted = colour.usingColorSpace(.genericRGB) else {
        return nil  // @exempt(from: tests)
      }
      red = Double(converted.redComponent)
      green = Double(converted.greenComponent)
      blue = Double(converted.blueComponent)
      opacity = Double(converted.alphaComponent)
    }
  #endif

  #if canImport(UIKit)
    /// Creates a colour from a `UIColor`.
    ///
    /// - Parameters:
    ///     - colour: The colour.
    public init(_ colour: UIColor) {
      var convertedRed: CGFloat = 0
      var convertedGreen: CGFloat = 0
      var convertedBlue: CGFloat = 0
      var convertedAlpha: CGFloat = 0
      colour.getRed(
        &convertedRed,
        green: &convertedGreen,
        blue: &convertedBlue,
        alpha: &convertedAlpha
      )
      red = Double(convertedRed)
      green = Double(convertedGreen)
      blue = Double(convertedBlue)
      opacity = Double(convertedAlpha)
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
}

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  extension Colour: View {

    // MARK: - View

    #if canImport(SwiftUI)
      @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
      public func swiftUI() -> some SwiftUI.View {
        return SwiftUI.Color(self)
      }
    #endif

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        #if canImport(AppKit)
          return CocoaView(Colour.Container(self))
        #else
          let view = UIView()
          view.backgroundColor = UIColor(self)
          return CocoaView(view)
        #endif
      }
    #endif
  }
#endif
