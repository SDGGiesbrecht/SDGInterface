/*
 PopOver.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGControlFlow

  import SDGInterfaceBasics
  import SDGViews

  extension PopOver {

    internal final class CocoaImplementation: CocoaView.NativeType, SharedValueObserver {

      // MARK: - Initialization

      internal init(
        anchor: Anchor,
        isPresented: Shared<Bool>,
        attachmentAnchor: AttachmentAnchor,
        arrowEdge: SDGInterfaceBasics.Edge,
        content: @escaping () -> Content
      ) {
        self.anchor = anchor.cocoa()
        defer { CocoaView(self).fill(with: self.anchor, margin: 0) }

        self.isPresented = isPresented
        self.attachmentAnchor = attachmentAnchor
        self.arrowEdge = arrowEdge
        self.content = content

        super.init(frame: .zero)
      }

      internal required init?(coder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let anchor: CocoaView
      private let isPresented: Shared<Bool>
      private let attachmentAnchor: AttachmentAnchor
      private let arrowEdge: SDGInterfaceBasics.Edge
      private let content: () -> Content

      // MARK: - Pop Over

      private func showPopOver() {
        let popOverView = CocoaPopOverView(view: content())

        let attachmentRectangle: CGRect
        switch attachmentAnchor {
        case .point(let point):
          attachmentRectangle = CGRect(origin: CGPoint(point), size: CGSize(width: 0, height: 0))
        case .rectangle(let rectangle):
          switch rectangle {
          case .bounds:
            attachmentRectangle = anchor.native.frame
          case .rectangle(let rectangle):
            attachmentRectangle = CGRect(rectangle)
          }
        }

        #if canImport(UIKit)
          #warning("Audit.")
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
          popOver?.sourceView = cocoa().native
          popOver?.sourceRect =
            sourceRectangle.map({ CGRect($0) })  // @exempt(from: tests) tvOS quirk.
            ?? cocoa().native.frame  // @exempt(from: tests)
          popOver?.permittedArrowDirections = .any

          cocoa().native.controller?.present(controller, animated: true, completion: nil)
        #else
          let controller = NSViewController()
          controller.view = popOverView

          let popOver = NSPopover()
          popOver.contentViewController = controller
          popOver.behavior = .transient
          popOver.show(
            relativeTo: attachmentRectangle,
            of: anchor.native,
            preferredEdge: NSRectEdge(arrowEdge)
          )
        #endif
      }

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        #warning("Not implemented yet.")
        fatalError()
      }
    }
  }
#endif
