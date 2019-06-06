/*
 Letterbox.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)
import SDGMathematics

import SDGInterfaceLocalizations

/// A letterboxing view.
open class Letterbox : View {

    // MARK: - Properties

    /// The colour.
    public var colour: Colour?

    // MARK: - Initialization

    /// Creates a letterboxing view.
    ///
    /// - Parameters:
    ///     - content: The content view.
    ///     - widthToHeight: The intended aspect ratio.
    public init(content: View, aspectRatio widthToHeight: CGFloat) {
        super.init(frame: CGRect.zero)

        content.lockAspectRatio(to: widthToHeight)
        centre(subview: content)

        let maxWidth = NSLayoutConstraint(
            item: content,
            attribute: .width,
            relatedBy: .lessThanOrEqual,
            toItem: self,
            attribute: .width,
            multiplier: 1,
            constant: 0)
        let maxHeight = NSLayoutConstraint(
            item: content,
            attribute: .height,
            relatedBy: .lessThanOrEqual,
            toItem: self,
            attribute: .height,
            multiplier: 1,
            constant: 0)

        let desiredWidth = NSLayoutConstraint(
            item: content,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 1,
            constant: 0)
        desiredWidth.priority = NSLayoutConstraint.Priority(rawValue: 1)
        let desiredHeight = NSLayoutConstraint(
            item: content,
            attribute: .height,
            relatedBy: .equal,
            toItem: self,
            attribute: .height,
            multiplier: 1,
            constant: 0)
        desiredHeight.priority = NSLayoutConstraint.Priority(rawValue: 1)

        addConstraints([maxWidth, maxHeight, desiredWidth, desiredHeight])
    }

    @available(*, unavailable) public required init?(coder: NSCoder) { // @exempt(from: unicode)
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Letterbox"
            }
        }))
        return nil
    }

    // MARK: - Drawing

    open override func draw(_ dirtyRect: CGRect) { // @exempt(from: tests) Crashes without active interface.
        if let colour = self.colour {
            colour.setFill()
            if colour.alphaComponent ≤ 1 {
                #if canImport(UIKit)
                UIRectFillUsingBlendMode(dirtyRect, .normal)
                #else
                dirtyRect.fill(using: .sourceOver)
                #endif
            } else {
                #if canImport(UIKit)
                UIRectFill(dirtyRect)
                #else
                dirtyRect.fill()
                #endif
            }
        }
        super.draw(dirtyRect)
    }
}
#endif
