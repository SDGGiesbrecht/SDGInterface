/*
 Window.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@testable import SDGWindows

#if canImport(AppKit) || canImport(UIKit)
public func forEachWindow(_ closure: (AnyWindow) -> Void) {
    for (_, window) in allWindows {
        closure(window)
    }
}
#endif
