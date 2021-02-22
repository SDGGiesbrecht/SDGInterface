/*
 MenuBar.Format.Font.swift

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

  import SDGInterface

  import SDGInterfaceLocalizations

  extension MenuBar {

    private static func showFonts() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "t",
        action: #selector(NSFontManager.orderFrontFontPanel(_:))
      )
      .target(NSFontManager.shared)
    }

    private static func bold() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "b",
        action: #selector(NSFontManager.addFontTrait(_:))
      )
      .target(NSFontManager.shared)
      .tag(2)
    }

    private static func italic() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "i",
        action: #selector(NSFontManager.addFontTrait(_:))
      )
      .target(NSFontManager.shared)
      .tag(1)
    }

    private static func underline() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "u",
        action: #selector(NSText.underline(_:))
      )
    }

    private static func bigger() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "+",
        action: #selector(NSFontManager.modifyFont(_:))
      )
      .target(NSFontManager.shared)
      .tag(3)
    }

    private static func smaller() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "\u{2D}",
        action: #selector(NSFontManager.modifyFont(_:))
      )
      .target(NSFontManager.shared)
      .tag(4)
    }

    private static func showColours() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: .command,
        hotKey: "C",
        action: #selector(NSApplication.orderFrontColorPanel(_:))
      )
    }

    private static func copyStyle() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: [.command, .option],
        hotKey: "c",
        action: #selector(NSText.copyFont(_:))
      )
    }

    private static func pasteStyle() -> MenuEntry<MenuBarLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        hotKeyModifiers: [.command, .option],
        hotKey: "v",
        action: #selector(NSText.pasteFont(_:))
      )
    }

    internal static func font() -> Menu<MenuBarLocalization> {
      return Menu(
        label: UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        }),
        entries: [
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
          .entry(pasteStyle()),
        ]
      )
    }
  }
#endif
