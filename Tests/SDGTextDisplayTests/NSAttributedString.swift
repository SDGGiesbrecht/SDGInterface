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
        let adjustedFont = font.resized(to: font.pointSize × NSAttributedString.htmlCorrection)
        return try SemanticMarkup._attributedString(from: html, in: adjustedFont)
    }
    #endif
}
