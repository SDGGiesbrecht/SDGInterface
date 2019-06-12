/*
 MenuBarLocalization.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

public enum MenuBarLocalization : String, CaseIterable, InputLocalization {

    // MARK: - Cases

    case españolEspaña = "es\u{2D}ES"

    case englishUnitedKingdom = "en\u{2D}GB"
    case englishUnitedStates = "en\u{2D}US"
    case englishCanada = "en\u{2D}CA"

    case deutschDeutschland = "de\u{2D}DE"

    case françaisFrance = "fr\u{2D}FR"

    case ελληνικάΕλλάδα = "el\u{2D}GR"

    case עברית־ישראל = "he\u{2D}IL"

    // MARK: - Localization

    public static let fallbackLocalization: MenuBarLocalization = .עברית־ישראל
}
