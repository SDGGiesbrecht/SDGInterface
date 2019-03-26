/*
 NSAttributedString.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) // #workaround(Temporary.)
import Foundation

import SDGMathematics
import SDGText

@testable import SDGInterfaceElements

extension NSAttributedString {

    // MARK: - Initialization

    internal convenience init?(html: String, font: Font) {
        let adjustedFont = font.resized(to: font.pointSize × NSAttributedString.htmlCorrection)

        #warning("Share with SemanticMarkup?")
        var modified = "<span style=\u{22}"

        modified += "font\u{2D}family: &#x22;" + adjustedFont.fontName + "&#x22;;"
        modified += "font\u{2D}size: \(adjustedFont.pointSize)pt;"

        modified += "\u{22}>"
        modified += html
        modified += "</span>"

        self.init(html: modified.file, options: [.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}
#endif
