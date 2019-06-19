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
import AppKit
#endif

import SDGMathematics
import SDGText
import SDGLocalization

import SDGInterfaceBasics
import SDGMenus

import SDGInterfaceLocalizations

/// An application’s menu bar.
///
/// `MenuBar` is a fully localized version of Interface Builder’s template with several useful additions.
///
/// Some menu items only appear if the application provides details they need to operate:
/// - “Preferences...” appears if the application has a preference manager.
/// - “Help” appears if a help book is specified in the `Info.plist` file.
public final class MenuBar {

    // MARK: - Class Properties

    /// The menu bar.
    public static let menuBar: MenuBar = MenuBar()

    // MARK: - Initialization

    private init() {
        menu = Menu(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Menu Bar"
            }
        })))
        menu.entries = [
            .submenu(MenuBar.application()),
            .submenu(MenuBar.file())
        ]

        initializeEditMenu()
        initializeFormatMenu()
        initializeViewMenu()
        initializeWindowMenu()
        initializeHelpMenu()

        menuDidSet()
    }

    // MARK: - Properties

    public var menu: AnyMenu {
        didSet {
            menuDidSet()
        }
    }
    private func menuDidSet() {
        #if canImport(AppKit)
        NSApplication.shared.mainMenu = menu.native
        #endif
    }

    private var endOfPreferenceSection: NSMenuItem!
    private var endOfCustomMenuSection: NSMenuItem!

    // MARK: - Modification

    /// Creates a new menu in the application‐specific section. (Before the “Window” menu.)
    ///
    /// - Parameters:
    ///     - label: A label for the new submenu.
    public func addApplicationSpecificSubmenu(_ menu: AnyMenu) {
        let index: Int
        if menu.entries.count ≥ 2 {
            index = menu.entries.index(menu.entries.endIndex, offsetBy: −2)
        } else {
            index = 0
        }
        menu.entries.insert(.submenu(menu), at: index)
    }

    // MARK: - Items

    internal static func fallbackApplicationName(quotationMarks: (leading: StrictString, trailing: StrictString)) -> StrictString {
        var result = quotationMarks.leading
        result.append("\u{2068}")
        result.append(contentsOf: ApplicationNameForm.localizedIsolatedForm.resolved())
        result.append("\u{2069}")
        result.append(contentsOf: quotationMarks.trailing)
        return result
    }

    private func initializeFormatMenu() {

        let format = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        let font = format.Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        let showFonts = fontMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSFontManager.orderFrontFontPanel(_:)))
        showFonts.target = NSFontManager.shared
        showFonts.hotKey = "t"
        showFonts.hotKeyModifiers = .command

        let bold = fontMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSFontManager.addFontTrait(_:)))
        bold.target = NSFontManager.shared
        bold.tag = 2
        bold.hotKey = "b"
        bold.hotKeyModifiers = .command

        let italic = fontMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSFontManager.addFontTrait(_:)))
        italic.target = NSFontManager.shared
        italic.tag = 1
        italic.hotKey = "i"
        italic.hotKeyModifiers = .command

        let underline = fontMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.underline(_:)))
        underline.hotKey = "u"
        underline.hotKeyModifiers = .command

        font.newSeparator()

        let bigger = fontMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSFontManager.modifyFont(_:)))
        bigger.target = NSFontManager.shared
        bigger.tag = 3
        bigger.hotKey = "+"
        bigger.hotKeyModifiers = .command

        let smaller = fontMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSFontManager.modifyFont(_:)))
        smaller.target = NSFontManager.shared
        smaller.tag = 4
        smaller.hotKey = "\u{2D}"
        smaller.hotKeyModifiers = .command

        font.newSeparator()

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

        let ligatures = font.Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        ligaturesMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.useStandardLigatures(_:)))

        ligaturesMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.turnOffLigatures(_:)))

        ligaturesMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.useAllLigatures(_:)))

        let baseline = font.Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        baselineMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.resetBaseline(_:)))

        baselineMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.makeSuperscript(_:)))

        baselineMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.makeSubscript(_:)))

        baselineMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.raiseBaseline(_:)))

        baselineMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSTextView.lowerBaseline(_:)))

        let casing = font.Menu(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Casing"
            }
        })))

        casingMenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use Default"
            }
        })), action: #selector(NSTextView.resetCasing(_:)))

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

        casingMenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            var latinate: StrictString
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                latinate = "Latinate"
            }
            return latinate + " (I ↔ i)"
        })))

        let latinateUpperCase = casingMenuEntry(label: .static(upperCase), action: #selector(NSTextView.makeLatinateUpperCase(_:)))
        latinateUpperCase.indentationLevel = 1

        let latinateSmallUpperCase = casingMenuEntry(label: .static(smallUpperCase), action: #selector(NSTextView.makeLatinateSmallCaps(_:)))
        latinateSmallUpperCase.indentationLevel = 1

        let latinateLowerCase = casingMenuEntry(label: .static(lowerCase), action: #selector(NSTextView.makeLatinateLowerCase(_:)))
        latinateLowerCase.indentationLevel = 1

        casing.newSeparator()

        casingMenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            var turkic: StrictString
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                turkic = "Turkic"
            }
            return turkic + " (I ↔ ı, İ ↔ i)"
        })))

        let turkicUpperCase = casingMenuEntry(label: .static(upperCase), action: #selector(NSTextView.makeTurkicUpperCase(_:)))
        turkicUpperCase.indentationLevel = 1

        let turkicSmallUpperCase = casingMenuEntry(label: .static(smallUpperCase), action: #selector(NSTextView.makeTurkicSmallCaps(_:)))
        turkicSmallUpperCase.indentationLevel = 1

        let turkicLowerCase = casingMenuEntry(label: .static(lowerCase), action: #selector(NSTextView.makeTurkicLowerCase(_:)))
        turkicLowerCase.indentationLevel = 1

        font.newSeparator()

        let showColours = fontMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSApplication.orderFrontColorPanel(_:)))
        showColours.hotKey = "C"
        showColours.hotKeyModifiers = .command

        font.newSeparator()

        let copyStyle = fontMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.copyFont(_:)))
        copyStyle.hotKey = "c"
        copyStyle.hotKeyModifiers = [.command, .option]

        let pasteStyle = fontMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSText.pasteFont(_:)))
        pasteStyle.hotKey = "v"
        pasteStyle.hotKeyModifiers = [.command, .option]

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

    private func initializeViewMenu() {
        class Responder : NSObject {
            @objc func toggleSourceList(_ sender: Any?) {}
        }

        let view = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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

        let showToolbar = viewMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSWindow.toggleToolbarShown(_:)))
        showToolbar.hotKey = "t"
        showToolbar.hotKeyModifiers = [.command, .option]

        viewMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSWindow.runToolbarCustomizationPalette(_:)))

        view.newSeparator()

        let showSideBar = viewMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(Responder.toggleSourceList(_:)))
        showSideBar.hotKey = "s"
        showSideBar.hotKeyModifiers = [.command, .control]

        let enterFullScreen = viewMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSWindow.toggleFullScreen(_:)))
        enterFullScreen.hotKey = "f"
        enterFullScreen.hotKeyModifiers = [.command, .control]
    }

    private func initializeWindowMenu() {
        let window = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        defer { NSApplication.shared.windowsMenu = window }
        endOfCustomMenuSection = window.parentMenuItem

        let minimize = windowMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSWindow.performMiniaturize(_:)))
        minimize.hotKey = "m"
        minimize.hotKeyModifiers = .command

        windowMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSWindow.performZoom(_:)))

        window.newSeparator()

        windowMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })), action: #selector(NSApplication.arrangeInFront(_:)))
    }

    private func initializeHelpMenu() {
        let helpMenu = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        defer { NSApplication.shared.helpMenu = helpMenu }

        let helpItem = helpMenuMenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                let deLaAplicación = ProcessInfo.applicationName(.español(.de))
                    ?? "de \(MenuBar.fallbackApplicationName(quotationMarks: ("«", "»")))"
                return "Ayuda \(deLaAplicación)"
            case .françaisFrance:
                let deLApplication = ProcessInfo.applicationName(.français(.de))
                    ?? "de \(MenuBar.fallbackApplicationName(quotationMarks: ("« ", " »")))"
                return "Aide \(deLApplication)"

            case .englishUnitedKingdom:
                let theApplication = ProcessInfo.applicationName(.english(.unitedKingdom))
                    ?? MenuBar.fallbackApplicationName(quotationMarks: ("‘", "’"))
                return "\(theApplication) Help"
            case .englishUnitedStates:
                let theApplication = ProcessInfo.applicationName(.english(.unitedStates))
                    ?? MenuBar.fallbackApplicationName(quotationMarks: ("“", "”"))
                return "\(theApplication) Help"
            case .englishCanada:
                let theApplication = ProcessInfo.applicationName(.english(.canada))
                    ?? MenuBar.fallbackApplicationName(quotationMarks: ("“", "”"))
                return "\(theApplication) Help"
            case .deutschDeutschland:
                let derAnwendung = ProcessInfo.applicationName(.deutsch(.dativ))
                    ?? MenuBar.fallbackApplicationName(quotationMarks: ("„", "“"))
                return "Hilfe zu \(derAnwendung)"

            case .ελληνικάΕλλάδα:
                let τηνΕφαρμογή = ProcessInfo.applicationName(.ελληνικά(.αιτιατική))
                    ?? MenuBar.fallbackApplicationName(quotationMarks: ("«", "»"))
                return "Βοήθεια για \(τηνΕφαρμογή)"
            case .עברית־ישראל:
                let היישום = ProcessInfo.applicationName(.עברית)
                    ?? MenuBar.fallbackApplicationName(quotationMarks: ("”", "“"))
                return "עזרה עבור \(היישום)"
            }
        })), action: #selector(NSApplication.showHelp(_:)))
        helpItem.hotKey = "?"
        helpItem.hotKeyModifiers = .command
        if Bundle.main.infoDictionary?["CFBundleHelpBookName"] == nil {
            helpItem.isHidden = true
        }
    }
}

#endif

#if !os(tvOS)
internal enum MenuLabels {

    static let normalizeText = Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom:
            return "Normalise Text"
        case .englishUnitedStates, .englishCanada:
            return "Normalize Text"
        }
    }))

    static let showCharacterInformation = Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Show Character Information"
        }
    }))
}
