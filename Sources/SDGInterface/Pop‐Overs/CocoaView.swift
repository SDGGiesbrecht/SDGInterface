/*
 CocoaView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGInterface

  extension CocoaView {

    /// Displays a pop‐over related to this view.
    ///
    /// - Parameters:
    ///   - content: The content of the pop‐over.
    ///   - attachmentAnchor: The portion of the view the pop‐over is related to.
    ///   - arrowEdge: The edge of the anchor that the pop‐over should appear from.
    public func displayPopOver<Content>(
      _ content: Content,
      attachmentAnchor: AttachmentAnchor = .rectangle(.bounds),
      arrowEdge: SDGInterface.Edge = .top
    ) where Content: LegacyView {

      let popOverView = CocoaView.PopOverView(content)

      let attachmentRectangle: CGRect
      switch attachmentAnchor {
      case .point(let point):
        attachmentRectangle = CGRect(origin: CGPoint(point), size: CGSize(width: 0, height: 0))
      case .rectangle(let rectangle):
        switch rectangle {
        case .bounds:
          attachmentRectangle = self.native.frame
        case .rectangle(let rectangle):
          attachmentRectangle = CGRect(rectangle)
        }
      }

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
          popOver?.delegate = CocoaView.PopOverDelegate.delegate
        #endif
        popOver?.sourceView = self.native
        popOver?.sourceRect = attachmentRectangle
        popOver?.permittedArrowDirections = UIPopoverArrowDirection(arrowEdge)

        self.native.controller?.present(controller, animated: true, completion: nil)
      #else
        let controller = NSViewController()
        controller.view = popOverView

        let popOver = NSPopover()
        popOver.contentViewController = controller
        popOver.behavior = .transient
        popOver.show(
          relativeTo: attachmentRectangle,
          of: self.native,
          preferredEdge: NSRectEdge(arrowEdge)
        )
      #endif
    }
  }
#endif
