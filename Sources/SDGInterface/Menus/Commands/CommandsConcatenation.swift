/*
 CommandsConcatenation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

/// A concatenation of commands.
public struct CommandsConcatenation<Leading, Trailing>: LegacyCommands
where Leading: LegacyCommands, Trailing: LegacyCommands {

  // MARK: - Initialization

  internal init(_ leading: Leading, _ trailing: Trailing) {
    self.leading = leading
    self.trailing = trailing
  }

  // MARK: - Properties

  private let leading: Leading
  private let trailing: Trailing

  // MARK: - LegacyCommands

  public func menuComponents() -> MenuComponentsConcatenation<
    Leading.MenuComponentsType, Trailing.MenuComponentsType
  > {
    return MenuComponentsConcatenation(leading.menuComponents(), trailing.menuComponents())
  }
}

@available(macOS 11, *)
extension CommandsConcatenation: Commands
where Leading: Commands, Trailing: Commands {

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    @SwiftUI.CommandsBuilder public func swiftUICommands() -> some SwiftUI.Commands {
      leading.swiftUICommands()
      trailing.swiftUICommands()
    }
  #endif
}
