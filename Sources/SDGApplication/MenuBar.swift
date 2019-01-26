/*
 MenuBar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)

import SDGInterfaceLocalizations

/// An application’s menu bar.
///
/// `MenuBar` is a fully localized version of Interface Builder’s template with several useful additions.
///
/// Some menu items only appear if the application provides details they need to operate:
/// - “Preferences...” appears if the application delegate overrides `openPreferences(_:)`.
/// - “Help” appears if a help book is specified in the `Info.plist` file.
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

    /// Creates a new menu in the application‐specific section. (Before the “Window” menu.)
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
        let application = newSubmenu(labelled: Shared(ApplicationNameForm.isolatedForm))

        application.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            #warning("Use here.")
            switch localization {
            case .españolEspaña:
                return "Acerca de «...»"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "About ‘...’/“...”"
            case .deutschDeutschland:
                return "Über „...“"
            case .françaisFrance:
                return "À propos de « ... »"
            case .ελληνικάΕλλάδα:
                return "Πληροφορίες για το «...»"
            case .עברית־ישראל:
                return "אותות ”...“"
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
        class Responder : NSObject {
            @objc func undo(_ sender: Any?) {}
            @objc func redo(_ sender: Any?) {}
            @objc func normalizeText(_ sender: Any?) {} // #workaround(Until provided by NSTextView.)
            @objc func showCharacterInformation(_ sender: Any?) {} // #workaround(Until provided by NSTextView.)
        }

        let edit = newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        let undo = edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(Responder.undo(_: )))
        undo.keyEquivalent = "z"
        undo.keyEquivalentModifierMask = .command

        let redo = edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(Responder.redo(_: )))
        redo.keyEquivalent = "Z"
        redo.keyEquivalentModifierMask = .command

        edit.newSeparator()

        let cut = edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.cut(_: )))
        cut.keyEquivalent = "x"
        cut.keyEquivalentModifierMask = .command

        let copy = edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.copy(_: )))
        copy.keyEquivalent = "c"
        copy.keyEquivalentModifierMask = .command

        let paste = edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.paste(_: )))
        paste.keyEquivalent = "v"
        paste.keyEquivalentModifierMask = .command

        let pasteAndMatchStyle = edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.pasteAsPlainText(_: )))
        pasteAndMatchStyle.keyEquivalent = "V"
        pasteAndMatchStyle.keyEquivalentModifierMask = [.command, .option]

        edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.delete(_: )))

        let selectAll = edit.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSResponder.selectAll(_: )))
        selectAll.keyEquivalent = "a"
        selectAll.keyEquivalentModifierMask = .command

        edit.newSeparator()

        let findMenu = edit.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Buscar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find"
            case .deutschDeutschland:
                return "Suchen"
            case .françaisFrance:
                return "Rechercher"
            case .ελληνικάΕλλάδα:
                return "Εύρεση"
            case .עברית־ישראל:
                return "חיפוש"
            }
        })))

        let findEntry = findMenu.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Buscar..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find..."
            case .deutschDeutschland:
                return "Suchen ..."
            case .françaisFrance:
                return "Rechercher..."
            case .ελληνικάΕλλάδα:
                return "Εύρεση"
            case .עברית־ישראל:
                return "חיפוש..."
            }
        })), action: #selector(NSTextView.performFindPanelAction(_: )))
        findEntry.tag = 1
        findEntry.keyEquivalent = "f"
        findEntry.keyEquivalentModifierMask = .command

        let replace = findMenu.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Buscar y reemplazar..."
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find & Replace..."
            case .deutschDeutschland:
                return "Suchen und Ersetzen ..."
            case .françaisFrance:
                return "Rechercher et remplacer..."
            case .ελληνικάΕλλάδα:
                return "Εύρεση και αντικατάσταση..."
            case .עברית־ישראל:
                return "חפש והחלף..."
            }
        })), action: #selector(NSTextView.performFindPanelAction(_: )))
        replace.tag = 12
        replace.keyEquivalent = "f"
        replace.keyEquivalentModifierMask = [.command, .option]

        let findNext = findMenu.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Buscar siguiente"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find Next"
            case .deutschDeutschland:
                return "Weitersuchen (vorwärts)"
            case .françaisFrance:
                return "Rechercher le suivant"
            case .ελληνικάΕλλάδα:
                return "Εύρεση επόμενου"
            case .עברית־ישראל:
                return "חפש את הבא"
            }
        })), action: #selector(NSTextView.performFindPanelAction(_: )))
        findNext.tag = 2
        findNext.keyEquivalent = "g"
        findNext.keyEquivalentModifierMask = [.command]

        let findPrevious = findMenu.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Buscar antetior"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Find Previous"
            case .deutschDeutschland:
                return "Weitersuchen (rückwärts)"
            case .françaisFrance:
                return "Rechercher le précédent"
            case .ελληνικάΕλλάδα:
                return "Εύρεση προηγούμενου"
            case .עברית־ישראל:
                return "חפש את הקודם"
            }
        })), action: #selector(NSTextView.performFindPanelAction(_: )))
        findPrevious.tag = 3
        findPrevious.keyEquivalent = "G"
        findPrevious.keyEquivalentModifierMask = [.command]

        let useSelectionForFind = findMenu.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Usar selección para buscar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use Selection for Find"
            case .deutschDeutschland:
                return "Auswahl suchen"
            case .françaisFrance:
                return "Rechercher la sélection"
            case .ελληνικάΕλλάδα:
                return "Χρήση επιλογής για εύρεση"
            case .עברית־ישראל:
                return "השתמש במלל הנבחר לחיפוש"
            }
        })), action: #selector(NSTextView.performFindPanelAction(_: )))
        useSelectionForFind.tag = 7
        useSelectionForFind.keyEquivalent = "e"
        useSelectionForFind.keyEquivalentModifierMask = .command

        let jumpToSelection = findMenu.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Ir a la selección"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Jump to Selection"
            case .deutschDeutschland:
                return "Auswahl anzeigen"
            case .françaisFrance:
                return "Aller à la sélection"
            case .ελληνικάΕλλάδα:
                return "Μετάβαση σε επιλογή"
            case .עברית־ישראל:
                return "עבור על הקטע הנבחר"
            }
        })), action: #selector(NSResponder.centerSelectionInVisibleArea(_: )))
        jumpToSelection.keyEquivalent = "j"
        jumpToSelection.keyEquivalentModifierMask = [.command]

        let spellingAndGrammar = edit.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        let showSpellingAndGrammar = spellingAndGrammar.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.showGuessPanel(_: )))
        showSpellingAndGrammar.keyEquivalent = ":"
        showSpellingAndGrammar.keyEquivalentModifierMask = .command

        let checkDocumentNow = spellingAndGrammar.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.checkSpelling(_: )))
        checkDocumentNow.keyEquivalent = ";"
        checkDocumentNow.keyEquivalentModifierMask = .command

        spellingAndGrammar.newSeparator()

        spellingAndGrammar.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.toggleContinuousSpellChecking(_: )))

        spellingAndGrammar.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.toggleGrammarChecking(_: )))

        spellingAndGrammar.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.toggleAutomaticSpellingCorrection(_: )))

        let substitutions = edit.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        substitutions.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.orderFrontSubstitutionsPanel(_: )))

        substitutions.newSeparator()

        substitutions.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.toggleSmartInsertDelete(_: )))

        substitutions.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.toggleAutomaticQuoteSubstitution(_: )))

        substitutions.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.toggleAutomaticDashSubstitution(_: )))

        substitutions.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.toggleAutomaticLinkDetection(_: )))

        substitutions.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.toggleAutomaticDataDetection(_: )))

        substitutions.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.toggleAutomaticTextReplacement(_: )))

        let transformations = edit.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        speech.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.startSpeaking(_: )))

        speech.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.stopSpeaking(_: )))
    }

    private func initializeFormatMenu() {
        class Responder : NSObject {
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
            case .españolEspaña:
                return "Formato"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                 .deutschDeutschland,
                 .françaisFrance:
                return "Format"

            case .עברית־ישראל:
                return "עיצוב"
            case .ελληνικάΕλλάδα:
                return "Μορφή"
            }
        })))

        let font = format.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Tipe de letra"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Font"
            case .deutschDeutschland:
                return "Schrift"
            case .françaisFrance:
                return "Police"
            case .ελληνικάΕλλάδα:
                return "Γραμματοσειρά"
            case .עברית־ישראל:
                return "גופן"
            }
        })))

        let showFonts = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Mostrar tipos de letra"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Fonts"
            case .deutschDeutschland:
                return "Schriften einblenden"
            case .françaisFrance:
                return "Afficher les polices"
            case .ελληνικάΕλλάδα:
                return "Εμφάνιση γραμματοσειρών"
            case .עברית־ישראל:
                return "הצג גופנים"
            }
        })), action: #selector(NSFontManager.orderFrontFontPanel(_: )))
        showFonts.target = NSFontManager.shared
        showFonts.keyEquivalent = "t"
        showFonts.keyEquivalentModifierMask = .command

        let bold = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Negrita"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Bold"
            case .deutschDeutschland:
                return "Fett"
            case .françaisFrance:
                return "Gras"
            case .ελληνικάΕλλάδα:
                return "Έντονα"
            case .עברית־ישראל:
                return "עבה"
            }
        })), action: #selector(NSFontManager.addFontTrait(_: )))
        bold.target = NSFontManager.shared
        bold.tag = 2
        bold.keyEquivalent = "b"
        bold.keyEquivalentModifierMask = .command

        let italic = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Cursiva"
            case .deutschDeutschland:
                return "Kursiv"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Italic"
            case .françaisFrance:
                return "Italique"

            case .ελληνικάΕλλάδα:
                return "Πλάγια"
            case .עברית־ישראל:
                return "נטוי"
            }
        })), action: #selector(NSFontManager.addFontTrait(_: )))
        italic.target = NSFontManager.shared
        italic.tag = 1
        italic.keyEquivalent = "i"
        italic.keyEquivalentModifierMask = .command

        let underline = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Subrayado"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Underline"
            case .deutschDeutschland:
                return "Unterstrichen"
            case .françaisFrance:
                return "Souligné"
            case .ελληνικάΕλλάδα:
                return "Υπογράμμιση"
            case .עברית־ישראל:
                return "קו תחתון"
            }
        })), action: #selector(NSText.underline(_: )))
        underline.keyEquivalent = "u"
        underline.keyEquivalentModifierMask = .command

        font.newSeparator()

        let bigger = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Más grande"
            case .deutschDeutschland:
                return "Größer"
            case .françaisFrance:
                return "Plus grand"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Bigger"

            case .ελληνικάΕλλάδα:
                return "Μεγαλύτερα"
            case .עברית־ישראל:
                return "גדול יותר"
            }
        })), action: #selector(NSFontManager.modifyFont(_: )))
        bigger.target = NSFontManager.shared
        bigger.tag = 3
        bigger.keyEquivalent = "+"
        bigger.keyEquivalentModifierMask = .command

        let smaller = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Más pequeño"
            case .françaisFrance:
                return "Plus petit"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Smaller"
            case .deutschDeutschland:
                return "Kleiner"
            case .ελληνικάΕλλάδα:
                return "Μικρότερα"
            case .עברית־ישראל:
                return "קטן יותר"
            }
        })), action: #selector(NSFontManager.modifyFont(_: )))
        smaller.target = NSFontManager.shared
        smaller.tag = 4
        smaller.keyEquivalent = "\u{2D}"
        smaller.keyEquivalentModifierMask = .command

        font.newSeparator()

        let kern = font.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        kern.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.useStandardKerning(_: )))

        kern.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.turnOffKerning(_: )))

        kern.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.tightenKerning(_: )))

        kern.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.loosenKerning(_: )))

        let ligatures = font.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Ligaduras"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                 .françaisFrance:
                return "Ligatures"
            case .deutschDeutschland:
                return "Ligaturen"

            case .ελληνικάΕλλάδα:
                return "Συμπλέγματα"
            case .עברית־ישראל:
                return "משלבי אותיות"
            }
        })))

        ligatures.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.useStandardLigatures(_: )))

        ligatures.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Ninguna"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use None"
            case .deutschDeutschland:
                return "Nicht verwenden"
            case .françaisFrance:
                return "Aucune"
            case .ελληνικάΕλλάδα:
                return "Κανένα"
            case .עברית־ישראל:
                return "אל תשתמש בשום אפשרות"
            }
        })), action: #selector(NSTextView.turnOffLigatures(_: )))

        ligatures.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Todas"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use All"
            case .deutschDeutschland:
                return "Alle verwenden"
            case .françaisFrance:
                return "Toutes"
            case .ελληνικάΕλλάδα:
                return "Χρήση όλων"
            case .עברית־ישראל:
                return "השתמש בכולם"
            }
        })), action: #selector(NSTextView.useAllLigatures(_: )))

        let baseline = font.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Línea base"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Baseline"
            case .françaisFrance:
                return "Ligne de base"

            case .deutschDeutschland:
                return "Schriftlinie"
            case .ελληνικάΕλλάδα:
                return "Γραμμή βάσης"
            case .עברית־ישראל:
                return "קו בסיס"
            }
        })))

        baseline.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(Responder.resetBaseline(_: )))

        baseline.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Superíndice"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Superscript"
            case .deutschDeutschland:
                return "Hochgestellt"
            case .françaisFrance:
                return "Exposant"
            case .ελληνικάΕλλάδα:
                return "Εκθέτης"
            case .עברית־ישראל:
                return "כתב עילי"
            }
        })), action: #selector(Responder.makeSuperscript(_: )))

        baseline.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Subíndice"
            case .françaisFrance:
                return "Indice"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Subscript"
            case .deutschDeutschland:
                return "Tiefgestellt"
            case .ελληνικάΕλλάδα:
                return "Δεικτής"
            case .עברית־ישראל:
                return "כתב תחתי"
            }
        })), action: #selector(Responder.makeSubscript(_: )))

        baseline.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Subir"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Raise"
            case .deutschDeutschland:
                return "Höher"
            case .françaisFrance:
                return "Élever"
            case .ελληνικάΕλλάδα:
                return "Ανύψωση"
            case .עברית־ישראל:
                return "הגבה"
            }
        })), action: #selector(NSTextView.raiseBaseline(_: )))

        baseline.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Bajar"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Lower"
            case .deutschDeutschland:
                return "Niedriger"
            case .françaisFrance:
                return "Abaisser"
            case .ελληνικάΕλλάδα:
                return "Χαμήλωμα"
            case .עברית־ישראל:
                return "נמוך יותר"
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
        latinateUpperCase.indentationLevel = 1

        let latinateSmallUpperCase = casing.newEntry(labelled: Shared(smallUpperCase), action: #selector(Responder.makeLatinateSmallUpperCase(_: )))
        latinateSmallUpperCase.indentationLevel = 1

        let latinateLowerCase = casing.newEntry(labelled: Shared(lowerCase), action: #selector(Responder.makeLatinateLowerCase(_: )))
        latinateLowerCase.indentationLevel = 1

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
        turkicUpperCase.indentationLevel = 1

        let turkicSmallUpperCase = casing.newEntry(labelled: Shared(smallUpperCase), action: #selector(Responder.makeTurkicSmallUpperCase(_: )))
        turkicSmallUpperCase.indentationLevel = 1

        let turkicLowerCase = casing.newEntry(labelled: Shared(lowerCase), action: #selector(Responder.makeTurkicLowerCase(_: )))
        turkicLowerCase.indentationLevel = 1

        font.newSeparator()

        let showColours = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Mostrar colores"
            case .englishUnitedKingdom, .englishCanada:
                return "Show Colours"
            case .englishUnitedStates:
                return "Show Colors"
            case .deutschDeutschland:
                return "Farben einblenden"
            case .françaisFrance:
                return "Afficher les couleurs"
            case .ελληνικάΕλλάδα:
                return "Εμφάνιση χρωμάτων"
            case .עברית־ישראל:
                return "הצג צבעים"
            }
        })), action: #selector(NSApplication.orderFrontColorPanel(_: )))
        showColours.keyEquivalent = "C"
        showColours.keyEquivalentModifierMask = .command

        font.newSeparator()

        let copyStyle = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Copiar estilo"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Copy Style"
            case .deutschDeutschland:
                return "Stil kopieren"
            case .françaisFrance:
                return "Copier le style"

            case .ελληνικάΕλλάδα:
                return "Αντιγραφή στιλ"
            case .עברית־ישראל:
                return "העתק סגנון"
            }
        })), action: #selector(NSText.copyFont(_: )))
        copyStyle.keyEquivalent = "c"
        copyStyle.keyEquivalentModifierMask = [.command, .option]

        let pasteStyle = font.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Pegar estilo"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Paste Style"
            case .deutschDeutschland:
                return "Stil einsetzen"
            case .françaisFrance:
                return "Coller le style"
            case .ελληνικάΕλλάδα:
                return "Επικόλληση στιλ"
            case .עברית־ישראל:
                return "הדבק סגנון"
            }
        })), action: #selector(NSText.pasteFont(_: )))
        pasteStyle.keyEquivalent = "v"
        pasteStyle.keyEquivalentModifierMask = [.command, .option]

        let text = format.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        let alignRight = text.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.alignRight(_: )))
        alignRight.keyEquivalent = "}"
        alignRight.keyEquivalentModifierMask = .command

        let centre = text.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.alignCenter(_: )))
        centre.keyEquivalent = "|"
        centre.keyEquivalentModifierMask = .command

        text.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.alignJustified(_: )))

        let alignLeft = text.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.alignLeft(_: )))
        alignLeft.keyEquivalent = "{"
        alignLeft.keyEquivalentModifierMask = .command

        text.newSeparator()

        let writingDirection = text.newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        writingDirection.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        let paragraphDefault = writingDirection.newEntry(labelled: Shared(`default`), action: #selector(NSResponder.makeBaseWritingDirectionNatural(_: )))
        paragraphDefault.indentationLevel = 1

        let paragraphRightToLeft = writingDirection.newEntry(labelled: Shared(rightToLeft), action: #selector(NSResponder.makeBaseWritingDirectionRightToLeft(_: )))
        paragraphRightToLeft.indentationLevel = 1

        let paragraphLeftToRight = writingDirection.newEntry(labelled: Shared(leftToRight), action: #selector(NSResponder.makeBaseWritingDirectionLeftToRight(_: )))
        paragraphLeftToRight.indentationLevel = 1

        writingDirection.newSeparator()

        writingDirection.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        let selectionDefault = writingDirection.newEntry(labelled: Shared(`default`), action: #selector(NSResponder.makeTextWritingDirectionNatural(_: )))
        selectionDefault.indentationLevel = 1

        let selectionRightToLeft = writingDirection.newEntry(labelled: Shared(rightToLeft), action: #selector(NSResponder.makeTextWritingDirectionRightToLeft(_: )))
        selectionRightToLeft.indentationLevel = 1

        let selectionLeftToRight = writingDirection.newEntry(labelled: Shared(leftToRight), action: #selector(NSResponder.makeTextWritingDirectionLeftToRight(_: )))
        selectionLeftToRight.indentationLevel = 1

        text.newSeparator()

        text.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.toggleRuler(_: )))

        let copyRuler = text.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.copyRuler(_: )))
        copyRuler.keyEquivalent = "c"
        copyRuler.keyEquivalentModifierMask = [.command, .control]

        let pasteRuler = text.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.pasteRuler(_: )))
        pasteRuler.keyEquivalent = "v"
        pasteRuler.keyEquivalentModifierMask = [.command, .control]
    }

    private func initializeViewMenu() {
        class Responder : NSObject {
            @objc func toggleSourceList(_ sender: Any?) {}
        }

        let view = newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Visualización"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "View"
            case .deutschDeutschland:
                return "Darstellung"
            case .françaisFrance:
                return "Présentation"
            case .ελληνικάΕλλάδα:
                return "Προβολή"
            case .עברית־ישראל:
                return "תצוגה"
            }
        })))

        let showToolbar = view.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Mostrar barra de herramientas"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Toolbar"
            case .deutschDeutschland:
                return "Symbolleiste einblenden"
            case .françaisFrance:
                return "Afficher la barre d’outils"
            case .ελληνικάΕλλάδα:
                return "Εμφάνιση γραμμής εργαλείων"
            case .עברית־ישראל:
                return "הצג את סרגל הכלים"
            }
        })), action: #selector(NSWindow.toggleToolbarShown(_: )))
        showToolbar.keyEquivalent = "t"
        showToolbar.keyEquivalentModifierMask = [.command, .option]

        view.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Personalizar barra de herramientas..."
            case .englishUnitedKingdom:
                return "Customise Toolbar..."
            case .englishUnitedStates, .englishCanada:
                return "Customize Toolbar..."
            case .deutschDeutschland:
                return "Symbolleiste anpassen ..."
            case .françaisFrance:
                return "Personnaliser la barre d’outils..."
            case .ελληνικάΕλλάδα:
                return "Προσαρμογή γραμμής εργαλείων..."
            case .עברית־ישראל:
                return "התאמה אישית של סרגל הכלים..."
            }
        })), action: #selector(NSWindow.runToolbarCustomizationPalette(_: )))

        view.newSeparator()

        let showSideBar = view.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Mostrar barra lateral"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Show Side Bar"
            case .deutschDeutschland:
                return "Seitenleiste einblenden"
            case .françaisFrance:
                return "Afficher la barre latérale"
            case .ελληνικάΕλλάδα:
                return "Εμφάνιση πλαϊνής στήλης"
            case .עברית־ישראל:
                return "הצג את סרגל הצד"
            }
        })), action: #selector(Responder.toggleSourceList(_: )))
        showSideBar.keyEquivalent = "s"
        showSideBar.keyEquivalentModifierMask = [.command, .control]

        let enterFullScreen = view.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Usar pantalla completa"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Enter Full Screen"
            case .deutschDeutschland:
                return "Vollbild ein"
            case .françaisFrance:
                return "Activer le mode plein écran"
            case .ελληνικάΕλλάδα:
                return "Είσοδος σε πλήρη οθόνη"
            case .עברית־ישראל:
                return "עבור למסך מלא"
            }
        })), action: #selector(NSWindow.toggleFullScreen(_: )))
        enterFullScreen.keyEquivalent = "f"
        enterFullScreen.keyEquivalentModifierMask = [.command, .control]
    }

    private func initializeWindowMenu() {
        let window = newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Ventana"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Window"

            case .deutschDeutschland:
                return "Fenster"
            case .françaisFrance:
                return "Fenêtre"

            case .ελληνικάΕλλάδα:
                return "Παράθυρο"
            case .עברית־ישראל:
                return "חלון"
            }
        })))
        defer { Application.shared.windowsMenu = window }
        endOfCustomMenuSection = window.parentMenuItem

        let minimize = window.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Minimizar"
            case .englishUnitedKingdom:
                return "Minimise"
            case .englishUnitedStates, .englishCanada:
                return "Minimize"
            case .deutschDeutschland:
                return "Im Dock ablegen"
            case .françaisFrance:
                return "Placer dans le Dock"
            case .ελληνικάΕλλάδα:
                return "Ελαχιστοποίηση"
            case .עברית־ישראל:
                return "מזער"
            }
        })), action: #selector(NSWindow.performMiniaturize(_: )))
        minimize.keyEquivalent = "m"
        minimize.keyEquivalentModifierMask = .command

        window.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña,
                 .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Zoom"
            case .deutschDeutschland:
                return "Zoomen"
            case .ελληνικάΕλλάδα:
                return "Ζουμ"

            case .françaisFrance:
                return "Réduire/agrandir"
            case .עברית־ישראל:
                return "הגדל/הקטן"
            }
        })), action: #selector(NSWindow.performZoom(_: )))

        window.newSeparator()

        window.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Traer todo al frente"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Bring All to Front"
            case .deutschDeutschland:
                return "Alle nach vorne bringen"
            case .françaisFrance:
                return "Tout ramener au premier plan"
            case .ελληνικάΕλλάδα:
                return "Μεταφωρά όλων σε πρώτο πλάνο"
            case .עברית־ישראל:
                return "הבא הכל קדימה"
            }
        })), action: #selector(NSApplication.arrangeInFront(_: )))
    }

    private func initializeHelpMenu() {
        let helpMenu = newSubmenu(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Ayuda"
            case .françaisFrance:
                return "Aide"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Help"
            case .deutschDeutschland:
                return "Hilfe"

            case .ελληνικάΕλλάδα:
                return "Βοήθεια"
            case .עברית־ישראל:
                return "עזרה"
            }
        })))
        defer { Application.shared.helpMenu = helpMenu }

        let helpItem = helpMenu.newEntry(labelled: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            // #workaround(Should include the application name.)
            case .españolEspaña:
                return "Ayuda"
            case .françaisFrance:
                return "Aide"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Help"
            case .deutschDeutschland:
                return "Hilfe"

            case .ελληνικάΕλλάδα:
                return "Βοήθεια"
            case .עברית־ישראל:
                return "עזרה"
            }
        })), action: #selector(NSApplication.showHelp(_: )))
        helpItem.keyEquivalent = "?"
        helpItem.keyEquivalentModifierMask = .command
        // #workaround(Should hide if the application does not have a help book.)
    }
}

#endif
