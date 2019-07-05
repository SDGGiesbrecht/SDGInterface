/*
 SpecificView.swift

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

/// A specific type of view.
public protocol SpecificView : View {

    #if canImport(AppKit)
    /// The specific native view type.
    associatedtype SpecificNativeView : NSView
    #elseif canImport(UIKit)
    /// The specific native view type.
    associatedtype SpecificNativeView : UIView
    #endif

    #if canImport(AppKit)
    /// The specific native view.
    var specificNative: SpecificNativeView { get }
    #elseif canImport(UIKit)
    /// The specific native view.
    var specificNative: SpecificNativeView { get }
    #endif
}

extension SpecificView {

    // MARK: - View

    #if canImport(AppKit)
    public var native: NSView {
        return specificNative
    }
    #elseif canImport(UIKit)
    public var native: UIView {
        return specificNative
    }
    #endif
}
#endif
