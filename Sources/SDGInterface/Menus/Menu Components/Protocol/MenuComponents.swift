/*
 MenuComponents.swift

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

/// A list of menu components.
@available(macOS 11, tvOS 13, iOS 14, watchOS 6, *)
public protocol MenuComponents: LegacyMenuComponents {

  #if canImport(SwiftUI)
    /// The type of the SwiftUI view.
    associatedtype SwiftUIView: SwiftUI.View
    /// Constructs a SwiftUI representation of the menu components.
    func swiftUI() -> SwiftUIView
  #endif
}
