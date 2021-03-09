/*
 EmptyMenuComponents.swift

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

import SDGLocalization

public struct EmptyMenuComponents: LegacyMenuComponents {

  // MARK: - LegacyMenuComponents

  #if canImport(AppKit)
    public func cocoa() -> [NSMenuItem] {
      return []
    }
  #endif
}

@available(macOS 11, *)
extension EmptyMenuComponents: MenuComponents {

  // MARK: - MenuComponents

  #if canImport(SwiftUI)
    public func swiftUI() -> some SwiftUI.View {
      return SwiftUI.EmptyView()
    }
  #endif
}
