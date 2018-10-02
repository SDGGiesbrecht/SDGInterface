/*
 InterfaceLocalization.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

public enum InterfaceLocalization : String, CaseIterable, InputLocalization {

    // MARK: - Cases

    case englishUnitedKingdom = "en\u{2D}GB"
    case englishUnitedStates = "en\u{2D}US"
    case englishCanada = "en\u{2D}CA"

    // #workaround(SDGCornerstone 0.11.0, This may not be necessary once InputLocalization is refactored around CaseIterable.)
    public static var cases: [InterfaceLocalization] = allCases

    // MARK: - Localization

    public static let fallbackLocalization: InterfaceLocalization = .englishUnitedKingdom
}
