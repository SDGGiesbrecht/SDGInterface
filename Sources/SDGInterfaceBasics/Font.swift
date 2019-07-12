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
#endif
#if canImport(UIKit)
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
        return Font(NSFont.systemFont(ofSize: NSFont.systemFontSize(for: .regular)))
        #else
        return preferredFont(forTextStyle: .headline)
        #endif
    }

    /// The default font for text editing.
    public static var forTextEditing: Font {
        var user: Font?
        #if canImport(AppKit)
        user = NSFont.userFont(ofSize: NSFont.systemFontSize).map { Font($0) }
        #endif
        return user ?? system // @exempt(from: tests) Unknown why it would ever be nil on macOS.
    }

    // MARK: - Modified Versions

    /// The bold version of `self`.
    public var bold: Font {
        #if canImport(AppKit)
        return Font(NSFontManager.shared.convert(native, toHaveTrait: .boldFontMask))
        #else
        let descriptor = fontDescriptor.withSymbolicTraits(.traitBold) ?? fontDescriptor // @exempt(from: tests) Unknown why the descriptor would be nil.
        return Font(descriptor: descriptor, size: 0)
        #endif
    }

    /// The italic version of `self`.
    public var italic: Font {
        #if canImport(AppKit)
        return Font(NSFontManager.shared.convert(native, toHaveTrait: .italicFontMask))
        #else
        let descriptor = fontDescriptor.withSymbolicTraits(.traitItalic) ?? fontDescriptor // @exempt(from: tests) Unknown why the descriptor would be nil.
        return Font(descriptor: descriptor, size: 0)
        #endif
    }

    /// The same font in a different size.
    ///
    /// - Parameters:
    ///     - size: The new point size.
    public func resized(to size: Double) -> Font {
        #if canImport(AppKit)
        return Font(NSFontManager.shared.convert(native, toSize: CGFloat(size)))
        #else
        return Font(descriptor: fontDescriptor, size: CGFloat(size))
        #endif
    }
}
#endif
