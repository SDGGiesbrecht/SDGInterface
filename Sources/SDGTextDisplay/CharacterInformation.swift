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

import SDGLogic
import SDGText

import SDGInterfaceBasics
import SDGViews

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

        let table = Table(content: details)

        #if canImport(AppKit)
        table.newColumn(header: "", viewGenerator: {
            let view = LabelCell<InterfaceLocalization>()
            view.bindText(contentKeyPath: CharacterInformation.codePointKeyPath)
            view.bindTextColour(contentKeyPath: CharacterInformation.warningColourPath)
            return view
        })

        table.newColumn(header: "", viewGenerator: {
            let view = LabelCell<InterfaceLocalization>()
            view.bindText(contentKeyPath: CharacterInformation.characterKeyPath)
            view.bindTextColour(contentKeyPath: CharacterInformation.warningColourPath)
            return view
        })

        table.newColumn(header: "", viewGenerator: {
            let view = LabelCell<InterfaceLocalization>()
            view.bindText(contentKeyPath: CharacterInformation.normalizedCodePointsPath)
            return view
        })

        table.newColumn(header: "", viewGenerator: {
            let view = LabelCell<InterfaceLocalization>()
            view.bindText(contentKeyPath: CharacterInformation.normalizedCharactersPath)
            return view
        })
        #else
        table.cellStyle = .value1
        table.cellUpdator = { cell, value in
            // @exempt(from: tests) The operating system skips this call when the table is off‐screen.
            if let characterInformation = value as? CharacterInformation {
                cell.textLabel?.text = characterInformation.codePoint + " " + characterInformation.character
                cell.textLabel?.textColor = characterInformation.warningColour
                cell.detailTextLabel?.text = characterInformation.normalizedCodePoints + " " + characterInformation.normalizedCharacters
                cell.detailTextLabel?.textColor = .black
            }
        }
        #endif

        #if canImport(AppKit)
        table.hasHeader = false
        #endif
        table.allowsSelection = false

        if let origin = origin {
            let view = NativeView()
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
    private let codePoint: String
    private let normalizedCodePoints: String
    private let normalizedCharacters: String
    private let warningColour: Colour
}
#endif