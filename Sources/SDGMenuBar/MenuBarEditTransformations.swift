/*
 MenuBarEditTransformations.swift

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
import SDGInterfaceElements

import SDGInterfaceLocalizations

extension MenuBar {

    // Normalize Text (See context menu.)

    internal static func transformations() -> Menu<MenuBarLocalization> {
        let transformations = Menu(label: .static(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .españolEspaña:
                return "Transformaciones"
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                 .françaisFrance:
                return "Transformations"
            case .deutschDeutschland:
                return "Transformationen"

            case .ελληνικάΕλλάδα:
                return "Μετασχηματισμοί"
            case .עברית־ישראל:
                return "המרות"
            }
        })))
        transformations.entries = [
            .entry(_normalizeText())

            // “Make Upper Case” does not belong here. Upper‐case‐only is a font style, not a semantic aspect of the text. Attempting to fake it by switching to capital letters (a) results in semantically incorrect text, and (b) is irreversable. A font‐based version is available under the “Font” menu instead.

            // “Make Lower Case” is never useful. Instead, reversion from an upper‐case‐only font style to normally cased font—which preserves true capitals—is available under the “Font” menu.

            // “Capitalize” is just not possible for a machine to do properly in any language.
        ]
        return transformations
    }
    #endif
}
