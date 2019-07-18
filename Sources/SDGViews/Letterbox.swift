/*
 Letterbox.swift

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

import SDGInterfaceBasics

import SDGInterfaceLocalizations

/// A letterboxing view.
public final class Letterbox<Content> : View where Content : View {

    // MARK: - Initialization

    /// Creates a letterbox.
    ///
    /// - Parameters:
    ///     - content: The content view.
    ///     - widthToHeight: The intended aspect ratio.
    public init(content: Content, aspectRatio widthToHeight: Double) {
        self.container = LetterboxContainer()
        self.content = content

        content.lockAspectRatio(to: widthToHeight)
        AnyNativeView(container).centre(subview: content)

        let maxWidth = NSLayoutConstraint(
            item: content.native,
            attribute: .width,
            relatedBy: .lessThanOrEqual,
            toItem: container,
            attribute: .width,
            multiplier: 1,
            constant: 0)
        let maxHeight = NSLayoutConstraint(
            item: content.native,
            attribute: .height,
            relatedBy: .lessThanOrEqual,
            toItem: container,
            attribute: .height,
            multiplier: 1,
            constant: 0)

        let desiredWidth = NSLayoutConstraint(
            item: content.native,
            attribute: .width,
            relatedBy: .equal,
            toItem: container,
            attribute: .width,
            multiplier: 1,
            constant: 0)
        #if canImport(AppKit)
        desiredWidth.priority = NSLayoutConstraint.Priority(rawValue: 1)
        #elseif canImport(UIKit)
        desiredWidth.priority = UILayoutPriority(rawValue: 1)
        #endif
        let desiredHeight = NSLayoutConstraint(
            item: content.native,
            attribute: .height,
            relatedBy: .equal,
            toItem: container,
            attribute: .height,
            multiplier: 1,
            constant: 0)
        #if canImport(AppKit)
        desiredHeight.priority = NSLayoutConstraint.Priority(rawValue: 1)
        #elseif canImport(UIKit)
        desiredHeight.priority = UILayoutPriority(rawValue: 1)
        #endif

        container.addConstraints([maxWidth, maxHeight, desiredWidth, desiredHeight])
    }

    // MARK: - Properties

    private let container: LetterboxContainer

    /// The content of the letterbox.
    public let content: Content

    /// The colour.
    public var colour: Colour? {
        get {
            return container.colour
        }
        set {
            container.colour = newValue
        }
    }

    // MARK: - View

    #if canImport(AppKit)
    public var native: NSView {
        return container
    }
    #elseif canImport(UIKit)
    public var native: UIView {
        return container
    }
    #endif
}
#endif
