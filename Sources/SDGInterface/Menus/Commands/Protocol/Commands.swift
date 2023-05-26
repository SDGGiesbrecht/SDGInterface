/*
 Commands.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

/// A list of commands.
@available(macOS 11, iOS 14, *)
public protocol Commands: LegacyCommands {

  #if canImport(SwiftUI) && !os(tvOS) && !os(watchOS)
    /// The type of the SwiftUI commands.
    associatedtype SwiftUICommands: SwiftUI.Commands

    /// Constructs a SwiftUI representation of the commands.
    func swiftUICommands() -> SwiftUICommands
  #endif
}
