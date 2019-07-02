/*
 Point.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)
import CoreGraphics
#endif

import SDGGeometry

public typealias Point = TwoDimensionalPoint<Double>

extension Point {

    // MARK: - Initialization

    #if canImport(CoreGraphics)
    /// Creates a size from a native size.
    public init(_ native: CGPoint) {
        self.init(Double(native.x), Double(native.y))
    }
    #endif

    // MARK: - Properties

    #if canImport(CoreGraphics)
    /// The native size.
    public var native: CGPoint {
        return CGPoint(x: CGFloat(x), y: CGFloat(y))
    }
    #endif
}
