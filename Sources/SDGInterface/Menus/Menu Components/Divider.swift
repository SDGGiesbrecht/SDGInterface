/*
 Divider.swift

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
#if canImport(AppKit)
  import AppKit
#endif

/// A divider.
public struct Divider: LegacyMenuComponents {

  // MARK: - Initialization

  /// Creates a divider.
  public init() {}

  // MARK: - LegacyMenuComponents

  #if canImport(AppKit)
    public func cocoa() -> [NSMenuItem] {
      return [NSMenuItem.separator()]
    }
  #endif

  #warning("Not implemented yet.")
  #if canImport(UIKit) && !os(tvOS) && !os(watchOS)
    public func cocoa() -> [UIMenuItem] {
      return []
    }
  #endif
}

@available(macOS 10.15, tvOS 13, iOS 13, *)
extension Divider: MenuComponents {

  // MARK: - MenuComponents

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    public func swiftUI() -> some SwiftUI.View {
      return SwiftUI.Divider()
    }
  #endif
}
