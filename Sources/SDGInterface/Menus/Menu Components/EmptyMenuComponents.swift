/*
 EmptyMenuComponents.swift

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
#if canImport(AppKit)
  import AppKit
#endif

import SDGLocalization

/// Empty menu components.
public struct EmptyMenuComponents: LegacyMenuComponents {

  // MARK: - Initialization

  /// Creates empty menu components.
  public init() {}

  // MARK: - LegacyMenuComponents

  #if canImport(AppKit)
    public func cocoa() -> [NSMenuItem] {
      return []
    }
  #endif

  #if canImport(UIKit) && !os(tvOS) && !os(watchOS)
    public func cocoa() -> [UIMenuItem] {
      return []
    }
  #endif
}

@available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
extension EmptyMenuComponents: MenuComponents {

  // MARK: - MenuComponents

  #if canImport(SwiftUI)
    public func swiftUI() -> some SwiftUI.View {
      return SwiftUI.EmptyView()
    }
  #endif
}
