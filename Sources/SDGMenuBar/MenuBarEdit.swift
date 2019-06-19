/*
 MenuBarEdit.swift

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

    private static func undo() -> MenuEntry<MenuBarLocalization> {
        let undo = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Deshacer"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Undo"
            case .deutschDeutschland:
                return "Widerrufen"
            case .françaisFrance:
                return "Annuler"
            case .ελληνικάΕλλάδα:
                return "Αναίρεση"
            case .עברית־ישראל:
                return "בטל"
            }
        })))
        undo.action = Selector.undo
        undo.hotKey = "z"
        undo.hotKeyModifiers = .command
        return undo
    }

    private static func redo() -> MenuEntry<MenuBarLocalization> {
        let redo = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Rehacer"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Redo"
            case .deutschDeutschland:
                return "Wiederholen"
            case .françaisFrance:
                return "Rétablir"
            case .ελληνικάΕλλάδα:
                return "Επανάληψη"
            case .עברית־ישראל:
                return "חזור על הפעולה האחרונה"
            }
        })), action: #selector(Responder.redo(_:)))
        redo.hotKey = "Z"
        redo.hotKeyModifiers = .command
        return redo
    }

    private static func cut() -> MenuEntry<MenuBarLocalization> {
        let cut = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Cortar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Cut"
            case .deutschDeutschland:
                return "Ausschneiden"
            case .françaisFrance:
                return "Couper"
            case .ελληνικάΕλλάδα:
                return "Αποκοπή"
            case .עברית־ישראל:
                return "גזור"
            }
        })), action: #selector(NSText.cut(_:)))
        cut.hotKey = "x"
        cut.hotKeyModifiers = .command
    }

    private static func copy() -> MenuEntry<MenuBarLocalization> {
        let copy = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Copiar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Copy"
            case .deutschDeutschland:
                return "Kopieren"
            case .françaisFrance:
                return "Copier"

            case .ελληνικάΕλλάδα:
                return "Αντιγραφή"
            case .עברית־ישראל:
                return "העתק"
            }
        })), action: #selector(NSText.copy(_:)))
        copy.hotKey = "c"
        copy.hotKeyModifiers = .command
    }

    private static func paste() -> MenuEntry<MenuBarLocalization> {
        let paste = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Pegar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Paste"
            case .deutschDeutschland:
                return "Einsetzen"

            case .françaisFrance:
                return "Coller"
            case .ελληνικάΕλλάδα:
                return "Επικόλληση"

            case .עברית־ישראל:
                return "הדבק"
            }
        })), action: #selector(NSText.paste(_:)))
        paste.hotKey = "v"
        paste.hotKeyModifiers = .command
        return paste
    }

    private static func pasteAndMatchStyle() -> MenuEntry<MenuBarLocalization> {
        let pasteAndMatchStyle = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Pegar con el mismo estilo"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Paste & Match Style"
            case .deutschDeutschland:
                return "Einsetzen und Stil anpassen"
            case .françaisFrance:
                return "Coller et adapter le style"
            case .ελληνικάΕλλάδα:
                return "Επικόλληση και αντιστοίχιση στιλ"
            case .עברית־ישראל:
                return "הדבק והתאם לסגנון"
            }
        })), action: #selector(NSTextView.pasteAsPlainText(_:)))
        pasteAndMatchStyle.hotKey = "V"
        pasteAndMatchStyle.hotKeyModifiers = [.command, .option]
    }

    private static func delete() -> MenuEntry<MenuBarLocalization> {
        MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Eliminar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Delete"
            case .deutschDeutschland:
                return "Löschen"
            case .françaisFrance:
                return "Supprimer"
            case .ελληνικάΕλλάδα:
                return "Διαγραφή"
            case .עברית־ישראל:
                return "מחק"
            }
        })), action: #selector(NSText.delete(_:)))
    }

    private static func selectAll() -> MenuEntry<MenuBarLocalization> {
        let selectAll = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Seleccionar todo"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Select All"
            case .deutschDeutschland:
                return "Alles auswählen"
            case .françaisFrance:
                return "Tout sélectionner"
            case .ελληνικάΕλλάδα:
                return "Επιλογή όλων"
            case .עברית־ישראל:
                return "בחר הכל"
            }
        })), action: #selector(NSResponder.selectAll(_:)))
        selectAll.hotKey = "a"
        selectAll.hotKeyModifiers = .command
    }

    internal static func edit() -> Menu<MenuBarLocalization> {
        let edit = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Edición"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Edit"
            case .françaisFrance:
                return "Édition"
            case .deutschDeutschland:
                return "Bearbeiten"
            case .ελληνικάΕλλάδα:
                return "Επεξεργασία"
            case .עברית־ישראל:
                return "עריכה"
            }
        })))
        edit.entries = [
            .entry(undo()),
            .entry(redo()),
            .separator,
            .entry(cut()),
            .entry(copy()),
            .entry(paste()),
            .entry(pasteAndMatchStyle()),
            .entry(delete()),
            .entry(selectAll()),
            .separator
        ]
        return edit
    }

    private func initializeEditMenu() {



        let spellingAndGrammar = edit.Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        let showSpellingAndGrammar = spellingAndGrammarMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.showGuessPanel(_:)))
        showSpellingAndGrammar.hotKey = ":"
        showSpellingAndGrammar.hotKeyModifiers = .command

        let checkDocumentNow = spellingAndGrammarMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.checkSpelling(_:)))
        checkDocumentNow.hotKey = ";"
        checkDocumentNow.hotKeyModifiers = .command

        spellingAndGrammar.newSeparator()

        spellingAndGrammarMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.toggleContinuousSpellChecking(_:)))

        spellingAndGrammarMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.toggleGrammarChecking(_:)))

        spellingAndGrammarMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.toggleAutomaticSpellingCorrection(_:)))

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

        let transformations = edit.Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Transformaciones"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                 .françaisFrance:
                return "Transformations"
            case .deutschDeutschland:
                return "Transformationen"

            case .ελληνικάΕλλάδα:
                return "Μετασχηματισμοί"
            case .עברית־ישראל:
                return "המרות"
            }
        })))

        transformations.newEntry(labelled: MenuLabels.normalizeText, action: #selector(NSTextView.normalizeText(_:)))

        // “Make Upper Case” does not belong here. Upper‐case‐only is a font style, not a semantic aspect of the text. Attempting to fake it by switching to capital letters (a) results in semantically incorrect text, and (b) is irreversable. A font‐based version is available under the “Font” menu instead.

        // “Make Lower Case” is never useful. Instead, reversion from an upper‐case‐only font style to normally cased font—which preserves true capitals—is available under the “Font” menu.

        // “Capitalize” is just not possible for a machine to do properly in any language.

        edit.newEntry(labelled: MenuLabels.showCharacterInformation, action: #selector(NSTextView.showCharacterInformation(_:)))

        let speech = edit.Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Habla"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Speech"
            case .deutschDeutschland:
                return "Sprachausgabe"

            case .françaisFrance:
                return "Parole"
            case .ελληνικάΕλλάδα:
                return "Εκφώνηση"
            case .עברית־ישראל:
                return "דיבור"
            }
        })))

        speechMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Iniciar locución"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Start Speaking"
            case .deutschDeutschland:
                return "Sprachausgabe starten"
            case .françaisFrance:
                return "Commencer la lecture"
            case .ελληνικάΕλλάδα:
                return "Έναρξη εκφώνησης"
            case .עברית־ישראל:
                return "התחל לדבר"
            }
        })), action: #selector(NSTextView.startSpeaking(_:)))

        speechMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Detener locución"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Stop Speaking"
            case .deutschDeutschland:
                return "Sprachausgabe stoppen"
            case .françaisFrance:
                return "Arrêter la lecture"
            case .ελληνικάΕλλάδα:
                return "Διακοπή εκφώνησης"
            case .עברית־ישראל:
                return "הפסק לדבר"
            }
        })), action: #selector(NSTextView.stopSpeaking(_:)))
    }
}
