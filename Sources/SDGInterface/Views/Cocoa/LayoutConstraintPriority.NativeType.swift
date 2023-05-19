/*
 LayoutConstraintPriority.NativeType.swift

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

  extension LayoutConstraintPriority {

    #if canImport(AppKit)
      // @documentation(LayoutConstraintPriority.NativeType)
      /// The native type of the priority, which is `NSLayoutConstraint.Priority` on macOS and `UILayoutPriority` on tvOS and iOS.
      public typealias NativeType = NSLayoutConstraint.Priority
    #elseif canImport(UIKit)
      // #documentation(LayoutConstraintPriority.NativeType)
      /// The native type of the priority, which is `NSLayoutConstraint.Priority` on macOS and `UILayoutPriority` on tvOS and iOS.
      public typealias NativeType = UILayoutPriority
    #endif
  }

  extension LayoutConstraintPriority.NativeType {

    // MARK: - Initialization

    /// Creates a native priority from a layout constraint priority.
    ///
    /// - Parameters:
    ///   - priority: The priority.
    public init(_ priority: LayoutConstraintPriority) {
      self = priority.native
    }
  }
#endif
