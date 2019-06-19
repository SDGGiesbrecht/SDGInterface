/*
 MenuBarEditSpellingAndGrammar.swift

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

    private static func showSpellingAndGrammar() -> MenuEntry<MenuBarLocalization> {
        let showSpellingAndGrammar = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Mostrar ortografía y gramática"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Spelling & Grammar"
            case .deutschDeutschland:
                return "Rechtschreibung und Grammatik einblenden"
            case .françaisFrance:
                return "Afficher l’orthographe et la grammaire"
            case .ελληνικάΕλλάδα:
                return "Εμφάνιση ορθογραφίας και γραμματικής"
            case .עברית־ישראל:
                return "הצג איות ודקדוק"
            }
        })))
        showSpellingAndGrammar.action = #selector(NSText.showGuessPanel(_:))
        showSpellingAndGrammar.hotKey = ":"
        showSpellingAndGrammar.hotKeyModifiers = .command
        return showSpellingAndGrammar
    }

    private static func checkDocumentNow() -> MenuEntry<MenuBarLocalization> {
        let checkDocumentNow = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Comprobar documento ahora"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Check Document Now"
            case .deutschDeutschland:
                return "Dokument jetzt prüfen"
            case .françaisFrance:
                return "Vérifier le document maintenant"
            case .ελληνικάΕλλάδα:
                return "Έλεγχος εγγράφου τώρα"
            case .עברית־ישראל:
                return "בדוק את המסמך כעת"
            }
        })))
        checkDocumentNow.action = #selector(NSText.checkSpelling(_:))
        checkDocumentNow.hotKey = ";"
        checkDocumentNow.hotKeyModifiers = .command
        return checkDocumentNow
    }

    private static func checkSpellingWhileTyping() -> MenuEntry<MenuBarLocalization> {
        let checkSpellingWhileTyping = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Comprobar ortografía mientras se escribe"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Check Spelling While Typing"
            case .deutschDeutschland:
                return "Während der Texteingabe prüfen"
            case .françaisFrance:
                return "Vérifier l’orthographe lors de la saisie"
            case .ελληνικάΕλλάδα:
                return "Έλεγχος ορθογραφίας κατά την πληκτρολόγηση"
            case .עברית־ישראל:
                return "בדוק איות תוך כדי הקלדה"
            }
        })))
        checkSpellingWhileTyping.action = #selector(NSTextView.toggleContinuousSpellChecking(_:))
        return checkSpellingWhileTyping
    }

    private static func checkGrammarWithSpelling() -> MenuEntry<MenuBarLocalization> {
        let checkGrammarWithSpelling = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Comprobar gramática con la ortografía"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Check Grammar with Spelling"
            case .deutschDeutschland:
                return "Rechtschreib‐ und Grammatikprüfung"
            case .françaisFrance:
                return "Vérifier la grammaire et l’orthographe"
            case .ελληνικάΕλλάδα:
                return "Έλεγχος γραμματικής και ορθογραφίας"
            case .עברית־ישראל:
                return "בדוק דקדוק ביחד עם איות"
            }
        })))
        checkGrammarWithSpelling.action = #selector(NSTextView.toggleGrammarChecking(_:))
        return checkGrammarWithSpelling
    }

    private static func correctSpellingAutomatically() -> MenuEntry<MenuBarLocalization> {
        let correctSpellingAutomatically = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Corregir ortografía automáticamente"
            case .françaisFrance:
                return "Corriger l’orthographe automatiquement"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Correct Spelling Automatically"
            case .deutschDeutschland:
                return "Rechtschreibung automatisch korrigieren"
            case .ελληνικάΕλλάδα:
                return "Αυτόματη διόρθωση ορθογραφίας"
            case .עברית־ישראל:
                return "תקן איות באופן אוטומטי"
            }
        })))
        correctSpellingAutomatically.action = #selector(NSTextView.toggleAutomaticSpellingCorrection(_:))
        return correctSpellingAutomatically
    }

    internal static func spellingAndGrammar() -> Menu<MenuBarLocalization> {
        let spellingAndGrammar = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Ortografía y gramática"
            case .françaisFrance:
                return "Orthographe et grammaire"
            case .ελληνικάΕλλάδα:
                return "Ορθογραφία και γραμματική"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Spelling & Grammar"
            case .deutschDeutschland:
                return "Rechtschreibung und Grammatik"
            case .עברית־ישראל:
                return "איות ודקדוק"
            }
        })))
        spellingAndGrammar.entries = [
            .entry(showSpellingAndGrammar()),
            .entry(checkDocumentNow()),
            .separator,
            .entry(checkSpellingWhileTyping()),
            .entry(checkGrammarWithSpelling()),
            .entry(correctSpellingAutomatically())
        ]
        return spellingAndGrammar
    }
}
