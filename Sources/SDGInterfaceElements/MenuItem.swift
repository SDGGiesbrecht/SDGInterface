/*
 MenuItem.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS) && !os(tvOS)
// MARK: - #if !os(watchOS) && !os(tvOS)

#if canImport(AppKit)
// MARK: - #if canImport(AppKit)
// @documentation(MenuItem)
/// An alias for `NSMenuItem` or `UIMenuItem`.
public typealias MenuItem = NSMenuItem
#elseif canImport(UIKit)
// MARK: - #elseif canImport(UIKit)
// #documentation(MenuItem)
/// An alias for `NSMenuItem` or `UIMenuItem`.
public typealias MenuItem = UIMenuItem
#endif

#endif
