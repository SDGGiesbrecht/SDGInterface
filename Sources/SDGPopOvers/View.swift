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
#elseif canImport(UIKit)
import UIKit
#endif

import SDGInterfaceBasics
import SDGViews

extension View {

    // MARK: - Pop‐overs

    /// Displays a pop‐over view.
    ///
    /// - Parameters:
    ///     - view: The view to display as a pop‐over.
    ///     - sourceRectangle: A rectangle within `self` that should be considered the origin of the pop‐over.
    public func displayPopOver(_ view: View, sourceRectangle: Rectangle? = nil, preferredSize: Size? = nil) {
        let popOverView = CocoaPopOverView(view: view)

        #if canImport(UIKit)
        let controller = UIViewController()
        #if os(tvOS)
        controller.modalPresentationStyle = .overCurrentContext
        #else
        controller.modalPresentationStyle = .popover
        #endif
        controller.view = popOverView

        let popOver = controller.popoverPresentationController
        #if !os(tvOS)
        popOver?.delegate = UIPopoverPresentationControllerDelegate.delegate
        #endif
        popOver?.sourceView = native
        popOver?.sourceRect = sourceRectangle?.native ?? native.frame // @exempt(from: tests) tvOS quirk.
        popOver?.permittedArrowDirections = .any

        AnyNativeView(native).controller?.present(controller, animated: true, completion: nil)
        #else
        let controller = NSViewController()
        if let specifiedSize = preferredSize {
            popOverView.frame.size = specifiedSize.native
        }
        controller.view = popOverView

        let popOver = NSPopover()
        popOver.contentViewController = controller
        popOver.behavior = .transient
        popOver.show(relativeTo: sourceRectangle?.native ?? native.frame, of: native, preferredEdge: .maxX)
        #endif
    }
}
#endif
