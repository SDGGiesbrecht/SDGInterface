/*
 CharacterInformation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
import Foundation
#if canImport(CoreGraphics)
import CoreGraphics
#endif
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

import SDGControlFlow
import SDGLogic
import SDGText

import SDGInterfaceBasics
import SDGViews
import SDGTables
import SDGWindows

import SDGInterfaceLocalizations

/// User‐presentable Unicode information about the characters in a string.
public struct CharacterInformation {

    // MARK: - Static Methods

    /// Displays information to the user about the characters in a string.
    ///
    /// - Parameters:
    ///     - characters: The string whose characters should be described.
    ///     - origin: The view and selection the characters originate from. If provided, the information will be shown in a pop‐up view instead of a separate window.
    ///     - view: The view the characters originate from.
    ///     - selection: The rectangle the characters originate from.
    public static func display(for characters: String, origin: (view: View, selection: CGRect?)?) {
        var details: [CharacterInformation] = []
        details.reserveCapacity(characters.scalars.count)
        for scalar in characters.scalars {
            details.append(CharacterInformation(scalar))
        }

        let table = Table<CharacterInformation>(data: Shared(details), columns: [
        { details in
            let codePoint = Label<InterfaceLocalization>(text: .binding(Shared(details.codePoint)))
            codePoint.textColour = details.warningColour
            return codePoint
            },
        { details in
            let codePoint = Label<InterfaceLocalization>(text: .binding(Shared(StrictString(details.character))))
            codePoint.specificNative.stringValue = details.character
            codePoint.textColour = details.warningColour
            return codePoint
            },
        { details in
            return Label<InterfaceLocalization>(text: .binding(Shared(StrictString(details.normalizedCodePoints))))
            },
        { details in
            return Label<InterfaceLocalization>(text: .binding(Shared(StrictString(details.normalizedCharacters))))
            }
            ])

        if let origin = origin {
            let view = _NSUIView()
            #if canImport(AppKit)
            view.frame.size = Window<InterfaceLocalization>.auxiliarySize.native
            #endif
            view.fill(with: table)
            origin.view.displayPopOver(view, sourceRectangle: origin.selection)
        } else {
            #if canImport(AppKit)
            let view = NSView()
            view.fill(with: table)
            let window = Window<InterfaceLocalization>.auxiliaryWindow(
                name: .binding(Shared(StrictString(characters))),
                view: view)
            window.display()
            #endif
        }
    }

    // MARK: - Initialization

    private init(_ character: Unicode.Scalar) {
        self.character = String(character)
        codePoint = character.hexadecimalCode

        normalizedCharacters = String(StrictString(character))
        if normalizedCharacters.unicodeScalars.elementsEqual(self.character.unicodeScalars) {
            normalizedCharacters = ""
        }

        var normalizedCodePointsString = ""
        for scalar in normalizedCharacters.unicodeScalars {
            if ¬normalizedCodePointsString.isEmpty {
                normalizedCodePointsString += " "
            }

            normalizedCodePointsString += scalar.hexadecimalCode
        }
        normalizedCodePoints = normalizedCodePointsString

        if ¬normalizedCharacters.isEmpty {
            if self.character ≠ self.character.decomposedStringWithCompatibilityMapping {
                // Compatibility character.
                warningColour = .red
            } else {
                // Precomposed, but still canonical
                warningColour = .blue
            }
        } else {
            switch character {
            case "\u{22}", "\u{27}", "\u{2D}", "\\", "^", "_", "`", "~":
                warningColour = .yellow // Code‐only ASCII
            default:
                warningColour = .black // Normal
            }
        }

        self.character = character.visibleRepresentation
        let printable = self.normalizedCharacters.unicodeScalars.map { $0.visibleRepresentation }
        self.normalizedCharacters = printable.reduce("") { $0 + $1 }
    }

    // MARK: - Properties

    private let character: String
    private let codePoint: StrictString
    private let normalizedCodePoints: StrictString
    private let normalizedCharacters: StrictString
    private let warningColour: Colour
}
#endif
