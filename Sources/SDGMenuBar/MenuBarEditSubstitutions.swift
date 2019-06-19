/*
 MenuBarEditSubstitutions.swift

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

    internal static func substitutions() -> Menu<MenuBarLocalization> {
        let substitutions = edit.Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Sustituciones"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Substitutions"
            case .françaisFrance:
                return "Substitutions"

            case .deutschDeutschland:
                return "Ersetzungen"
            case .ελληνικάΕλλάδα:
                return "Υποκαταστάσεις"
            case .עברית־ישראל:
                return "החלפות"
            }
        })))

        substitutionsMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Mostrar sustituciones"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Substitutions"
            case .deutschDeutschland:
                return "Ersetzungen einblenden"
            case .françaisFrance:
                return "Afficher les substitutions"
            case .ελληνικάΕλλάδα:
                return "Εμφάνιση υποκαταστάσεων"
            case .עברית־ישראל:
                return "הצג החלפות"
            }
        })), action: #selector(NSTextView.orderFrontSubstitutionsPanel(_:)))

        substitutions.newSeparator()

        substitutionsMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Copiado/pegado inteligente"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Smart Copy/Paste"
            case .deutschDeutschland:
                return "Intelligentes Kopieren/Einsetzen"
            case .françaisFrance:
                return "Copier–coller intelligent"
            case .ελληνικάΕλλάδα:
                return "Έξυπνη αντιγραφή/επικόλληση"
            case .עברית־ישראל:
                return "העתקה והדבקה חכמות"
            }
        })), action: #selector(NSTextView.toggleSmartInsertDelete(_:)))

        substitutionsMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Comillas tipográficas"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Smart Quotes"
            case .deutschDeutschland:
                return "Intelligente Anführungszeichen"
            case .françaisFrance:
                return "Guillemets courbes"
            case .ελληνικάΕλλάδα:
                return "Έξυπνα εισαγωγικά"
            case .עברית־ישראל:
                return "מרכאות חכמות"
            }
        })), action: #selector(NSTextView.toggleAutomaticQuoteSubstitution(_:)))

        substitutionsMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Guiones inteligentes"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Smart Dashes"
            case .deutschDeutschland:
                return "Intelligente Bindestriche"
            case .françaisFrance:
                return "Tirets intelligents"
            case .ελληνικάΕλλάδα:
                return "Έξυπνες παύλες"
            case .עברית־ישראל:
                return "מיקוף חכם"
            }
        })), action: #selector(NSTextView.toggleAutomaticDashSubstitution(_:)))

        substitutionsMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Enlaces inteligentes"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Smart Links"
            case .deutschDeutschland:
                return "Intellingente Links"
            case .françaisFrance:
                return "Liens intelligents"
            case .ελληνικάΕλλάδα:
                return "Έξυπνοι σύνδεσμοι"
            case .עברית־ישראל:
                return "קישורים חכמים"
            }
        })), action: #selector(NSTextView.toggleAutomaticLinkDetection(_:)))

        substitutionsMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Detectores de datos"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Data Detectors"

            case .deutschDeutschland:
                return "Datenerkennung"
            case .françaisFrance:
                return "Détection de données"
            case .ελληνικάΕλλάδα:
                return "Ανίχνευση δεδομένων"
            case .עברית־ישראל:
                return "גלאי נתונים"
            }
        })), action: #selector(NSTextView.toggleAutomaticDataDetection(_:)))

        substitutionsMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Reemplazar texto"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Text Replacement"
            case .françaisFrance:
                return "Remplacement de texte"
            case .deutschDeutschland:
                return "Text ersetzen"
            case .ελληνικάΕλλάδα:
                return "Αντικατάσταση κειμένου"
            case .עברית־ישראל:
                return "החלפת מלל"
            }
        })), action: #selector(NSTextView.toggleAutomaticTextReplacement(_:)))
    }
}
