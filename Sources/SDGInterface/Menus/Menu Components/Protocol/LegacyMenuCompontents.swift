/*
 LegacyMenuCompontents.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

/// The subset of the `MenuComponents` protocol that can be conformed to even on platform versions preceding SwiftUI’s availability.
public protocol LegacyMenuComponents {

  #if canImport(AppKit)
    /// Constructs a Cocoa representation of the view.
    func cocoa() -> [NSMenuItem]
  #endif

  #if canImport(UIKit) && !os(tvOS) && !os(watchOS)
    /// Constructs a Cocoa representation of the view.
    func cocoa() -> [UIMenuItem]
  #endif
}
