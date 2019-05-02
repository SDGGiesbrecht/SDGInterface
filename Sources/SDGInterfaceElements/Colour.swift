/*
 Colour.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
// @documentation(Colour)
/// An alias for `NSColor` or `UIColor`.
public typealias Colour = NSColor
#else
// #documentation(Colour)
/// An alias for `NSColor` or `UIColor`.
public typealias Colour = UIColor
#endif

extension Colour {

    #if !canImport(AppKit)
    public init(calibratedRed red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    #endif
}
