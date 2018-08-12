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
    }

    // MARK: - Properties

    private var endOfPreferenceSection: NSMenuItem!

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
        preferences.action = #selector(ApplicationDelegate.openPreferences)
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
        })), action: #selector(Application.hide))
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
        })), action: #selector(Application.hideOtherApplications))
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
        })), action: #selector(Application.unhideAllApplications))

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
        })), action: #selector(Application.terminate))
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
        })), action: #selector(NSDocumentController.newDocument))
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
        })), action: #selector(NSDocumentController.clearRecentDocuments))

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
        })), action: #selector(NSWindow.performClose))
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
        })), action: #selector(NSDocument.rename))

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
        })), action: #selector(NSDocument.move))

        let revertToSaved = file.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Revert to Saved"
            }
        })), action: #selector(NSDocument.revertToSaved))
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
        })), action: #selector(NSDocument.runPageLayout))
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
        })), action: #selector(NSView.printView))
        print.keyEquivalent = "p"
        print.keyEquivalentModifierMask = .command
    }
}

#endif
