/*
 MenuBarFormatTextWritingDirection.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#endif

import SDGText
import SDGLocalization

import SDGMenus

import SDGInterfaceLocalizations

extension MenuBar {

    internal static func writingDirection() -> Menu<MenuBarLocalization> {
        let writingDirection = text.Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Sentido de la escritura"
            case .françaisFrance:
                return "Sens de l’écriture"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Writing Direction"
            case .deutschDeutschland:
                return "Richtung beim Schreiben"
            case .ελληνικάΕλλάδα:
                return "Κατεύθυνση γραφής"
            case .עברית־ישראל:
                return "כיווניות הכתיבה"
            }
        })))

        writingDirectionMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Párrafo"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Paragraph"
            case .françaisFrance:
                return "Paragraphe"
            case .ελληνικάΕλλάδα:
                return "Παράγραφος"

            case .deutschDeutschland:
                return "Absatz"
            case .עברית־ישראל:
                return "פיסקה"
            }
        })))

        let `default` = UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Por omisión"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Default"
            case .françaisFrance:
                return "Par défaut"
            case .deutschDeutschland:
                return "Standard"
            case .ελληνικάΕλλάδα:
                return "Προεπιλογή"
            case .עברית־ישראל:
                return "ברירת־המחדל"
            }
        })

        let rightToLeft = UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "De derecha a izquierda"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Right to Left"
            case .deutschDeutschland:
                return "Von rechts nach links"
            case .françaisFrance:
                return "De droite à gauche"
            case .ελληνικάΕλλάδα:
                return "Δεξιά προς αριστερά"
            case .עברית־ישראל:
                return "מימין לשמאל"
            }
        })

        let leftToRight = UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "De izquierda a derecha"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Left to Right"
            case .deutschDeutschland:
                return "Von links nach rechts"
            case .françaisFrance:
                return "De gauche à droite"
            case .ελληνικάΕλλάδα:
                return "Αριστερά προς δεξιά"
            case .עברית־ישראל:
                return "משמאל לימין"
            }
        })

        let paragraphDefault = writingDirectionMenuEntry(label: .static(`default`), action: #selector(NSResponder.makeBaseWritingDirectionNatural(_:)))
        paragraphDefault.indentationLevel = 1

        let paragraphRightToLeft = writingDirectionMenuEntry(label: .static(rightToLeft), action: #selector(NSResponder.makeBaseWritingDirectionRightToLeft(_:)))
        paragraphRightToLeft.indentationLevel = 1

        let paragraphLeftToRight = writingDirectionMenuEntry(label: .static(leftToRight), action: #selector(NSResponder.makeBaseWritingDirectionLeftToRight(_:)))
        paragraphLeftToRight.indentationLevel = 1

        writingDirection.newSeparator()

        writingDirectionMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Selección"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Selection"
            case .françaisFrance:
                return "Sélection"

            case .deutschDeutschland:
                return "Auswahl"
            case .ελληνικάΕλλάδα:
                return "Επιλογή"
            case .עברית־ישראל:
                return "בחירה"
            }
        })))

        let selectionDefault = writingDirectionMenuEntry(label: .static(`default`), action: #selector(NSResponder.makeTextWritingDirectionNatural(_:)))
        selectionDefault.indentationLevel = 1

        let selectionRightToLeft = writingDirectionMenuEntry(label: .static(rightToLeft), action: #selector(NSResponder.makeTextWritingDirectionRightToLeft(_:)))
        selectionRightToLeft.indentationLevel = 1

        let selectionLeftToRight = writingDirectionMenuEntry(label: .static(leftToRight), action: #selector(NSResponder.makeTextWritingDirectionLeftToRight(_:)))
        selectionLeftToRight.indentationLevel = 1
    }
}