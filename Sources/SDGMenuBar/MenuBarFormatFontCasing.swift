/*
 MenuBarFormatFontCasing.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if os(macOS)
import AppKit

import SDGText
import SDGLocalization

import SDGMenus
import SDGInterfaceElements

import SDGInterfaceLocalizations

extension MenuBar {

    private static func useDefault() -> MenuEntry<InterfaceLocalization> {
        let useDefault = MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use Default"
            }
        })))
        useDefault.action = #selector(NSTextView.resetCasing(_:))
        return useDefault
    }

    private static func latinate() -> MenuEntry<InterfaceLocalization> {
        return MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            var latinate: StrictString
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                latinate = "Latinate"
            }
            return latinate + " (I ↔ i)"
        })))
    }

    private static func upperCaseLabel() -> UserFacing<StrictString, InterfaceLocalization> {
        return UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Upper Case"
            }
        })
    }
    private static func latinateUpperCase() -> MenuEntry<InterfaceLocalization> {
        let latinateUpperCase = MenuEntry(label: .static(upperCaseLabel()))
        latinateUpperCase.action = #selector(NSTextView.makeLatinateUpperCase(_:))
        latinateUpperCase.indentationLevel = 1
        return latinateUpperCase
    }

    private static func smallUpperCaseLabel() -> UserFacing<StrictString, InterfaceLocalization> {
        return UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Small Upper Case"
            }
        })
    }

    private static func latinateSmallUpperCase() -> MenuEntry<InterfaceLocalization> {
        let latinateSmallUpperCase = MenuEntry(label: .static(smallUpperCaseLabel()))
        latinateSmallUpperCase.action = #selector(NSTextView.makeLatinateSmallCaps(_:))
        latinateSmallUpperCase.indentationLevel = 1
        return latinateSmallUpperCase
    }

    private static func lowerCaseLabel() -> UserFacing<StrictString, InterfaceLocalization> {
        return UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Lower Case"
            }
        })
    }
    private static func latinateLowerCase() -> MenuEntry<InterfaceLocalization> {
        let latinateLowerCase = MenuEntry(label: .static(lowerCaseLabel()))
        latinateLowerCase.action = #selector(NSTextView.makeLatinateLowerCase(_:))
        latinateLowerCase.indentationLevel = 1
        return latinateLowerCase
    }

    private static func turkic() -> MenuEntry<InterfaceLocalization> {
        return MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            var turkic: StrictString
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                turkic = "Turkic"
            }
            return turkic + " (I ↔ ı, İ ↔ i)"
        })))
    }

    private static func turkicUpperCase() -> MenuEntry<InterfaceLocalization> {
        let turkicUpperCase = MenuEntry(label: .static(upperCaseLabel()))
        turkicUpperCase.action = #selector(NSTextView.makeTurkicUpperCase(_:))
        turkicUpperCase.indentationLevel = 1
        return turkicUpperCase
    }

    private static func turkicSmallUpperCase() -> MenuEntry<InterfaceLocalization> {
        let turkicSmallUpperCase = MenuEntry(label: .static(smallUpperCaseLabel()))
        turkicSmallUpperCase.action = #selector(NSTextView.makeTurkicSmallCaps(_:))
        turkicSmallUpperCase.indentationLevel = 1
        return turkicSmallUpperCase
    }

    private static func turkicLowerCase() -> MenuEntry<InterfaceLocalization> {
        let turkicLowerCase = MenuEntry(label: .static(lowerCaseLabel()))
        turkicLowerCase.action = #selector(NSTextView.makeTurkicLowerCase(_:))
        turkicLowerCase.indentationLevel = 1
        return turkicLowerCase
    }

    internal static func casing() -> Menu<InterfaceLocalization> {
        let casing = Menu(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Casing"
            }
        })))
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
