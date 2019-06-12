/*
 NSLayoutConstraintPriority.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

extension NSLayoutConstraint {

    #if !canImport(AppKit)
    /// An `NSLayoutConstraint.Priority` or a `UILayoutPriority`.
    public typealias Priority = UILayoutPriority
    #endif
}

extension NSLayoutConstraint.Priority {

    #if !canImport(AppKit)
    /// Priority level for the window’s current size.
    public static let windowSizeStayPut: NSLayoutConstraint.Priority = NSLayoutConstraint.Priority(rawValue: 500)
    #endif
}

#endif
