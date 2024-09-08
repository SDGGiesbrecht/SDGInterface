/*
 EmptyCommands.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

/// Empty commands.
public struct EmptyCommands: LegacyCommands {

  // MARK: - Initialization

  /// Creates empty commands.
  public init() {}

  // MARK: - LegacyCommands

  public func menuComponents() -> EmptyMenuComponents {
    return EmptyMenuComponents()
  }
}

@available(macOS 11, iOS 14, *)
extension EmptyCommands: Commands {

  // MARK: - MenuComponents

  #if canImport(SwiftUI) && !os(tvOS) && !os(watchOS)
    public func swiftUICommands() -> some SwiftUI.Commands {
      return SwiftUI.EmptyCommands()
    }
  #endif
}
