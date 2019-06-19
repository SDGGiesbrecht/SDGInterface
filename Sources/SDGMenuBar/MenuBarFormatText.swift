/*
 MenuBarFormatText.swift

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

    internal static func text() -> Menu<MenuBarLocalization> {
        let text = format.Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Texto"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                 .deutschDeutschland:
                return "Text"
            case .françaisFrance:
                return "Texte"
            case .ελληνικάΕλλάδα:
                return "Κείμενο"
            case .עברית־ישראל:
                return "מלל"
            }
        })))

        let alignRight = textMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Alinear a la derecha"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Align Right"
            case .deutschDeutschland:
                return "Rechtsbündig"
            case .françaisFrance:
                return "Aligner à droite"
            case .ελληνικάΕλλάδα:
                return "Στοίχιση δεξιά"
            case .עברית־ישראל:
                return "יישר לימין"
            }
        })), action: #selector(NSText.alignRight(_:)))
        alignRight.hotKey = "}"
        alignRight.hotKeyModifiers = .command

        let centre = textMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Centrar"
            case .englishUnitedKingdom, .englishCanada:
                return "Centre"
            case .englishUnitedStates:
                return "Center"
            case .deutschDeutschland:
                return "Zentriert"
            case .françaisFrance:
                return "Centrer"
            case .ελληνικάΕλλάδα:
                return "Κεντράρισμα"

            case .עברית־ישראל:
                return "מרכז"
            }
        })), action: #selector(NSText.alignCenter(_:)))
        centre.hotKey = "|"
        centre.hotKeyModifiers = .command

        textMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Justificar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Justify"
            case .françaisFrance:
                return "Justifier"

            case .deutschDeutschland:
                return "Blocksatz"
            case .ελληνικάΕλλάδα:
                return "Πλήρης στοίχιση"
            case .עברית־ישראל:
                return "יישר לשני הצדדים"
            }
        })), action: #selector(NSTextView.alignJustified(_:)))

        let alignLeft = textMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Alinear a la izquierda"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Align Left"
            case .deutschDeutschland:
                return "Linksbündig"
            case .françaisFrance:
                return "Aligner à gauche"
            case .ελληνικάΕλλάδα:
                return "Στοίχιση αριστερά"
            case .עברית־ישראל:
                return "יישר לשמאל"
            }
        })), action: #selector(NSText.alignLeft(_:)))
        alignLeft.hotKey = "{"
        alignLeft.hotKeyModifiers = .command

        text.newSeparator()

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

        text.newSeparator()

        textMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Mostrar regla"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Ruler"
            case .deutschDeutschland:
                return "Lineal einblenden"
            case .françaisFrance:
                return "Afficher la règle"
            case .ελληνικάΕλλάδα:
                return "Εμφάνιση χάρακα"
            case .עברית־ישראל:
                return "הצג סרגל"
            }
        })), action: #selector(NSText.toggleRuler(_:)))

        let copyRuler = textMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Copiar regla"
            case .françaisFrance:
                return "Copier la règle"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Copy Ruler"
            case .deutschDeutschland:
                return "Lineal kopieren"
            case .ελληνικάΕλλάδα:
                return "Αντιγραφή χάρακα"
            case .עברית־ישראל:
                return "העתק סרגל"
            }
        })), action: #selector(NSText.copyRuler(_:)))
        copyRuler.hotKey = "c"
        copyRuler.hotKeyModifiers = [.command, .control]

        let pasteRuler = textMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Pegar regla"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Paste Ruler"
            case .deutschDeutschland:
                return "Lineal einsetzen"
            case .françaisFrance:
                return "Coller la règle"
            case .ελληνικάΕλλάδα:
                return "Επικόλληση χάρακα"
            case .עברית־ישראל:
                return "הדבק סרגל"
            }
        })), action: #selector(NSText.pasteRuler(_:)))
        pasteRuler.hotKey = "v"
        pasteRuler.hotKeyModifiers = [.command, .control]
    }
}
