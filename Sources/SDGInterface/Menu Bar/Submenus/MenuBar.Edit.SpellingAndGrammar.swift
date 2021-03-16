/*
 MenuBar.Edit.SpellingAndGrammar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

  extension MenuBar {

    private static func showSpellingAndGrammar() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: ":",
        selector: #selector(NSText.showGuessPanel(_:))
      )
    }

    private static func checkDocumentNow() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: ";",
        selector: #selector(NSText.checkSpelling(_:))
      )
    }

    private static func checkSpellingWhileTyping() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        selector: #selector(NSTextView.toggleContinuousSpellChecking(_:))
      )
    }

    private static func checkGrammarWithSpelling() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        selector: #selector(NSTextView.toggleGrammarChecking(_:))
      )
    }

    private static func correctSpellingAutomatically() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        selector: #selector(NSTextView.toggleAutomaticSpellingCorrection(_:))
      )
    }

    internal static func spellingAndGrammar() -> Menu<
      MenuBarLocalization,
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
              >, Divider
            >, MenuEntry<MenuBarLocalization>
          >, MenuEntry<MenuBarLocalization>
        >, MenuEntry<MenuBarLocalization>
      >
    > {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        entries: {
          return MenuComponentsBuilder.buildBlock(
            showSpellingAndGrammar(),
            checkDocumentNow(),
            Divider(),
            checkSpellingWhileTyping(),
            checkGrammarWithSpelling(),
            correctSpellingAutomatically()
          )
        }
      )
    }
  }
#endif
