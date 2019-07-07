/*
 View.swift

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
#endif
#if canImport(UIKit)
import UIKit
#endif

import SDGLogic
import SDGMathematics
import SDGText
import SDGLocalization

import SDGViews

import SDGInterfaceLocalizations

#if canImport(AppKit)
// @documentation(View)
/// An alias for `NSView` or `UIView`.
public typealias NativeView = NSView
#elseif canImport(UIKit)
// #documentation(View)
/// An alias for `NSView` or `UIView`.
public typealias NativeView = UIView
#endif

extension NativeView : View {

    // MARK: - Responder Chain

    #if canImport(UIKit)
    /// The view controller associated with the view.
    public var controller: UIViewController? {
        var responder: UIResponder? = self
        while responder ≠ nil {
            responder = responder!.next
            if let cast = responder as? UIViewController {
                return cast
            }
        }
        return nil
    }
    #endif

    // MARK: - View

    public var native: NativeView {
        return self
    }
}

#endif
