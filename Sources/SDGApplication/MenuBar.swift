/*
 MenuBar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
// MARK: - #if canImport(AppKit)

import SDGInterfaceLocalizations

/// An application’s menu bar.
///
/// `MenuBar` is a fully localized version of Interface Builder’s template with several useful additions.
///
/// “Preferences...” is hidden unless the `preferencesAction` property is set.
///
/// The “Help” menu is hidden unless a help book is specified in the application’s `Info.plist` file.
public class MenuBar : LocalizedMenu<InterfaceLocalization> {

    // MARK: - Class Properties

    /// The menu bar.
    public static let menuBar: MenuBar = MenuBar()

    // MARK: - Initialization

    private init() {
        super.init(label: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Menu Bar"
            }
        })))

        initializeApplicationMenu()
        initializeFileMenu()
        initializeEditMenu()
        initializeFormatMenu()
        initializeViewMenu()
        initializeWindowMenu()
        initializeHelpMenu()
    }

    // MARK: - Properties

    private var endOfPreferenceSection: NSMenuItem!
    private var endOfCustomMenuSection: NSMenuItem!

    // MARK: - Modification

    @discardableResult public func newApplicationSpecificSubmenu<S>(labelled label: Shared<UserFacing<StrictString, S>>) -> LocalizedMenu<S> {
        let menu = newSubmenu(labelled: label)
        if let menuItem = menu.parentMenuItem {
            removeItem(menuItem)
            let insertIndex = index(of: endOfCustomMenuSection)
            insertItem(menuItem, at: insertIndex)
        }
        return menu
    }

    // MARK: - Items

    private func initializeApplicationMenu() {
        let application = newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            // #workaround(Should detect actual application name.)
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Application"
            }
        })))

        application.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            // #workaround(Should include the application name.)
            case .españolEspaña:
                return "Acerca"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "About"
            case .deutschDeutschland:
                return "Über"
            case .françaisFrance:
                return "À propos"
            case .ελληνικάΕλλάδα:
                return "Πληροφορίες"
            case .עברית־ישראל:
                return "אותות"
            }
        })), action: #selector(Application.orderFrontStandardAboutPanel(_: )))

        application.newSeparator()

        let preferences = application.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Preferencias..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Preferences..."
            case .françaisFrance:
                return "Préférences..."

            case .deutschDeutschland:
                return "Einstellungen ..."
            case .ελληνικάΕλλάδα:
                return "Προτιμήσεις..."
            case .עברית־ישראל:
                return "העדפות..."
            }
        })))
        preferences.action = #selector(ApplicationDelegate.openPreferences(_: ))
        preferences.keyEquivalent = ","
        preferences.keyEquivalentModifierMask = .command

        endOfPreferenceSection = application.newSeparator()

        let services = application.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Servicios"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                .françaisFrance:
                return "Services"
            case .deutschDeutschland:
                return "Dienste"
            case .ελληνικάΕλλάδα:
                return "Υπηρεσίες"
            case .עברית־ישראל:
                return "שירותים"
            }
        })))
        Application.shared.servicesMenu = services

        application.newSeparator()

        let hide = application.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            // #workaround(Should include the application name.)
            case .españolEspaña:
                return "Ocultar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Hide"
            case .deutschDeutschland:
                return "Ausblenden"
            case .françaisFrance:
                return "Masquer"
            case .ελληνικάΕλλάδα:
                return "Απόκρυψη"
            case .עברית־ישראל:
                return "הסתר"
            }
        })), action: #selector(Application.hide(_: )))
        hide.keyEquivalent = "h"
        hide.keyEquivalentModifierMask = .command

        let hideOthers = application.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Ocultar otros"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Hide Others"
            case .deutschDeutschland:
                return "Andere ausblenden"
            case .françaisFrance:
                return "Masquer les autres"
            case .ελληνικάΕλλάδα:
                return "Απόκρυψη άλλων"
            case .עברית־ישראל:
                return "הסתר אחרים"
            }
        })), action: #selector(Application.hideOtherApplications(_: )))
        hideOthers.keyEquivalent = "h"
        hideOthers.keyEquivalentModifierMask = [.option, .command]

        application.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Mostrar todo"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show All"
            case .deutschDeutschland:
                return "Alle einblenden"
            case .françaisFrance:
                return "Tout afficher"
            case .ελληνικάΕλλάδα:
                return "Εμφάνιση όλων"
            case .עברית־ישראל:
                return "הצג הכול"
            }
        })), action: #selector(Application.unhideAllApplications(_: )))

        application.newSeparator()

        let quit = application.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            // #workaround(Should include the application name.)
            case .españolEspaña:
                return "Salir"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Quit"
            case .françaisFrance:
                return "Quitter"

            case .deutschDeutschland:
                return "Beenden"
            case .ελληνικάΕλλάδα:
                return "Τερματισμός"
            case .עברית־ישראל:
                return "סיים"
            }
        })), action: #selector(Application.terminate(_: )))
        quit.keyEquivalent = "q"
        quit.keyEquivalentModifierMask = .command
    }

    private func initializeFileMenu() {

        let file = newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Archivo"
            case .ελληνικάΕλλάδα:
                return "Αρχείο"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "File"
            case .deutschDeutschland:
                return "Ablage"
            case .françaisFrance:
                return "Fichier"
            case .עברית־ישראל:
                return "קובץ"
            }
        })))

        let new = file.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Nuevo"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "New"
            case .deutschDeutschland:
                return "Neu"
            case .françaisFrance:
                return "Nouveau"

            case .ελληνικάΕλλάδα:
                return "Δημιουργία"
            case .עברית־ישראל:
                return "חדש"
            }
        })), action: #selector(NSDocumentController.newDocument(_: )))
        new.keyEquivalent = "n"
        new.keyEquivalentModifierMask = .command

        let open = file.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Abrir..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Open..."
            case .deutschDeutschland:
                return "Öffnen ..."

            case .françaisFrance:
                return "Ouvrir..."
            case .ελληνικάΕλλάδα:
                return "Άνοιγμα..."
            case .עברית־ישראל:
                return "פתח..."
            }
        })), action: #selector(NSDocumentController.openDocument(_: )))
        open.keyEquivalent = "o"
        open.keyEquivalentModifierMask = .command

        let openRecent = file.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Abrir recientes"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Open Recent"
            case .deutschDeutschland:
                return "Benutzte Dokumente"
            case .françaisFrance:
                return "Ouvrir l’élément récent"
            case .ελληνικάΕλλάδα:
                return "Άνοιγμα προσφάτου"
            case .עברית־ישראל:
                return "פתח אחרונים"
            }
        })))

        openRecent.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Vaciar menú"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Clear Menu"
            case .deutschDeutschland:
                return "Einträge löschen"
            case .françaisFrance:
                return "Effacer le menu"
            case .ελληνικάΕλλάδα:
                return "Εκκαθάριση μενού"
            case .עברית־ישראל:
                return "נקה תפריט"
            }
        })), action: #selector(NSDocumentController.clearRecentDocuments(_: )))

        file.newSeparator()

        let close = file.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Cerrar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Close"
            case .deutschDeutschland:
                return "Schließen"
            case .françaisFrance:
                return "Fermer"
            case .ελληνικάΕλλάδα:
                return "Κλείσιμο"
            case .עברית־ישראל:
                return "סגור"
            }
        })), action: #selector(NSWindow.performClose(_: )))
        close.keyEquivalent = "w"
        close.keyEquivalentModifierMask = .command

        let save = file.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Guardar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Save"
            case .deutschDeutschland:
                return "Sichern"
            case .françaisFrance:
                return "Enregistrer"
            case .ελληνικάΕλλάδα:
                return "Αποθήκευση"
            case .עברית־ישראל:
                return "שמור"
            }
        })), action: #selector(NSDocument.save(_: )))
        save.keyEquivalent = "s"
        save.keyEquivalentModifierMask = .command

        let duplicate = file.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Duplicar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Duplicate"
            case .deutschDeutschland:
                return "Duplizieren"
            case .françaisFrance:
                return "Dupliquer"

            case .ελληνικάΕλλάδα:
                return "Διπλότυπο"
            case .עברית־ישראל:
                return "שכפל"
            }
        })), action: #selector(NSDocument.duplicate(_: )))
        duplicate.keyEquivalent = "S"
        duplicate.keyEquivalentModifierMask = .command

        file.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Renombrar..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Rename..."
            case .françaisFrance:
                return "Renommer..."

            case .deutschDeutschland:
                return "Umbenennen ..."
            case .ελληνικάΕλλάδα:
                return "Μετανομασία..."
            case .עברית־ישראל:
                return "שינוי שם..."
            }
        })), action: #selector(NSDocument.rename(_: )))

        file.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Trasladar a..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Move to..."
            case .deutschDeutschland:
                return "Bewegen ..."
            case .françaisFrance:
                return "Déplacer vers..."
            case .ελληνικάΕλλάδα:
                return "Μετακίνηση σε..."
            case .עברית־ישראל:
                return "העבר אל..."
            }
        })), action: #selector(NSDocument.move(_: )))

        let revertToSaved = file.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Revert to Saved"
            }
        })), action: #selector(NSDocument.revertToSaved(_: )))
        revertToSaved.keyEquivalent = "r"
        revertToSaved.keyEquivalentModifierMask = .command

        file.newSeparator()

        let pageSetUp = file.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Ajustar página..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Page Set‐Up..."
            case .deutschDeutschland:
                return "Papierformat ..."
            case .françaisFrance:
                return "Format d’impression..."
            case .ελληνικάΕλλάδα:
                return "Διαμόρφωση σελίδας..."
            case .עברית־ישראל:
                return "הגדרת עמוד..."
            }
        })), action: #selector(NSDocument.runPageLayout(_: )))
        pageSetUp.keyEquivalent = "P"
        pageSetUp.keyEquivalentModifierMask = .command

        let print = file.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Imprimir..."
            case .françaisFrance:
                return "Imprimer..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Print..."
            case .deutschDeutschland:
                return "Drucken ..."
            case .ελληνικάΕλλάδα:
                return "Εκτύπωση..."
            case .עברית־ישראל:
                return "הדפס..."
            }
        })), action: #selector(NSView.printView(_: )))
        print.keyEquivalent = "p"
        print.keyEquivalentModifierMask = .command
    }

    private func initializeEditMenu() {
        class Responder: NSObject {
            @objc func undo(_ sender: Any?) {}
            @objc func redo(_ sender: Any?) {}
            @objc func normalizeText(_ sender: Any?) {} // #workaround(Until provided by NSTextView.)
            @objc func showCharacterInformation(_ sender: Any?) {} // #workaround(Until provided by NSTextView.)
        }

        let edit = newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Edit"
            case .deutschDeutschland:
                return "Bearbeiten"
            case .françaisFrance:
                return "Édition"
            }
        })))

        let undo = edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Undo"
            case .deutschDeutschland:
                return "Widerrufen"
            case .françaisFrance:
                return "Annuler"
            }
        })), action: #selector(Responder.undo(_: )))
        undo.keyEquivalent = "z"
        undo.keyEquivalentModifierMask = .command

        let redo = edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Redo"
            case .deutschDeutschland:
                return "Wiederholen"
            case .françaisFrance:
                return "Rétablir"
            }
        })), action: #selector(Responder.redo(_: )))
        redo.keyEquivalent = "Z"
        redo.keyEquivalentModifierMask = .command

        edit.newSeparator()

        let cut = edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Cut"
            case .deutschDeutschland:
                return "Ausschneiden"
            case .françaisFrance:
                return "Couper"
            }
        })), action: #selector(NSText.cut(_: )))
        cut.keyEquivalent = "x"
        cut.keyEquivalentModifierMask = .command

        let copy = edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Copy"
            case .deutschDeutschland:
                return "Kopieren"
            case .françaisFrance:
                return "Copier"
            }
        })), action: #selector(NSText.copy(_: )))
        copy.keyEquivalent = "c"
        copy.keyEquivalentModifierMask = .command

        let paste = edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Paste"
            case .deutschDeutschland:
                return "Einsetzen"
            case .françaisFrance:
                return "Coller"
            }
        })), action: #selector(NSText.paste(_: )))
        paste.keyEquivalent = "v"
        paste.keyEquivalentModifierMask = .command

        let pasteAndMatchStyle = edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Paste & Match Style"
            case .deutschDeutschland:
                return "Einsetzen und Stil anpassen"
            case .françaisFrance:
                return "Coller et adapter le style"
            }
        })), action: #selector(NSTextView.pasteAsPlainText(_: )))
        pasteAndMatchStyle.keyEquivalent = "V"
        pasteAndMatchStyle.keyEquivalentModifierMask = [.command, .option]

        edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Delete"
            case .deutschDeutschland:
                return "Löschen"
            case .françaisFrance:
                return "Supprimer"
            }
        })), action: #selector(NSText.delete(_: )))

        let selectAll = edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Select All"
            case .françaisFrance:
                return "Tout sélectionner"

            case .deutschDeutschland:
                return "Alles auswählen"
            }
        })), action: #selector(NSResponder.selectAll(_: )))
        selectAll.keyEquivalent = "a"
        selectAll.keyEquivalentModifierMask = .command

        edit.newSeparator()

        let findMenu = edit.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find"
            case .deutschDeutschland:
                return "Suchen"
            case .françaisFrance:
                return "Rechercher"
            }
        })))

        let findEntry = findMenu.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find..."
            case .deutschDeutschland:
                return "Suchen ..."
            case .françaisFrance:
                return "Rechercher..."
            }
        })), action: #selector(NSTextView.performFindPanelAction(_: )))
        findEntry.tag = 1
        findEntry.keyEquivalent = "f"
        findEntry.keyEquivalentModifierMask = .command

        let replace = findMenu.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find & Replace..."
            case .deutschDeutschland:
                return "Suchen und Ersetzen ..."
            case .françaisFrance:
                return "Rechercher et remplacer..."
            }
        })), action: #selector(NSTextView.performFindPanelAction(_: )))
        replace.tag = 12
        replace.keyEquivalent = "f"
        replace.keyEquivalentModifierMask = [.command, .option]

        let findNext = findMenu.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find Next"
            case .deutschDeutschland:
                return "Weitersuchen (vorwärts)"
            case .françaisFrance:
                return "Rechercher le suivant"
            }
        })), action: #selector(NSTextView.performFindPanelAction(_: )))
        findNext.tag = 2
        findNext.keyEquivalent = "g"
        findNext.keyEquivalentModifierMask = [.command]

        let findPrevious = findMenu.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find Previous"
            case .deutschDeutschland:
                return "Weitersuchen (rückwärts)"
            case .françaisFrance:
                return "Rechercher le précédent"
            }
        })), action: #selector(NSTextView.performFindPanelAction(_: )))
        findPrevious.tag = 3
        findPrevious.keyEquivalent = "G"
        findPrevious.keyEquivalentModifierMask = [.command]

        let useSelectionForFind = findMenu.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use Selection for Find"
            case .deutschDeutschland:
                return "Auswahl suchen"
            case .françaisFrance:
                return "Rechercher la sélection"
            }
        })), action: #selector(NSTextView.performFindPanelAction(_: )))
        useSelectionForFind.tag = 7
        useSelectionForFind.keyEquivalent = "e"
        useSelectionForFind.keyEquivalentModifierMask = .command

        let jumpToSelection = findMenu.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Jump to Selection"
            case .deutschDeutschland:
                return "Auswahl anzeigen"
            case .françaisFrance:
                return "Aller à la sélection"
            }
        })), action: #selector(NSResponder.centerSelectionInVisibleArea(_: )))
        jumpToSelection.keyEquivalent = "j"
        jumpToSelection.keyEquivalentModifierMask = [.command]

        let spellingAndGrammar = edit.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Spelling & Grammar"
            case .deutschDeutschland:
                return "Rechtschreibung und Grammatik"
            case .françaisFrance:
                return "Orthographe et grammaire"
            }
        })))

        let showSpellingAndGrammar = spellingAndGrammar.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Spelling & Grammar"
            case .deutschDeutschland:
                return "Rechtschreibung und Grammatik einblenden"
            case .françaisFrance:
                return "Afficher l’orthographe et la grammaire"
            }
        })), action: #selector(NSText.showGuessPanel(_:)))
        showSpellingAndGrammar.keyEquivalent = ":"
        showSpellingAndGrammar.keyEquivalentModifierMask = .command

        let checkDocumentNow = spellingAndGrammar.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Check Document Now"
            case .deutschDeutschland:
                return "Dokument jetzt prüfen"
            case .françaisFrance:
                return "Vérifier le document maintenant"
            }
        })), action: #selector(NSText.checkSpelling(_:)))
        checkDocumentNow.keyEquivalent = ";"
        checkDocumentNow.keyEquivalentModifierMask = .command

        spellingAndGrammar.newSeparator()

        spellingAndGrammar.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Check Spelling While Typing"
            case .deutschDeutschland:
                return "Während der Texteingabe prüfen"
            case .françaisFrance:
                return "Vérifier l’orthographe lors de la saisie"
            }
        })), action: #selector(NSTextView.toggleContinuousSpellChecking(_:)))

        spellingAndGrammar.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Check Grammar with Spelling"
            case .deutschDeutschland:
                return "Rechtschreib‐ und Grammatikprüfung"
            case .françaisFrance:
                return "Vérifier la grammaire et l’orthographe"
            }
        })), action: #selector(NSTextView.toggleGrammarChecking(_:)))

        spellingAndGrammar.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Correct Spelling Automatically"
            case .deutschDeutschland:
                return "Rechtschreibung automatisch korrigieren"
            case .françaisFrance:
                return "Corriger l’orthographe automatiquement"
            }
        })), action: #selector(NSTextView.toggleAutomaticSpellingCorrection(_:)))

        let substitutions = edit.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Substitutions"
            case .françaisFrance:
                return "Substitutions"

            case .deutschDeutschland:
                return "Ersetzungen"
            }
        })))

        substitutions.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Substitutions"
            case .deutschDeutschland:
                return "Ersetzungen einblenden"
            case .françaisFrance:
                return "Afficher les substitutions"
            }
        })), action: #selector(NSTextView.orderFrontSubstitutionsPanel(_:)))

        substitutions.newSeparator()

        substitutions.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Smart Copy/Paste"
            case .deutschDeutschland:
                return "Intelligentes Kopieren/Einsetzen"
            case .françaisFrance:
                return "Copier–coller intelligent"
            }
        })), action: #selector(NSTextView.toggleSmartInsertDelete(_:)))

        substitutions.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Smart Quotes"
            case .deutschDeutschland:
                return "Intelligente Anführungszeichen"
            case .françaisFrance:
                return "Guillemets courbes"
            }
        })), action: #selector(NSTextView.toggleAutomaticQuoteSubstitution(_:)))

        substitutions.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Smart Dashes"
            case .deutschDeutschland:
                return "Intelligente Bindestriche"
            case .françaisFrance:
                return "Tirets intelligents"
            }
        })), action: #selector(NSTextView.toggleAutomaticDashSubstitution(_:)))

        substitutions.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Smart Links"
            case .deutschDeutschland:
                return "Intellingente Links"
            case .françaisFrance:
                return "Liens intelligents"
            }
        })), action: #selector(NSTextView.toggleAutomaticLinkDetection(_:)))

        substitutions.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Data Detectors"
            case .deutschDeutschland:
                return "Datenerkennung"
            case .françaisFrance:
                return "Détection de données"
            }
        })), action: #selector(NSTextView.toggleAutomaticDataDetection(_:)))

        substitutions.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Text Replacement"
            case .deutschDeutschland:
                return "Text ersetzen"
            case .françaisFrance:
                return "Remplacement de texte"
            }
        })), action: #selector(NSTextView.toggleAutomaticTextReplacement(_:)))

        let transformations = edit.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                 .françaisFrance:
                return "Transformations"
            case .deutschDeutschland:
                return "Transformationen"
            }
        })))

        transformations.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom:
                return "Normalise Text"
            case .englishUnitedStates, .englishCanada:
                return "Normalize Text"
            }
        })), action: #selector(Responder.normalizeText(_: )))

        // “Make Upper Case” does not belong here. Uppercase‐only is a font style, not a semantic aspect of the text. Attempting to fake it by switching to capital letters (a) results in semantically incorrect text, and (b) is irreversable. A font‐based version is available under the “Font” menu instead.

        // “Make Lower Case” is never useful. Instead, reversion from an uppercase‐only font style to normally cased font—which preserves true capitals—is available under the “Font” menu.

        // “Capitalize” is just not possible for a machine to do properly in any language.

        edit.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Character Information"
            }
        })), action: #selector(Responder.showCharacterInformation(_: )))

        let speech = edit.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Speech"
            case .deutschDeutschland:
                return "Sprachausgabe"

            case .françaisFrance:
                return "Parole"
            }
        })))

        speech.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Start Speaking"
            case .deutschDeutschland:
                return "Sprachausgabe starten"
            case .françaisFrance:
                return "Commencer la lecture"
            }
        })), action: #selector(NSTextView.startSpeaking(_: )))

        speech.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Stop Speaking"
            case .deutschDeutschland:
                return "Sprachausgabe stoppen"
            case .françaisFrance:
                return "Arrêter la lecture"
            }
        })), action: #selector(NSTextView.stopSpeaking(_: )))
    }

    private func initializeFormatMenu() {
        class Responder: NSObject {
            @objc func resetBaseline(_ sender: Any?) {} // #workaround(Until provided by NSTextView.)
            @objc func makeSuperscript(_ sender: Any?) {} // #workaround(Until provided by NSTextView.)
            @objc func makeSubscript(_ sender: Any?) {} // #workaround(Until provided by NSTextView.)
            @objc func resetCasing(_ sender: Any?) {} // #workaround(Until provided by NSTextView.)
            @objc func makeLatinateUpperCase(_ sender: Any?) {} // #workaround(Until provided by NSTextView.)
            @objc func makeLatinateSmallUpperCase(_ sender: Any?) {} // #workaround(Until provided by NSTextView.)
            @objc func makeLatinateLowerCase(_ sender: Any?) {} // #workaround(Until provided by NSTextView.)
            @objc func makeTurkicUpperCase(_ sender: Any?) {} // #workaround(Until provided by NSTextView.)
            @objc func makeTurkicSmallUpperCase(_ sender: Any?) {} // #workaround(Until provided by NSTextView.)
            @objc func makeTurkicLowerCase(_ sender: Any?) {} // #workaround(Until provided by NSTextView.)
        }

        let format = newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                 .deutschDeutschland,
                 .françaisFrance:
                return "Format"
            }
        })))

        let font = format.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Font"
            case .deutschDeutschland:
                return "Schrift"
            case .françaisFrance:
                return "Police"
            }
        })))

        let showFonts = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Fonts"
            case .deutschDeutschland:
                return "Schriften einblenden"
            case .françaisFrance:
                return "Afficher les polices"
            }
        })), action: #selector(NSFontManager.orderFrontFontPanel(_: )))
        showFonts.target = NSFontManager.shared
        showFonts.keyEquivalent = "t"
        showFonts.keyEquivalentModifierMask = .command

        let bold = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Bold"
            case .deutschDeutschland:
                return "Fett"
            case .françaisFrance:
                return "Gras"
            }
        })), action: #selector(NSFontManager.addFontTrait(_: )))
        bold.target = NSFontManager.shared
        bold.tag = 2
        bold.keyEquivalent = "b"
        bold.keyEquivalentModifierMask = .command

        let italic = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Italic"
            case .françaisFrance:
                return "Italique"

            case .deutschDeutschland:
                return "Kursiv"
            }
        })), action: #selector(NSFontManager.addFontTrait(_: )))
        italic.target = NSFontManager.shared
        italic.tag = 1
        italic.keyEquivalent = "i"
        italic.keyEquivalentModifierMask = .command

        let underline = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Underline"
            case .deutschDeutschland:
                return "Unterstrichen"
            case .françaisFrance:
                return "Souligné"
            }
        })), action: #selector(NSText.underline(_: )))
        underline.keyEquivalent = "u"
        underline.keyEquivalentModifierMask = .command

        font.newSeparator()

        let bigger = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Bigger"

            case .deutschDeutschland:
                return "Größer"
            case .françaisFrance:
                return "Plus grand"
            }
        })), action: #selector(NSFontManager.modifyFont(_: )))
        bigger.target = NSFontManager.shared
        bigger.tag = 3
        bigger.keyEquivalent = "+"
        bigger.keyEquivalentModifierMask = .command

        let smaller = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Smaller"
            case .deutschDeutschland:
                return "Kleiner"
            case .françaisFrance:
                return "Plus petit"
            }
        })), action: #selector(NSFontManager.modifyFont(_: )))
        smaller.target = NSFontManager.shared
        smaller.tag = 4
        smaller.keyEquivalent = "\u{2D}"
        smaller.keyEquivalentModifierMask = .command

        font.newSeparator()

        let kern = font.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Kern"
            case .françaisFrance:
                return "Crénage"

            case .deutschDeutschland:
                return "Zeichenabstand"
            }
        })))

        kern.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use Default"
            case .deutschDeutschland:
                return "Normal"
            case .françaisFrance:
                return "Valeur par défaut"
            }
        })), action: #selector(NSTextView.useStandardKerning(_: )))

        kern.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use None"
            case .deutschDeutschland:
                return "Nicht verwenden"
            case .françaisFrance:
                return "Aucun"
            }
        })), action: #selector(NSTextView.turnOffKerning(_: )))

        kern.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Tighten"
            case .deutschDeutschland:
                return "Enger"
            case .françaisFrance:
                return "Resserrer"
            }
        })), action: #selector(NSTextView.tightenKerning(_: )))

        kern.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Loosen"
            case .deutschDeutschland:
                return "Weiter"
            case .françaisFrance:
                return "Desserrer"
            }
        })), action: #selector(NSTextView.loosenKerning(_: )))

        let ligatures = font.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                 .françaisFrance:
                return "Ligatures"
            case .deutschDeutschland:
                return "Ligaturen"
            }
        })))

        ligatures.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use Default"
            case .deutschDeutschland:
                return "Normal"
            case .françaisFrance:
                return "Valeur par défaut"
            }
        })), action: #selector(NSTextView.useStandardLigatures(_: )))

        ligatures.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use None"
            case .deutschDeutschland:
                return "Nicht verwenden"
            case .françaisFrance:
                return "Aucune"
            }
        })), action: #selector(NSTextView.turnOffLigatures(_: )))

        ligatures.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use All"
            case .deutschDeutschland:
                return "Alle verwenden"
            case .françaisFrance:
                return "Toutes"
            }
        })), action: #selector(NSTextView.useAllLigatures(_: )))

        let baseline = font.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Baseline"
            case .françaisFrance:
                return "Ligne de base"

            case .deutschDeutschland:
                return "Schriftlinie"
            }
        })))

        baseline.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use Default"
            case .deutschDeutschland:
                return "Normal"
            case .françaisFrance:
                return "Valeur par défaut"
            }
        })), action: #selector(Responder.resetBaseline(_: )))

        baseline.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Superscript"
            case .deutschDeutschland:
                return "Hochgestellt"
            case .françaisFrance:
                return "Exposant"
            }
        })), action: #selector(Responder.makeSuperscript(_: )))

        baseline.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Subscript"
            case .deutschDeutschland:
                return "Tiefgestellt"
            case .françaisFrance:
                return "Indice"
            }
        })), action: #selector(Responder.makeSubscript(_: )))

        baseline.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Raise"
            case .deutschDeutschland:
                return "Höher"
            case .françaisFrance:
                return "Élever"
            }
        })), action: #selector(NSTextView.raiseBaseline(_: )))

        baseline.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Lower"
            case .deutschDeutschland:
                return "Niedriger"
            case .françaisFrance:
                return "Abaisser"
            }
        })), action: #selector(NSTextView.lowerBaseline(_: )))

        let casing = font.newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Casing"
            }
        })))

        casing.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use Default"
            }
        })), action: #selector(Responder.resetCasing(_: )))

        let upperCase = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Upper Case"
            }
        })

        let smallUpperCase = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Small Upper Case"
            }
        })

        let lowerCase = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Lower Case"
            }
        })

        casing.newSeparator()

        casing.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            var latinate: StrictString
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                latinate = "Latinate"
            }
            return latinate + " (I ↔ i)"
        })))

        let latinateUpperCase = casing.newEntry(labelled: Shared(upperCase), action: #selector(Responder.makeLatinateUpperCase(_: )))
        latinateUpperCase.indented = true

        let latinateSmallUpperCase = casing.newEntry(labelled: Shared(smallUpperCase), action: #selector(Responder.makeLatinateSmallUpperCase(_: )))
        latinateSmallUpperCase.indented = true

        let latinateLowerCase = casing.newEntry(labelled: Shared(lowerCase), action: #selector(Responder.makeLatinateLowerCase(_: )))
        latinateLowerCase.indented = true

        casing.newSeparator()

        casing.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            var turkic: StrictString
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                turkic = "Turkic"
            }
            return turkic + " (I ↔ ı, İ ↔ i)"
        })))

        let turkicUpperCase = casing.newEntry(labelled: Shared(upperCase), action: #selector(Responder.makeTurkicUpperCase(_: )))
        turkicUpperCase.indented = true

        let turkicSmallUpperCase = casing.newEntry(labelled: Shared(smallUpperCase), action: #selector(Responder.makeTurkicSmallUpperCase(_: )))
        turkicSmallUpperCase.indented = true

        let turkicLowerCase = casing.newEntry(labelled: Shared(lowerCase), action: #selector(Responder.makeTurkicLowerCase(_: )))
        turkicLowerCase.indented = true

        font.newSeparator()

        let showColours = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishCanada:
                return "Show Colours"
            case .englishUnitedStates:
                return "Show Colors"
            case .deutschDeutschland:
                return "Farben einblenden"
            case .françaisFrance:
                return "Afficher les couleurs"
            }
        })), action: #selector(NSApplication.orderFrontColorPanel(_: )))
        showColours.keyEquivalent = "C"
        showColours.keyEquivalentModifierMask = .command

        font.newSeparator()

        let copyStyle = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Copy Style"
            case .deutschDeutschland:
                return "Stil kopieren"
            case .françaisFrance:
                return "Copier le style"
            }
        })), action: #selector(NSText.copyFont(_: )))
        copyStyle.keyEquivalent = "c"
        copyStyle.keyEquivalentModifierMask = [.command, .option]

        let pasteStyle = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Paste Style"
            case .deutschDeutschland:
                return "Stil einsetzen"
            case .françaisFrance:
                return "Coller le style"
            }
        })), action: #selector(NSText.pasteFont(_: )))
        pasteStyle.keyEquivalent = "v"
        pasteStyle.keyEquivalentModifierMask = [.command, .option]

        let text = format.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                 .deutschDeutschland:
                return "Text"
            case .françaisFrance:
                return "Texte"
            }
        })))

        let alignRight = text.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Align Right"
            case .deutschDeutschland:
                return "Rechtsbündig"
            case .françaisFrance:
                return "Aligner à droite"
            }
        })), action: #selector(NSText.alignRight(_: )))
        alignRight.keyEquivalent = "}"
        alignRight.keyEquivalentModifierMask = .command

        let centre = text.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishCanada:
                return "Centre"
            case .englishUnitedStates:
                return "Center"
            case .deutschDeutschland:
                return "Zentriert"
            case .françaisFrance:
                return "Centrer"
            }
        })), action: #selector(NSText.alignCenter(_: )))
        centre.keyEquivalent = "|"
        centre.keyEquivalentModifierMask = .command

        text.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Justify"
            case .françaisFrance:
                return "Justifier"
            case .deutschDeutschland:
                return "Blocksatz"
            }
        })), action: #selector(NSTextView.alignJustified(_: )))

        let alignLeft = text.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Align Left"
            case .deutschDeutschland:
                return "Linksbündig"
            case .françaisFrance:
                return "Aligner à gauche"
            }
        })), action: #selector(NSText.alignLeft(_: )))
        alignLeft.keyEquivalent = "{"
        alignLeft.keyEquivalentModifierMask = .command

        text.newSeparator()

        let writingDirection = text.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Writing Direction"
            case .deutschDeutschland:
                return "Richtung beim Schreiben"
            case .françaisFrance:
                return "Sens de l’écriture"
            }
        })))

        writingDirection.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Paragraph"
            case .françaisFrance:
                return "Paragraphe"
            case .deutschDeutschland:
                return "Absatz"
            }
        })))

        let `default` = UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Default"
            case .françaisFrance:
                return "Par défaut"
            case .deutschDeutschland:
                return "Standard"
            }
        })

        let rightToLeft = UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Right to Left"
            case .deutschDeutschland:
                return "Von rechts nach links"
            case .françaisFrance:
                return "De droite à gauche"
            }
        })

        let leftToRight = UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Left to Right"
            case .deutschDeutschland:
                return "Von links nach rechts"
            case .françaisFrance:
                return "De gauche à droite"
            }
        })

        let paragraphDefault = writingDirection.newEntry(labelled: Shared(`default`), action: #selector(NSResponder.makeBaseWritingDirectionNatural(_: )))
        paragraphDefault.indented = true

        let paragraphRightToLeft = writingDirection.newEntry(labelled: Shared(rightToLeft), action: #selector(NSResponder.makeBaseWritingDirectionRightToLeft(_: )))
        paragraphRightToLeft.indented = true

        let paragraphLeftToRight = writingDirection.newEntry(labelled: Shared(leftToRight), action: #selector(NSResponder.makeBaseWritingDirectionLeftToRight(_: )))
        paragraphLeftToRight.indented = true

        writingDirection.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Selection"
            case .françaisFrance:
                return "Sélection"
            case .deutschDeutschland:
                return "Auswahl"
            }
        })))

        let selectionDefault = writingDirection.newEntry(labelled: Shared(`default`), action: #selector(NSResponder.makeTextWritingDirectionNatural(_: )))
        selectionDefault.indented = true

        let selectionRightToLeft = writingDirection.newEntry(labelled: Shared(rightToLeft), action: #selector(NSResponder.makeTextWritingDirectionRightToLeft(_: )))
        selectionRightToLeft.indented = true

        let selectionLeftToRight = writingDirection.newEntry(labelled: Shared(leftToRight), action: #selector(NSResponder.makeTextWritingDirectionLeftToRight(_: )))
        selectionLeftToRight.indented = true

        text.newSeparator()

        text.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Ruler"
            case .deutschDeutschland:
                return "Lineal einblenden"
            case .françaisFrance:
                return "Afficher la règle"
            }
        })), action: #selector(NSText.toggleRuler(_: )))

        let copyRuler = text.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Copy Ruler"
            case .deutschDeutschland:
                return "Lineal kopieren"
            case .françaisFrance:
                return "Copier la règle"
            }
        })), action: #selector(NSText.copyRuler(_: )))
        copyRuler.keyEquivalent = "c"
        copyRuler.keyEquivalentModifierMask = [.command, .control]

        let pasteRuler = text.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Paste Ruler"
            case .deutschDeutschland:
                return "Lineal einsetzen"
            case .françaisFrance:
                return "Coller la règle"
            }
        })), action: #selector(NSText.pasteRuler(_: )))
        pasteRuler.keyEquivalent = "v"
        pasteRuler.keyEquivalentModifierMask = [.command, .control]
    }

    private func initializeViewMenu() {
        class Responder: NSObject {
            @objc func toggleSourceList(_ sender: Any?) {}
        }

        let view = newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "View"
            case .deutschDeutschland:
                return "Darstellung"
            case .françaisFrance:
                return "Présentation"
            }
        })))

        let showToolbar = view.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Toolbar"
            case .deutschDeutschland:
                return "Symbolleiste einblenden"
            case .françaisFrance:
                return "Afficher la barre d’outils"
            }
        })), action: #selector(NSWindow.toggleToolbarShown(_: )))
        showToolbar.keyEquivalent = "t"
        showToolbar.keyEquivalentModifierMask = [.command, .option]

        view.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom:
                return "Customise Toolbar..."
            case .englishUnitedStates, .englishCanada:
                return "Customize Toolbar..."
            case .deutschDeutschland:
                return "Symbolleiste anpassen ..."
            case .françaisFrance:
                return "Personnaliser la barre d’outils..."
            }
        })), action: #selector(NSWindow.runToolbarCustomizationPalette(_: )))

        view.newSeparator()

        let showSideBar = view.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Side Bar"
            case .deutschDeutschland:
                return "Seitenleiste einblenden"
            case .françaisFrance:
                return "Afficher la barre latérale"
            }
        })), action: #selector(Responder.toggleSourceList(_: )))
        showSideBar.keyEquivalent = "s"
        showSideBar.keyEquivalentModifierMask = [.command, .control]

        let enterFullScreen = view.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Enter Full Screen"
            case .deutschDeutschland:
                return "Vollbild ein"
            case .françaisFrance:
                return "Activer le mode plein écran"
            }
        })), action: #selector(NSWindow.toggleFullScreen(_: )))
        enterFullScreen.keyEquivalent = "f"
        enterFullScreen.keyEquivalentModifierMask = [.command, .control]
    }

    private func initializeWindowMenu() {
        let window = newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Window"
            case .deutschDeutschland:
                return "Fenster"
            case .françaisFrance:
                return "Fenêtre"
            }
        })))
        defer { Application.shared.windowsMenu = window }
        endOfCustomMenuSection = window.parentMenuItem

        let minimize = window.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom:
                return "Minimise"
            case .englishUnitedStates, .englishCanada:
                return "Minimize"
            case .deutschDeutschland:
                return "Im Dock ablegen"
            case .françaisFrance:
                return "Placer dans le Dock"
            }
        })), action: #selector(NSWindow.performMiniaturize(_: )))
        minimize.keyEquivalent = "m"
        minimize.keyEquivalentModifierMask = .command

        window.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Zoom"
            case .deutschDeutschland:
                return "Zoomen"
            case .françaisFrance:
                return "Réduire/agrandir"
            }
        })), action: #selector(NSWindow.performZoom(_: )))

        window.newSeparator()

        window.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Bring All to Front"
            case .deutschDeutschland:
                return "Alle nach vorne bringen"
            case .françaisFrance:
                return "Tout ramener au premier plan"
            }
        })), action: #selector(NSApplication.arrangeInFront(_: )))
    }

    private func initializeHelpMenu() {
        let helpMenu = newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Help"
            case .deutschDeutschland:
                return "Hilfe"

            case .françaisFrance:
                return "Aide"
            }
        })))
        defer { Application.shared.helpMenu = helpMenu }

        let helpItem = helpMenu.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            // #workaround(Should include the application name.)
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Help"
            case .deutschDeutschland:
                return "Hilfe"

            case .françaisFrance:
                return "Aide"
            }
        })), action: #selector(NSApplication.showHelp(_: )))
        helpItem.keyEquivalent = "?"
        helpItem.keyEquivalentModifierMask = .command
        // #workaround(Should hide if the application does not have a help book.)
    }
}

#endif
