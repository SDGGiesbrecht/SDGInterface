/*
 Rectangle.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A rectangle.
public struct Rectangle {

    public init(origin: Point = Point(0, 0), size: Size = Size()) {
        self.origin = origin
        self.size = size
    }

    // MARK: - Properties

    /// The origin.
    public var origin: Point

    /// The size.
    public var size: Size
}
