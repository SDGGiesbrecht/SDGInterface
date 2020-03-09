/*
 CocoaView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

#if canImport(AppKit)
  internal typealias NativeCocoaView = NSView
#elseif canImport(UIKit) && !os(watchOS)
  internal typealias NativeCocoaView = UIView
#endif
