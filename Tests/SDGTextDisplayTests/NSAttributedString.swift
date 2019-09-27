/*
 NSAttributedString.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGMathematics
import SDGText

@testable import SDGTextDisplay

extension NSAttributedString {

    // MARK: - Initialization

    #if canImport(AppKit) || canImport(UIKit)
    internal static func from(html: String, font: Font) throws -> NSAttributedString {
        let adjustedFont = font.resized(to: font.size × NSAttributedString.htmlCorrection)
        return try SemanticMarkup._attributedString(from: html, in: adjustedFont)
    }
    #endif
}

 #if canImport(UIKit)
extension SemanticMarkup {

    // #workaround(SDGCornerstone 2.5.1, The upstream version does not handle new iOS text mechanism yet.)
    fileprivate static func _attributedString(from html: String, in font: Font) throws -> NSAttributedString {
        var adjustedFontName = font.fontName

        #if canImport(UIKit)
        if #available(iOS 13, watchOS 6, tvOS 13, *) {
            // Older platforms do not support this CSS, but can use the name directly.
            if adjustedFontName == Font.system.fontName {
                adjustedFontName = "-apple-system"
            }
        }
        #endif

        var modified = "<span style=\u{22}"

        modified += "font\u{2D}family: &#x22;" + adjustedFontName + "&#x22;;"
        modified += "font\u{2D}size: \(font.size)pt;"

        modified += "\u{22}>"
        modified += html
        modified += "</span>"

        let data = modified.data(using: .utf8)!
        return try NSAttributedString(data: data, options: [
            .characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue),
            .documentType: NSAttributedString.DocumentType.html
            ], documentAttributes: nil)
    }
}
#endif
