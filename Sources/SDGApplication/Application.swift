/*
 Application.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

#if canImport(AppKit)
// @documentation(SDGInterface.Application)
/// An alias for `NSApplication` or `UIApplication`.
public typealias Application = NSApplication
#elseif canImport(UIKit)
// #documentation(SDGInterface.Application)
/// An alias for `NSApplication` or `UIApplication`.
public typealias Application = UIApplication
#endif

#endif
