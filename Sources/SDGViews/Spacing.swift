/*
 Spacing.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A spacing measurement.
public enum Spacing {

  /// The automatic spacing provided by the system.
  case automatic

  /// Custom spacing.
  case specific(Double)

  // MARK: - Properties

  #if canImport(AppKit) || canImport(UIKit)
    internal var string: String {
      switch self {
      case .automatic:
        return "\u{2D}"
      case .specific(let size):
        return "\u{2D}\(size)\u{2D}"
      }
    }
  #endif
}
