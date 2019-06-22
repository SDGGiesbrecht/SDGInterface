/*
 MenuBarFormatFont.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit

import SDGText
import SDGLocalization

import SDGMenus

import SDGInterfaceLocalizations

extension MenuBar {

    private static func showFonts() -> MenuEntry<MenuBarLocalization> {
        let showFonts = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })))
        showFonts.action = #selector(NSFontManager.orderFrontFontPanel(_:))
        showFonts.target = NSFontManager.shared
        showFonts.hotKey = "t"
        showFonts.hotKeyModifiers = .command
        return showFonts
    }

    private static func bold() -> MenuEntry<MenuBarLocalization> {
        let bold = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })))
        bold.action = #selector(NSFontManager.addFontTrait(_:))
        bold.target = NSFontManager.shared
        bold.tag = 2
        bold.hotKey = "b"
        bold.hotKeyModifiers = .command
        return bold
    }

    private static func italic() -> MenuEntry<MenuBarLocalization> {
        let italic = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })))
        italic.action = #selector(NSFontManager.addFontTrait(_:))
        italic.target = NSFontManager.shared
        italic.tag = 1
        italic.hotKey = "i"
        italic.hotKeyModifiers = .command
        return italic
    }

    private static func underline() -> MenuEntry<MenuBarLocalization> {
        let underline = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })))
        underline.action = #selector(NSText.underline(_:))
        underline.hotKey = "u"
        underline.hotKeyModifiers = .command
        return underline
    }

    private static func bigger() -> MenuEntry<MenuBarLocalization> {
        let bigger = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })))
        bigger.action = #selector(NSFontManager.modifyFont(_:))
        bigger.target = NSFontManager.shared
        bigger.tag = 3
        bigger.hotKey = "+"
        bigger.hotKeyModifiers = .command
        return bigger
    }

    private static func smaller() -> MenuEntry<MenuBarLocalization> {
        let smaller = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })))
        smaller.action = #selector(NSFontManager.modifyFont(_:))
        smaller.target = NSFontManager.shared
        smaller.tag = 4
        smaller.hotKey = "\u{2D}"
        smaller.hotKeyModifiers = .command
        return smaller
    }

    private static func showColours() -> MenuEntry<MenuBarLocalization> {
        let showColours = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })))
        showColours.action = #selector(NSApplication.orderFrontColorPanel(_:))
        showColours.hotKey = "C"
        showColours.hotKeyModifiers = .command
        return showColours
    }

    private static func copyStyle() -> MenuEntry<MenuBarLocalization> {
        let copyStyle = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })))
        copyStyle.action = #selector(NSText.copyFont(_:))
        copyStyle.hotKey = "c"
        copyStyle.hotKeyModifiers = [.command, .option]
        return copyStyle
    }

    private static func pasteStyle() -> MenuEntry<MenuBarLocalization> {
        let pasteStyle = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })))
        pasteStyle.action = #selector(NSText.pasteFont(_:))
        pasteStyle.hotKey = "v"
        pasteStyle.hotKeyModifiers = [.command, .option]
        return pasteStyle
    }

    internal static func font() -> Menu<MenuBarLocalization> {
        let font = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        font.entries = [
            .entry(showFonts()),
            .entry(bold()),
            .entry(italic()),
            .entry(underline()),
            .separator,
            .entry(bigger()),
            .entry(smaller()),
            .separator,
            .submenu(kern()),
            .submenu(ligatures()),
            .submenu(baseline()),
            .submenu(casing()),
            .separator,
            .entry(showColours()),
            .separator,
            .entry(copyStyle()),
            .entry(pasteStyle())
        ]
        return font
    }
}
#endif
