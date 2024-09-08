/*
 Size.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)
  import CoreGraphics
#endif
#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

/// A window size.
public struct Size: Equatable, Hashable, Sendable {

  // MARK: - Static Properties

  #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
    /// A size that fills the available space on the main screen, without obscuring menu bars, docks, etc.
    public static func fillingAvailable() -> Size {
      #if canImport(AppKit)
        return Size(
          (NSScreen.main
            ?? NSScreen()  // @exempt(from: tests) Screen should not be nil.
            ).frame.size
        )
      #elseif canImport(UIKit)
        return Size(UIScreen.main.bounds.size)
      #endif
    }
  #endif

  #if canImport(AppKit)
    /// The default size of an auxiliary window.
    public static var auxiliaryWindow: Size {
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
    /// Creates a size from a CoreGraphics size.
    ///
    /// - Parameters:
    ///     - size: The CoreGraphics size.
    public init(_ size: CGSize) {
      self.init(width: Double(size.width), height: Double(size.height))
    }
  #endif

  // MARK: - Properties

  /// The width.
  public var width: Double

  /// The height.
  public var height: Double
}
