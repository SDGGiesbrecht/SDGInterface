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
#endif

import SDGText
import SDGLocalization

import SDGMenus

import SDGInterfaceLocalizations

extension MenuBar {

    private static func useDefault() -> MenuEntry<InterfaceLocalization> {
        MenuEntry(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Use Default"
            }
        })), action: #selector(NSTextView.resetCasing(_:)))
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
        let latinateUpperCase = MenuEntry(label: .static(upperCase), action: #selector(NSTextView.makeLatinateUpperCase(_:)))
        latinateUpperCase.indentationLevel = 1
    }

    private static func smallUpperCaseLabel() -> UserFacing<StrictString, InterfaceLocalization> {
        UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Small Upper Case"
            }
        })
    }

    private static func latinateSmallUpperCase() -> MenuEntry<InterfaceLocalization> {
        let latinateSmallUpperCase = MenuEntry(label: .static(smallUpperCase), action: #selector(NSTextView.makeLatinateSmallCaps(_:)))
        latinateSmallUpperCase.indentationLevel = 1
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
        let latinateLowerCase = MenuEntry(label: .static(lowerCase), action: #selector(NSTextView.makeLatinateLowerCase(_:)))
        latinateLowerCase.indentationLevel = 1
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
        let turkicUpperCase = MenuEntry(label: .static(upperCase), action: #selector(NSTextView.makeTurkicUpperCase(_:)))
        turkicUpperCase.indentationLevel = 1
    }

    private static func turkicSmallUpperCase() -> MenuEntry<InterfaceLocalization> {
        let turkicSmallUpperCase = MenuEntry(label: .static(smallUpperCase), action: #selector(NSTextView.makeTurkicSmallCaps(_:)))
        turkicSmallUpperCase.indentationLevel = 1
    }

    private static func turkicLowerCase() -> MenuEntry<InterfaceLocalization> {
        let turkicLowerCase = MenuEntry(label: .static(lowerCase), action: #selector(NSTextView.makeTurkicLowerCase(_:)))
        turkicLowerCase.indentationLevel = 1
    }

    internal static func casing() -> Menu<MenuBarLocalization> {
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
