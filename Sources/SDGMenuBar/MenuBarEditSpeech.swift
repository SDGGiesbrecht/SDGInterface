/*
 MenuBarEditSpeech.swift

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

    private static func startSpeaking() -> MenuEntry<MenuBarLocalization> {
        let startSpeaking = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Iniciar locución"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Start Speaking"
            case .deutschDeutschland:
                return "Sprachausgabe starten"
            case .françaisFrance:
                return "Commencer la lecture"
            case .ελληνικάΕλλάδα:
                return "Έναρξη εκφώνησης"
            case .עברית־ישראל:
                return "התחל לדבר"
            }
        })))
        startSpeaking.action = #selector(NSTextView.startSpeaking(_:))
        return startSpeaking
    }

    private static func stopSpeaking() -> MenuEntry<MenuBarLocalization> {
        let stopSpeaking = MenuEntry(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Detener locución"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Stop Speaking"
            case .deutschDeutschland:
                return "Sprachausgabe stoppen"
            case .françaisFrance:
                return "Arrêter la lecture"
            case .ελληνικάΕλλάδα:
                return "Διακοπή εκφώνησης"
            case .עברית־ישראל:
                return "הפסק לדבר"
            }
        })))
        stopSpeaking.action = #selector(NSTextView.stopSpeaking(_:))
        return stopSpeaking
    }

    internal static func speech() -> Menu<MenuBarLocalization> {
        let speech = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Habla"

            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Speech"
            case .deutschDeutschland:
                return "Sprachausgabe"

            case .françaisFrance:
                return "Parole"
            case .ελληνικάΕλλάδα:
                return "Εκφώνηση"
            case .עברית־ישראל:
                return "דיבור"
            }
        })))
        speech.entries = [
            .entry(startSpeaking()),
            .entry(stopSpeaking())
        ]
        return speech
    }
}
#endif
