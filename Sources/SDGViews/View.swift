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
#if canImport(SwiftUI) && !os(iOS) // #workaround(xcodebuild -version 11.2, @availability checks are broken for iOS.) @exempt(from: unicode)
import SwiftUI
#endif
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

    #if canImport(SwiftUI) && !os(iOS) // #workaround(xcodebuild -version 11.2, @availability checks are broken for iOS.) @exempt(from: unicode)
    /// The SwiftUI view.
    @available(macOS 10.15, tvOS 13, *)
    public var swiftUIView: some SwiftUI.View {
        // @exempt(from: tests) #workaround(workspace version 0.24.0, macOS 10.15 is unavailable in CI.)
        return SDGView(self)
    }
    #endif

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
