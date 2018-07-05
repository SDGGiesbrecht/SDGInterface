/*
 MenuItem.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
// MARK: - #if canImport(AppKit)
/// :nodoc:
public typealias MenuItem = NSMenuItem
#elseif canImport(UIKit)
// MARK: - #elseif canImport(UIKit)
/// :nodoc:
public typealias MenuItem = UIMenuItem
#endif
