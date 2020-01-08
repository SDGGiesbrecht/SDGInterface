/*
 LayoutConstraintPriority.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(AppKit)
    import AppKit
  #elseif canImport(UIKit) && !os(watchOS)
    import UIKit
  #endif

  #if canImport(AppKit)
    internal typealias LayoutConstraintPriority = NSLayoutConstraint.Priority
  #elseif canImport(UIKit) && !os(watchOS)
    internal typealias LayoutConstraintPriority = UILayoutPriority
  #endif

  extension LayoutConstraintPriority {

  }

#endif