/*
 MenuProtocol.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit
#endif

/// A menu.
public protocol MenuProtocol {

  #if canImport(AppKit)
    /// Generates a Cocoa representation of the menu.
    func cocoaMenu() -> NSMenu
  #endif
}
