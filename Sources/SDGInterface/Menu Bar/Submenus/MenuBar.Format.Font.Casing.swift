/*
 MenuBar.Format.Font.Casing.swift

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

    private static func useDefault() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Use Default"
          case .deutschDeutschland:
            return "Normal"
          }
        }),
        selector: #selector(RichTextEditingResponder.resetCasing(_:))
      )
    }

    private static func upperCase() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Upper Case"
          case .deutschDeutschland:
            return "Großbuchstaben"
          }
        }),
        selector: #selector(RichTextEditingResponder.makeUpperCase(_:))
      )
    }

    private static func smallUpperCase() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Small Upper Case"
          case .deutschDeutschland:
            return "Kapitälchen"
          }
        }),
        selector: #selector(RichTextEditingResponder.makeSmallCaps(_:))
      )
    }

    private static func lowerCase() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Lower Case"
          case .deutschDeutschland:
            return "Kleinbuchstaben"
          }
        }),
        selector: #selector(RichTextEditingResponder.makeLowerCase(_:))
      )
    }

    internal static func casing() -> Menu<
      InterfaceLocalization,
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuEntry<InterfaceLocalization>, MenuEntry<InterfaceLocalization>
          >, MenuEntry<InterfaceLocalization>
        >, MenuEntry<InterfaceLocalization>
      >
    > {
      return Menu(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Casing"
          case .deutschDeutschland:
            return "Buchstabengröße"
          }
        }),
        entries: {
          useDefault()
          upperCase()
          smallUpperCase()
          lowerCase()
        }
      )
    }
  }
#endif
