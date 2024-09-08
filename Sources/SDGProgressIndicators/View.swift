/*
 View.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterface

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal typealias View = SDGInterface.View
#endif
