/*
 ImageView.swift

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

import SDGText
import SDGLocalization

import SDGInterfaceLocalizations

/// An image view.
public class ImageView : NSImageView {

    // MARK: - Initialization

    /// Creates an image view.
    public init() {
        super.init(frame: CGRect.zero)
        setContentCompressionResistancePriority(.windowSizeStayPut, for: .horizontal)
        setContentCompressionResistancePriority(.windowSizeStayPut, for: .vertical)
    }

    @available(*, unavailable) public required init?(coder: NSCoder) { // @exempt(from: unicode)
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Image"
            }
        }))
        return nil
    }
}

#endif
