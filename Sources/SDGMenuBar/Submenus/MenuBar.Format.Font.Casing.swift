/*
 MenuBar.Format.Font.Casing.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Use Default"
          case .deutschDeutschland:
            return "Normal"
          }
        }),
        action: #selector(RichTextEditingResponder.resetCasing(_:))
      )
    }

    private static func latinate() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
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
      return MenuEntry(
        label: upperCaseLabel(),
        action: #selector(RichTextEditingResponder.makeLatinateUpperCase(_:))
      )
      #warning("Indent: 1")
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
      return MenuEntry(
        label: smallUpperCaseLabel(),
        action: #selector(RichTextEditingResponder.makeLatinateSmallCaps(_:))
      )
      #warning("Indent: 1")
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
      return MenuEntry(
        label: lowerCaseLabel(),
        action: #selector(RichTextEditingResponder.makeLatinateLowerCase(_:))
      )
      #warning("Indent: 1")
    }

    private static func turkic() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
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
    }

    private static func turkicUpperCase() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: upperCaseLabel(),
        action: #selector(RichTextEditingResponder.makeTurkicUpperCase(_:))
      )
      #warning("Indent: 1")
    }

    private static func turkicSmallUpperCase() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: smallUpperCaseLabel(),
        action: #selector(RichTextEditingResponder.makeTurkicSmallCaps(_:))
      )
      #warning("Indent: 1")
    }

    private static func turkicLowerCase() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: lowerCaseLabel(),
        action: #selector(RichTextEditingResponder.makeTurkicLowerCase(_:))
      )
      #warning("Indent: 1")
    }

    internal static func casing() -> Menu<InterfaceLocalization> {
      return Menu(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Casing"
          case .deutschDeutschland:
            return "Buchstabengröße"
          }
        }),
        entries: [
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
      )
    }
  }
#endif
