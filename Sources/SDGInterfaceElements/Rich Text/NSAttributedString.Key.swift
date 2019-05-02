/*
 NSAttributedString.Key.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension NSAttributedString.Key {
    #if !canImport(AppKit)
    /// Fakes AppKit’s `superscript` on other platforms.
    ///
    /// It is ignored by the operating system, but it allows tracking the superscript nesting level.
    internal static let superscript = NSAttributedString.Key(rawValue: "SDGNSSuperScript")
    #endif
}
