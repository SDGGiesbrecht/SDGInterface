/*
 Font.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || canImport(UIKit)
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import SDGText

extension Font {

    // MARK: - System Fonts

    /// The default font.
    public static var `default`: Font {
        return forTextEditing
    }

    /// The label font.
    public static var forLabels: Font {
        #if canImport(AppKit)
        return systemFont(ofSize: systemFontSize(for: .regular))
        #else
        return preferredFont(forTextStyle: .headline)
        #endif
    }

    /// The default font for text editing.
    public static var forTextEditing: Font {
        var user: Font?
        #if canImport(AppKit)
        user = userFont(ofSize: systemSize)
        #endif
        return user ?? systemFont(ofSize: systemSize) // @exempt(from: tests) Unknown why it would ever be nil on macOS.
    }

    // MARK: - Modified Versions

    /// The bold version of `self`.
    public var bold: Font {
        #if canImport(AppKit)
        return NSFontManager.shared.convert(self, toHaveTrait: .boldFontMask)
        #else
        let descriptor = fontDescriptor.withSymbolicTraits(.traitBold) ?? fontDescriptor // @exempt(from: tests) Unknown why the descriptor would be nil.
        return Font(descriptor: descriptor, size: 0)
        #endif
    }

    /// The italic version of `self`.
    public var italic: Font {
        #if canImport(AppKit)
        return NSFontManager.shared.convert(self, toHaveTrait: .italicFontMask)
        #else
        let descriptor = fontDescriptor.withSymbolicTraits(.traitItalic) ?? fontDescriptor // @exempt(from: tests) Unknown why the descriptor would be nil.
        return Font(descriptor: descriptor, size: 0)
        #endif
    }

    /// The same font in a different size.
    ///
    /// - Parameters:
    ///     - size: The new point size.
    public func resized(to size: CGFloat) -> Font {
        #if canImport(AppKit)
        return NSFontManager.shared.convert(self, toSize: size)
        #else
        return Font(descriptor: fontDescriptor, size: size)
        #endif
    }
}
#endif
