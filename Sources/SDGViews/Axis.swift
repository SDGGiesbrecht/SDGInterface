/*
 Axis.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A layout axis.
public enum Axis {

    // MARK: - Cases

    /// Horizontal.
    case horizontal
    /// Vertical.
    case vertical

    #if canImport(AppKit) || canImport(UIKit)
    // MARK: - Layout Representation

    internal var string: String {
        switch self {
        case .horizontal:
            return "H:"
        case .vertical:
            return "V:"
        }
    }
    #endif
}
