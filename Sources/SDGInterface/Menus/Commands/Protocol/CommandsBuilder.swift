/*
 CommandsBuilder.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

/// A builder which constructs lists of menu components.
@resultBuilder public enum CommandsBuilder {

  /// Builds empty commands.
  public static func buildBlock() -> EmptyCommands {
    return EmptyCommands()
  }

  /// Builds commands.
  ///
  /// - Parameters:
  ///   - components: The commands.
  public static func buildBlock<A>(
    _ components: A
  ) -> A
  where A: LegacyCommands {
    return components
  }

  /// Builds a concatenation of two commands.
  ///
  /// - Parameters:
  ///   - a: The first commands.
  ///   - b: The second commands.
  public static func buildBlock<A, B>(
    _ a: A,
    _ b: B
  ) -> CommandsConcatenation<A, B>
  where A: LegacyCommands, B: LegacyCommands {
    return CommandsConcatenation(a, b)
  }
}
