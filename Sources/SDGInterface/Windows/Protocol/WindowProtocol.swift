/*
 WindowProtocol.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

/// A window.
@available(macOS 11, *)
public protocol WindowProtocol: LegacyWindow {

  /// The type of the SwiftUI scene.
  associatedtype SwiftUIScene: SwiftUI.Scene

  /// The SwiftUI scene.
  func swiftUI() -> SwiftUIScene
}
