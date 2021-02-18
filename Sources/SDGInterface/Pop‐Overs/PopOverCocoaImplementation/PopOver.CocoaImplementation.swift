/*
 PopOver.CocoaImplementation.swift

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

  import SDGControlFlow

  import SDGInterface

  extension PopOver {

    internal final class CocoaImplementation: CocoaView.NativeType, SharedValueObserver {

      // MARK: - Initialization

      internal init(
        anchor: Anchor,
        isPresented: Shared<Bool>,
        attachmentAnchor: AttachmentAnchor,
        arrowEdge: SDGInterface.Edge,
        content: @escaping () -> Content
      ) {
        self.anchor = anchor.cocoa()
        defer { CocoaView(self).fill(with: self.anchor, margin: 0) }

        self.isPresented = isPresented
        defer { isPresented.register(observer: self) }
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
      private let arrowEdge: SDGInterface.Edge
      private let content: () -> Content

      // MARK: - Pop Over

      private func displayPopOver() {
        anchor.displayPopOver(
          content(),
          attachmentAnchor: attachmentAnchor,
          arrowEdge: arrowEdge
        )
      }

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        if isPresented.value {
          displayPopOver()
        }
      }
    }
  }
#endif
