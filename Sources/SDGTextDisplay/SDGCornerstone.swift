/*
 SDGCornerstone.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit)
import Foundation

import SDGText

extension SemanticMarkup {

    // #workaround(SDGCornerstone 2.5.1, The upstream version does not handle new iOS text mechanism yet.)
    internal func richText(font: Font) -> NSAttributedString {
        #warning("Is this necessary?")
        do {
            return try SemanticMarkup._attributedString(from: String(html()), in: font)
        } catch {
            preconditionFailure(error.localizedDescription)
        }
    }

    // #workaround(SDGCornerstone 2.5.1, The upstream version does not handle new iOS text mechanism yet.)
    private static func _attributedString(from html: String, in font: Font) throws -> NSAttributedString {
        #warning("Can this be merged with the one in tests?")
        var adjustedFontName = font.fontName

        if #available(iOS 13, watchOS 6, tvOS 13, *) { // @exempt(from: unicode)
            // Older platforms do not support this CSS, but can use the name directly.
            if adjustedFontName == Font.system.fontName {
                adjustedFontName = "-apple-system"
            }
        }

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
