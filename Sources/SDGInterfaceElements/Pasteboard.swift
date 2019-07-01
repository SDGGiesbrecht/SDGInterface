/*
 Pasteboard.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS) && !os(tvOS)

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
// @documentation(Pasteboard)
/// An alias for `NSPasteboard` or `UIPasteboard`.
public typealias Pasteboard = NSPasteboard
#else
// #documentation(Pasteboard)
/// An alias for `NSPasteboard` or `UIPasteboard`.
public typealias Pasteboard = UIPasteboard
#endif

#endif
