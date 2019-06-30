/*
 MenuBarFormat.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(Linux) && !os(iOS) && !os(watchOS) && !os(tvOS)
import AppKit

import SDGText
import SDGLocalization

import SDGMenus

import SDGInterfaceLocalizations

extension MenuBar {

    internal static func format() -> Menu<MenuBarLocalization> {
        let format = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Formato"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                 .deutschDeutschland,
                 .françaisFrance:
                return "Format"

            case .עברית־ישראל:
                return "עיצוב"
            case .ελληνικάΕλλάδα:
                return "Μορφή"
            }
        })))
        format.entries = [
            .submenu(font()),
            .submenu(text())
        ]
        return format
    }
}
#endif
