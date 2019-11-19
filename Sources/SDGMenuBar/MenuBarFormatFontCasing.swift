/*
 MenuBarFormatFontCasing.swift

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

  import SDGInterfaceBasics
  import SDGMenus

  import SDGInterfaceLocalizations

  extension MenuBar {

    private static func useDefault() -> MenuEntry<InterfaceLocalization> {
      let useDefault = MenuEntry(
        label: .static(
          UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Use Default"
            case .deutschDeutschland:
              return "Normal"
            }
          })
        )
      )
      useDefault.action = #selector(RichTextEditingResponder.resetCasing(_:))
      return useDefault
    }

    private static func latinate() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: .static(
          UserFacing<StrictString, InterfaceLocalization>({ localization in
            var latinate: StrictString
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              latinate = "Latinate"
            case .deutschDeutschland:
              return "Lateinische"
            }
            return latinate + " (I ↔ i)"
          })
        )
      )
    }

    private static func upperCaseLabel() -> UserFacing<StrictString, InterfaceLocalization> {
      return UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Upper Case"
        case .deutschDeutschland:
          return "Großbuchstaben"
        }
      })
    }
    private static func latinateUpperCase() -> MenuEntry<InterfaceLocalization> {
      let latinateUpperCase = MenuEntry(label: .static(upperCaseLabel()))
      latinateUpperCase.action = #selector(RichTextEditingResponder.makeLatinateUpperCase(_:))
      latinateUpperCase.indentationLevel = 1
      return latinateUpperCase
    }

    private static func smallUpperCaseLabel() -> UserFacing<StrictString, InterfaceLocalization> {
      return UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Small Upper Case"
        case .deutschDeutschland:
          return "Kapitälchen"
        }
      })
    }

    private static func latinateSmallUpperCase() -> MenuEntry<InterfaceLocalization> {
      let latinateSmallUpperCase = MenuEntry(label: .static(smallUpperCaseLabel()))
      latinateSmallUpperCase.action = #selector(RichTextEditingResponder.makeLatinateSmallCaps(_:))
      latinateSmallUpperCase.indentationLevel = 1
      return latinateSmallUpperCase
    }

    private static func lowerCaseLabel() -> UserFacing<StrictString, InterfaceLocalization> {
      return UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return "Lower Case"
        case .deutschDeutschland:
          return "Kleinbuchstaben"
        }
      })
    }
    private static func latinateLowerCase() -> MenuEntry<InterfaceLocalization> {
      let latinateLowerCase = MenuEntry(label: .static(lowerCaseLabel()))
      latinateLowerCase.action = #selector(RichTextEditingResponder.makeLatinateLowerCase(_:))
      latinateLowerCase.indentationLevel = 1
      return latinateLowerCase
    }

    private static func turkic() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: .static(
          UserFacing<StrictString, InterfaceLocalization>({ localization in
            var turkic: StrictString
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              turkic = "Turkic"
            case .deutschDeutschland:
              return "Türkische"
            }
            return turkic + " (I ↔ ı, İ ↔ i)"
          })
        )
      )
    }

    private static func turkicUpperCase() -> MenuEntry<InterfaceLocalization> {
      let turkicUpperCase = MenuEntry(label: .static(upperCaseLabel()))
      turkicUpperCase.action = #selector(RichTextEditingResponder.makeTurkicUpperCase(_:))
      turkicUpperCase.indentationLevel = 1
      return turkicUpperCase
    }

    private static func turkicSmallUpperCase() -> MenuEntry<InterfaceLocalization> {
      let turkicSmallUpperCase = MenuEntry(label: .static(smallUpperCaseLabel()))
      turkicSmallUpperCase.action = #selector(RichTextEditingResponder.makeTurkicSmallCaps(_:))
      turkicSmallUpperCase.indentationLevel = 1
      return turkicSmallUpperCase
    }

    private static func turkicLowerCase() -> MenuEntry<InterfaceLocalization> {
      let turkicLowerCase = MenuEntry(label: .static(lowerCaseLabel()))
      turkicLowerCase.action = #selector(RichTextEditingResponder.makeTurkicLowerCase(_:))
      turkicLowerCase.indentationLevel = 1
      return turkicLowerCase
    }

    internal static func casing() -> Menu<InterfaceLocalization> {
      let casing = Menu(
        label: .static(
          UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Casing"
            case .deutschDeutschland:
              return "Buchstabengröße"
            }
          })
        )
      )
      casing.entries = [
        .entry(useDefault()),
        .separator,
        .entry(latinate()),
        .entry(latinateUpperCase()),
        .entry(latinateSmallUpperCase()),
        .entry(latinateLowerCase()),
        .separator,
        .entry(turkic()),
        .entry(turkicUpperCase()),
        .entry(turkicSmallUpperCase()),
        .entry(turkicLowerCase()),
      ]
      return casing
    }
  }
#endif
