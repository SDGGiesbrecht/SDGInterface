/*
 ViewMargin.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
import CoreGraphics

extension View {

    /// A layout margin size.
    public enum Margin : Equatable {

        /// The default system margin.
        case system

        /// No margin.
        case none

        /// A particular margin size.
        case specific(CGFloat)

        /// An unspecified margin.
        case unspecified

        // MARK: - Properties

        internal var string: String? {
            switch self {
            case .system:
                return "\u{2D}"
            case .none:
                return ""
            case .specific(let size):
                return "\u{2D}\(size)\u{2D}"
            case .unspecified:
                return nil
            }
        }
    }
}

#endif
