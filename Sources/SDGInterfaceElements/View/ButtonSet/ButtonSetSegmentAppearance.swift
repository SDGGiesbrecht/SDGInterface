/*
 ButtonSetSegmentAppearance.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || canImport(UIKit)
import SDGText
import SDGImageDisplay

/// A segment label.
public enum ButtonSetSegmentLabel {

    /// A text label.
    case text(StrictString)

    /// An image label.
    case image(Image)
}
#endif
