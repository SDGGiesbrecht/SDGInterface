/*
 View.swift

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
#elseif canImport(UIKit)
import UIKit
#endif

/// A view.
public protocol View : AnyObject {
    #if canImport(AppKit)
    /// The native view.
    var native: NSView { get }
    #elseif canImport(UIKit)
    /// The native view.
    var native: UIView { get }
    #endif
}

extension View {

    // MARK: - Aspect Ratio

    /// Locks the aspect ratio of the view.
    ///
    /// - Parameters:
    ///     - aspectRatio: The aspect ratio. (*width* ∶ *height*)
    public func lockAspectRatio(to aspectRatio: Double) {
        let constraint = NSLayoutConstraint(
            item: self.native,
            attribute: .width,
            relatedBy: .equal,
            toItem: self.native,
            attribute: .height,
            multiplier: CGFloat(aspectRatio),
            constant: 0)
        native.addConstraint(constraint)
    }
}
#endif
