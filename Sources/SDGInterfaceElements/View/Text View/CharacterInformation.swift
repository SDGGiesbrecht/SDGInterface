/*
 CharacterInformation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#warning("Rethink binding.")

import SDGLogic

/// User‐presentable Unicode information about the characters in a string.
public class CharacterInformation : NSObject {

    // MARK: - Static Methods

    /// Displays information to the user about the characters in a string.
    public static func display(for characters: String) {
        var details: [CharacterInformation] = []
        details.reserveCapacity(characters.scalars.count)
        for scalar in characters.scalars {
            details.append(CharacterInformation(scalar))
        }

        let window = AuxiliaryWindow(title: StrictString(characters))
        let table = Table(content: details)

        table.newColumn(header: "P", viewGenerator: {
            let view = LabelCell()
            view.bindText(contentKeyPath: CharacterInformation.codePointKeyPath)
            view.bindTextColour(contentKeyPath: CharacterInformation.warningColourPath)
            return view
        })

        table.newColumn(header: "C", viewGenerator: {
            let view = LabelCell()
            view.bindText(contentKeyPath: CharacterInformation.characterKeyPath)
            view.bindTextColour(contentKeyPath: CharacterInformation.warningColourPath)
            return view
        })

        table.newColumn(header: "D", viewGenerator: {
            let view = LabelCell()
            view.bindText(contentKeyPath: CharacterInformation.normalizedCodePointsPath)
            return view
        })

        table.newColumn(header: "S", viewGenerator: {
            let view = LabelCell()
            view.bindText(contentKeyPath: CharacterInformation.normalizedCharacters)
            return view
        })

        table.hasHeader = false
        table.allowsSelection = false

        window.contentView!.fill(with: table)

        window.makeKeyAndOrderFront(nil)
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
            case "\"", "'", "-", "\\", "^", "_", "`", "~":
                warningColour = .yellow // Code‐only ASCII
            default:
                warningColour = .black // Normal
            }
        }

        self.character = character.visibleRepresentation
        let printable = self.normalizedCharacters.unicodeScalars.map { $0.visibleRepresentation }
        self.normalizedCharacters = printable.reduce("") {$0 + $1}
    }

    // MARK: - Properties

    static let characterKeyPath = "character"
    @objc private var character: String

    static let codePointKeyPath = "codePoint"
    @objc private var codePoint: String

    static let normalizedCodePointsPath = "normalizedCodePoints"
    @objc private var normalizedCodePoints: String

    static let normalizedCharacters = "normalizedCharacters"
    @objc private var normalizedCharacters: String

    static let warningColourPath = "warningColour"
    @objc let warningColour: NSColor
}
