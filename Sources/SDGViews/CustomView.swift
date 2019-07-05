/*
 CustomView.swift

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

public class AnyNativeView: View {

    // MARK: - Initialization

    #if canImport(AppKit)
    // @documentation(AnyNativeView.init(_:))
    /// Wraps a native view.
    ///
    /// - Parameters:
    ///     - native: The native view.
    public init(_ native: NSView) {
        self.native = native
    }
    #elseif canImport(UIKit)
    // #documentation(AnyNativeView.init(_:))
    /// Wraps a native view.
    ///
    /// - Parameters:
    ///     - native: The native view.
    public init(_ native: UIView) {
        self.native = native
    }
    #endif

    // MARK: - View

    #if canImport(AppKit)
    public var native: NSView
    #elseif canImport(UIKit)
    public var native: UIView
    #endif
}
