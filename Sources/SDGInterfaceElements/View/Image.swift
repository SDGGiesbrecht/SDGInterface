/*
 Image.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import AppKit

/// An image view.
public class Image: NSImageView {

    // MARK: - Initialization

    /// Creates an image view.
    public init() {
        super.init(frame: CGRect.zero)
        for constraint in [
            .required,
            .defaultHigh,
            .dragThatCanResizeWindow,
            .windowSizeStayPut,
            .dragThatCannotResizeWindow,
            .defaultLow,
            .fittingSizeCompression
            ] as [NSLayoutConstraint.Priority] {
                print(constraint.rawValue)
        }
        setContentCompressionResistancePriority(.windowSizeStayPut, for: .horizontal)
        setContentCompressionResistancePriority(.windowSizeStayPut, for: .vertical)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
