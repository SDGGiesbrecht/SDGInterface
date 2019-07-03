/*
 EmptyView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

/// An empty view.
public final class EmptyView : View {

    // MARK: - Initialization

    /// Creates an empty view.
    public init() {}

    // MARK: - Properties

    #if canImport(AppKit)
    public let native: NSView = NSView()
    #elseif canImport(UIKit)
    public let native: UIView = UIView()
    #endif
}
