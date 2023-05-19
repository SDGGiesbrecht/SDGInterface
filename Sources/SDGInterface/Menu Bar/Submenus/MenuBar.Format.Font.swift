/*
 MenuBar.Format.Font.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
        selector: #selector(NSFontManager.orderFrontFontPanel(_:)),
        target: NSFontManager.shared
      )
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
        selector: #selector(NSFontManager.addFontTrait(_:)),
        target: NSFontManager.shared,
        platformTag: 2
      )
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
        selector: #selector(NSFontManager.addFontTrait(_:)),
        target: NSFontManager.shared,
        platformTag: 1
      )
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
        selector: #selector(NSText.underline(_:))
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
        selector: #selector(NSFontManager.modifyFont(_:)),
        target: NSFontManager.shared,
        platformTag: 3
      )
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
        selector: #selector(NSFontManager.modifyFont(_:)),
        target: NSFontManager.shared,
        platformTag: 4
      )
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
        selector: #selector(NSApplication.orderFrontColorPanel(_:))
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
        selector: #selector(NSText.copyFont(_:))
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
        selector: #selector(NSText.pasteFont(_:))
      )
    }

    internal static func font() -> Menu<
      MenuBarLocalization,
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<
                  MenuComponentsConcatenation<
                    MenuComponentsConcatenation<
                      MenuComponentsConcatenation<
                        MenuComponentsConcatenation<
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<
                              MenuComponentsConcatenation<
                                MenuComponentsConcatenation<
                                  MenuComponentsConcatenation<
                                    MenuComponentsConcatenation<
                                      MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                                    >, MenuEntry<MenuBarLocalization>
                                  >, MenuEntry<MenuBarLocalization>
                                >, Divider
                              >, MenuEntry<MenuBarLocalization>
                            >, MenuEntry<MenuBarLocalization>
                          >, Divider
                        >,
                        Menu<
                          MenuBarLocalization,
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<
                              MenuComponentsConcatenation<
                                MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                              >, MenuEntry<MenuBarLocalization>
                            >, MenuEntry<MenuBarLocalization>
                          >
                        >
                      >,
                      Menu<
                        MenuBarLocalization,
                        MenuComponentsConcatenation<
                          MenuComponentsConcatenation<
                            MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                          >, MenuEntry<MenuBarLocalization>
                        >
                      >
                    >,
                    Menu<
                      MenuBarLocalization,
                      MenuComponentsConcatenation<
                        MenuComponentsConcatenation<
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<
                              MenuEntry<MenuBarLocalization>, MenuEntry<MenuBarLocalization>
                            >, MenuEntry<MenuBarLocalization>
                          >, MenuEntry<MenuBarLocalization>
                        >, MenuEntry<MenuBarLocalization>
                      >
                    >
                  >,
                  Menu<
                    InterfaceLocalization,
                    MenuComponentsConcatenation<
                      MenuComponentsConcatenation<
                        MenuComponentsConcatenation<
                          MenuEntry<InterfaceLocalization>, MenuEntry<InterfaceLocalization>
                        >, MenuEntry<InterfaceLocalization>
                      >, MenuEntry<InterfaceLocalization>
                    >
                  >
                >, Divider
              >, MenuEntry<MenuBarLocalization>
            >, Divider
          >, MenuEntry<MenuBarLocalization>
        >, MenuEntry<MenuBarLocalization>
      >
    > {
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
        entries: {
          showFonts()
          bold()
          italic()
          underline()
          Divider()
          bigger()
          smaller()
          Divider()
          kern()
          ligatures()
          baseline()
          casing()
          Divider()
          showColours()
          Divider()
          copyStyle()
          pasteStyle()
        }
      )
    }
  }
#endif
