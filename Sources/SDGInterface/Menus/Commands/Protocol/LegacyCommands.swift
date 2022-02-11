/*
 LegacyCommands.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The subset of the `Commands` protocol that can be conformed to even on platform versions preceding SwiftUI’s availability.
public protocol LegacyCommands {

  /// The type of the menu components.
  associatedtype MenuComponentsType: LegacyMenuComponents

  /// Constructs menu components from the commansds.
  func menuComponents() -> MenuComponentsType
}
