/*
 LegacyMode.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@testable import SDGProgressIndicators

func forAllLegacyModes(_ closure: () throws -> Void) rethrows {
  for mode in [false, true] {
    try withLegacyMode(mode, closure)
  }
}

func withLegacyMode(_ closure: () throws -> Void) rethrows {
  try withLegacyMode(true, closure)
}

private func withLegacyMode(_ mode: Bool, _ closure: () throws -> Void) rethrows {
  let previous = legacyMode
  legacyMode = mode
  defer { legacyMode = previous }

  try closure()
}
