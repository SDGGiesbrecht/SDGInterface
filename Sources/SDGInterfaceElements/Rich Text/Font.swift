/*
 Font.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Font {

    // MARK: - System Fonts

    /// The default font.
    public static var `default`: Font {
        return forTextEditing
    }

    #if canImport(AppKit) // #workaround(Temporary.)
    /// The label font.
    public static var forLabels: Font {
        let size: CGFloat
        #if canImport(AppKit)
        size = systemFontSize(for: .regular)
        #else
        #warning("Verify iOS.")
        size = systemFontSize
        #endif
        return systemFont(ofSize: size)
    }
    #endif

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
        return Font(descriptor: fontDescriptor.withSymbolicTraits(.traitBold) ?? fontDescriptor, size: 0)
        #endif
    }

    /// The italic version of `self`.
    public var italic: Font {
        #if canImport(AppKit)
        return NSFontManager.shared.convert(self, toHaveTrait: .italicFontMask)
        #else
        return Font(descriptor: fontDescriptor.withSymbolicTraits(.traitItalic) ?? fontDescriptor, size: 0)
        #endif
    }

    /// The same font in a different size.
    public func resized(to size: CGFloat) -> Font {
        #if canImport(AppKit)
        return NSFontManager.shared.convert(self, toSize: size)
        #else
        return Font(descriptor: fontDescriptor, size: size)
        #endif
    }
}
