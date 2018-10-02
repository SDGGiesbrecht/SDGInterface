/*
 InterfaceLocalization.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal enum InterfaceLocalization : String, CaseIterable, InputLocalization {

    // MARK: - Cases

    case englishCanada = "en\u{2D}CA"

    // #workaround(SDGCornerstone 0.11.0, This may not be necessary once InputLocalization is refactored around CaseIterable.)
    internal static let cases: [InterfaceLocalization] = allCases

    // MARK: - Localization

    internal static let fallbackLocalization: InterfaceLocalization = .englishCanada
}
