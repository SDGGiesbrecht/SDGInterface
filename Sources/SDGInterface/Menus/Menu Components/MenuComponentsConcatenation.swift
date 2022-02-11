/*
 MenuComponentsConcatenation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

/// A concatenation of menu components.
public struct MenuComponentsConcatenation<Leading, Trailing>: LegacyMenuComponents
where Leading: LegacyMenuComponents, Trailing: LegacyMenuComponents {

  // MARK: - Initialization

  internal init(_ leading: Leading, _ trailing: Trailing) {
    self.leading = leading
    self.trailing = trailing
  }

  // MARK: - Properties

  private let leading: Leading
  private let trailing: Trailing

  // MARK: - LegacyMenuComponents

  #if canImport(AppKit)
    public func cocoa() -> [NSMenuItem] {
      return leading.cocoa().appending(contentsOf: trailing.cocoa())
    }
  #endif

  #if canImport(UIKit) && !os(tvOS) && !os(watchOS)
    public func cocoa() -> [UIMenuItem] {
      return leading.cocoa().appending(contentsOf: trailing.cocoa())
    }
  #endif
}

@available(macOS 11, tvOS 13, iOS 14, watchOS 6, *)
extension MenuComponentsConcatenation: MenuComponents
where Leading: MenuComponents, Trailing: MenuComponents {

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    public func swiftUI() -> some SwiftUI.View {
      Group {
        leading.swiftUI()
        trailing.swiftUI()
      }
    }
  #endif
}
