/*
 RowView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

/// A row of views.
public final class RowView : View {

    // MARK: - Initialization

    /// Creates an empty view.
    public init(views: [View]) {
        #if canImport(AppKit)
        native = NSView()
        #elseif canImport(UIKit)
        native = UIView()
        #endif
    }

    // MARK: - Properties

    #if canImport(AppKit)
    public let native: NSView = NSView()
    #elseif canImport(UIKit)
    public let native: UIView = UIView()
    #endif
}
#endif
