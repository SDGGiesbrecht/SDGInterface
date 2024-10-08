/*
 APILocalization.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

public enum APILocalization: String, CaseIterable, InputLocalization {

  // MARK: - Cases

  case englishCanada = "en\u{2D}CA"

  // MARK: - Localization

  public static let fallbackLocalization: APILocalization = .englishCanada
}
