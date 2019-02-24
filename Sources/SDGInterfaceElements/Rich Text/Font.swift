/*
 Font.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension Font {

    // MARK: - System Fonts

    /// The default font.
    public static var `default`: NSFont {
        return forTextEditing
    }

    /// The label font.
    public static var forLabels: NSFont {
        return systemFont(ofSize: systemFontSize(for: .regular))
    }

    /// The default font for text editing.
    public static var forTextEditing: NSFont {
        return userFont(ofSize: systemSize) ?? systemFont(ofSize: systemSize)
    }

    // MARK: - Modified Versions

    /// The bold version of `self`.
    public var bold: Font {
        return NSFontManager.shared.convert(self, toHaveTrait: .boldFontMask)
    }

    /// The italic version of `self`.
    public var italic: Font {
        return NSFontManager.shared.convert(self, toHaveTrait: .italicFontMask)
    }

    /// The same font in a different size.
    public func resized(to size: CGFloat) -> NSFont {
        return NSFontManager.shared.convert(self, toSize: size)
    }
}
