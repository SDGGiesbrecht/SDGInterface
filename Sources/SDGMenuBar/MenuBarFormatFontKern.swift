/*
 MenuBarFormatFontKern.swift

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

    internal static func kern() -> Menu<MenuBarLocalization> {
        let kern = font.Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Interletraje"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Kern"
            case .françaisFrance:
                return "Crénage"

            case .deutschDeutschland:
                return "Zeichenabstand"
            case .ελληνικάΕλλάδα:
                return "Διαγραμμάτωση"
            case .עברית־ישראל:
                return "מרווח בין אותיות"
            }
        })))

        kernMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Valor por omisión"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use Default"
            case .deutschDeutschland:
                return "Normal"
            case .françaisFrance:
                return "Valeur par défaut"
            case .ελληνικάΕλλάδα:
                return "Χρήση προεπιλογής"
            case .עברית־ישראל:
                return "השתמש בברירת המחדל"
            }
        })), action: #selector(NSTextView.useStandardKerning(_:)))

        kernMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Ninguno"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use None"
            case .deutschDeutschland:
                return "Nicht verwenden"
            case .françaisFrance:
                return "Aucun"
            case .ελληνικάΕλλάδα:
                return "Καμία"
            case .עברית־ישראל:
                return "אל תשתמש בשום אפשרות"
            }
        })), action: #selector(NSTextView.turnOffKerning(_:)))

        kernMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Reducir"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Tighten"
            case .deutschDeutschland:
                return "Enger"
            case .françaisFrance:
                return "Resserrer"
            case .ελληνικάΕλλάδα:
                return "Πιο κοντά"
            case .עברית־ישראל:
                return "הדוק יותר"
            }
        })), action: #selector(NSTextView.tightenKerning(_:)))

        kernMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Aumentar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Loosen"
            case .deutschDeutschland:
                return "Weiter"
            case .françaisFrance:
                return "Desserrer"
            case .ελληνικάΕλλάδα:
                return "Πιο αραιά"
            case .עברית־ישראל:
                return "מרווח יותר"
            }
        })), action: #selector(NSTextView.loosenKerning(_:)))
    }
}