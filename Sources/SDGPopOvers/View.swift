/*
 View.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
    ///     - preferredSize: A preferred size for the pop over. This will be used as the default size, but may be overridden by layout constraints.
    public func displayPopOver(
      _ view: View,
      sourceRectangle: Rectangle? = nil,
      preferredSize: Size? = nil
    ) {
      let popOverView = CocoaPopOverView(view: StabilizedView(view))
      let stabilizedSelf = StabilizedView(self)

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
        popOver?.sourceView = stabilizedSelf.cocoaView
        popOver?.sourceRect = sourceRectangle?.native
          ?? stabilizedSelf.cocoaView.frame  // @exempt(from: tests) tvOS quirk.
        popOver?.permittedArrowDirections = .any

        stabilizedSelf.cocoaView.controller?.present(controller, animated: true, completion: nil)
      #else
        let controller = NSViewController()
        if let specifiedSize = preferredSize {
          popOverView.frame.size = specifiedSize.native
        }
        controller.view = popOverView

        let popOver = NSPopover()
        popOver.contentViewController = controller
        popOver.behavior = .transient
        popOver.show(
          relativeTo: sourceRectangle?.native ?? stabilizedSelf.cocoaView.frame,
          of: stabilizedSelf.cocoaView,
          preferredEdge: .maxX
        )
      #endif
    }
  }
#endif
