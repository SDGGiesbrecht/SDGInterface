/*
 MenuBar.Edit.Substitutions.swift

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

    private static func showSubstitutions() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        selector: #selector(NSTextView.orderFrontSubstitutionsPanel(_:))
      )
    }

    private static func smartCopyPaste() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        selector: #selector(NSTextView.toggleSmartInsertDelete(_:))
      )
    }

    private static func smartQuotes() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        selector: #selector(NSTextView.toggleAutomaticQuoteSubstitution(_:))
      )
    }

    private static func smartDashes() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        selector: #selector(NSTextView.toggleAutomaticDashSubstitution(_:))
      )
    }

    private static func smartLinks() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        selector: #selector(NSTextView.toggleAutomaticLinkDetection(_:))
      )
    }

    private static func dataDetectors() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        selector: #selector(NSTextView.toggleAutomaticDataDetection(_:))
      )
    }

    private static func textReplacement() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        selector: #selector(NSTextView.toggleAutomaticTextReplacement(_:))
      )
    }

    internal static func substitutions() -> Menu<
      MenuBarLocalization,
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<
                  MenuComponentsConcatenation<MenuEntry<MenuBarLocalization>, Divider>,
                  MenuEntry<MenuBarLocalization>
                >, MenuEntry<MenuBarLocalization>
              >, MenuEntry<MenuBarLocalization>
            >, MenuEntry<MenuBarLocalization>
          >, MenuEntry<MenuBarLocalization>
        >, MenuEntry<MenuBarLocalization>
      >
    > {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        entries: {
          showSubstitutions()
          Divider()
          smartCopyPaste()
          smartQuotes()
          smartDashes()
          smartLinks()
          dataDetectors()
          textReplacement()
        }
      )
    }
  }
#endif
