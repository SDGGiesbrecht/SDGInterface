/*
 LayoutConstraintPriority.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  /// A layout constraint priority.
  public struct LayoutConstraintPriority: RawRepresentable {

    // MARK: - Static Properties

    /// A required constraint.
    public static var required: LayoutConstraintPriority {
      return LayoutConstraintPriority(NativeType.required)
    }

    /// The priority with which a resizable view fills its frame.
    public static var frameFill: LayoutConstraintPriority {
      var priority = LayoutConstraintPriority(NativeType.defaultLow)
      priority.rawValue += 5
      return LayoutConstraintPriority(LayoutConstraintPriority.NativeType(rawValue: 255))
    }

    /// The priority with which a view fills its letterbox.
    public static var letterboxFill: LayoutConstraintPriority {
      return LayoutConstraintPriority(NativeType.defaultLow)
    }

    // MARK: - Initialization

    /// Creates a layout constraint priority from a native priority.
    ///
    /// - Parameters:
    ///   - native: The native priority.
    public init(_ native: NativeType) {
      self.native = native
    }

    // MARK: - Properties

    internal var native: NativeType

    // MARK: - RawRepresentable

    public init(rawValue: Float) {
      native = NativeType(rawValue: rawValue)
    }

    public var rawValue: Float {
      get {
        return native.rawValue
      }
      set {
        native = NativeType(rawValue: newValue)
      }
    }
  }

#endif
