/*
 Screen.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

#if canImport(AppKit)
// @documentation(Screen)
/// An alias for `NSScreen` or `UIScreen`.
public typealias Screen = NSScreen
#elseif canImport(UIKit)
// #documentation(Screen)
/// An alias for `NSScreen` or `UIScreen`.
public typealias Screen = UIScreen
#endif

extension Screen {

    /// The main screen.
    static var mainScreen: Screen {
        #if canImport(AppKit)
        return main ?? Screen()
        #else
        return main
        #endif
    }
}

#endif
