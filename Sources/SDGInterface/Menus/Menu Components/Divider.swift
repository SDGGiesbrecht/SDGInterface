/*
 Divider.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import SwiftUI
  import AppKit

  /// A divider.
  public struct Divider: LegacyMenuComponents {

    // MARK: - Initialization

    /// Creates a divider.
    public init() {}

    // MARK: - LegacyMenuComponents

    public func cocoa() -> [NSMenuItem] {
      return [NSMenuItem.separator()]
    }
  }

  @available(macOS 10.15, *)
  extension Divider: MenuComponents {

    // MARK: - MenuComponents

    public func swiftUI() -> some SwiftUI.View {
      return SwiftUI.Divider()
    }
  }
#endif
