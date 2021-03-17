/*
 MenuBarProtocol.swift

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

/// A menu bar.
@available(macOS 11, *)
public protocol MenuBarProtocol: LegacyMenuBar {

  #if canImport(SwiftUI) && !os(tvOS) && !(os(iOS) && arch(arm))
    /// The type of the SwiftUI view.
    associatedtype SwiftUICommands: SwiftUI.Commands

    /// Constructs a SwiftUI representation of the menu bar modifications.
    func swiftUI() -> SwiftUICommands
  #endif
}
