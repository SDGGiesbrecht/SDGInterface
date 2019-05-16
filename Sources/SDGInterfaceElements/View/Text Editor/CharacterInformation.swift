/*
 CharacterInformation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import SDGInterfaceLocalizations

/// User‐presentable Unicode information about the characters in a string.
public class CharacterInformation : NSObject {

    // MARK: - Static Methods

    /// Displays information to the user about the characters in a string.
    ///
    /// - Parameters:
    ///     - characters: The string whose characters should be described.
    public static func display(for characters: String, sender: View?) {
        var details: [CharacterInformation] = []
        details.reserveCapacity(characters.scalars.count)
        for scalar in characters.scalars {
            details.append(CharacterInformation(scalar))
        }

        // #workaround(Unify?)
        #if canImport(AppKit)
        let window = AuxiliaryWindow(title: Shared(UserFacing<StrictString, InterfaceLocalization>({ _ in StrictString(characters) })))
        let table = Table(content: details)

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
            view.bindText(contentKeyPath: CharacterInformation.normalizedCharacters)
            return view
        })

        table.hasHeader = false
        table.allowsSelection = false

        window.contentView!.fill(with: table)

        window.makeKeyAndOrderFront(nil)
        #else
        // #workaround(Centralize utilities.)
        #warning("Does nothing.")
        print("Showing character information...")

        let controller = UIViewController()
        currentPopup = controller
        controller.modalPresentationStyle = .popover

        class Delegate : NSObject, UIPopoverPresentationControllerDelegate {
            func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
                return .none
            }
        }
        let delegate = Delegate()
        currentPopupDelegate = delegate

        let popOver = controller.popoverPresentationController
        currentPopupPresentationController = popOver
        popOver?.delegate = delegate
        popOver?.sourceView = sender
        popOver?.sourceRect = CGRect(x: 150, y: 300, width: 1, height: 1)
        popOver?.permittedArrowDirections = .any

        let view = View()
        currentPopupView = view
        controller.view = view
        view.fill(with: Label(text: Shared(UserFacing<StrictString, InterfaceLocalization>({ _ in "Test" }))))

        // #workaround(iOS?)
        var responder: UIResponder? = sender
        var viewController: UIViewController?
        while responder ≠ nil {
            responder = responder!.next
            if let cast = responder as? UIViewController {
                viewController = cast
                break
            }
        }
        viewController?.present(controller, animated: true, completion: nil)
        #endif
    }
    // #workaround(Is this needed?)
    private static var currentPopup: UIViewController?
    private static var currentPopupView: UIView?
    private static var currentPopupDelegate: Any?
    private static var currentPopupPresentationController: Any?

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

    static let characterKeyPath = "character"
    @objc private var character: String

    static let codePointKeyPath = "codePoint"
    @objc private var codePoint: String

    static let normalizedCodePointsPath = "normalizedCodePoints"
    @objc private var normalizedCodePoints: String

    static let normalizedCharacters = "normalizedCharacters"
    @objc private var normalizedCharacters: String

    static let warningColourPath = "warningColour"
    @objc let warningColour: Colour
}
