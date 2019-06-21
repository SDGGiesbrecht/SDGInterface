/*
 MenuBarHelp.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(AppKit)
import AppKit
#endif

import SDGText
import SDGLocalization

import SDGMenus

import SDGInterfaceLocalizations

extension MenuBar {

    private static func helpEntry() -> MenuEntry<MenuBarLocalization> {
        let help = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        })))
        #if canImport(AppKit)
        help.action = #selector(NSApplication.showHelp(_:))
        #else
        help.isHidden = true
        #endif
        help.hotKey = "?"
        help.hotKeyModifiers = .command
        if Bundle.main.infoDictionary?["CFBundleHelpBookName"] == nil {
            help.isHidden = true
        }
        return help
    }

    internal static func help() -> Menu<MenuBarLocalization> {
        let help = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
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
        help.entries = [
            .entry(helpEntry())
        ]
        #if canImport(AppKit)
        NSApplication.shared.helpMenu = help.native
        #endif
        return help
    }
}
