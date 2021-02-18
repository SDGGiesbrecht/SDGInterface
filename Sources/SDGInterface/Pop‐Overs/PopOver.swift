/*
 PopOver.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow

  import SDGInterface

  /// The result of `popOver(isPresented:attachmentAnchor:arrowEdge:content:)`.
  @available(watchOS 6, *)
  @available(watchOS, unavailable)
  public struct PopOver<Anchor, Content>: LegacyView where Anchor: LegacyView, Content: LegacyView {

    // MARK: - Initialization

    internal init(
      anchor: Anchor,
      isPresented: Shared<Bool>,
      attachmentAnchor: AttachmentAnchor,
      arrowEdge: SDGInterface.Edge,
      content: @escaping () -> Content
    ) {
      self.anchor = anchor
      self.isPresented = isPresented
      self.attachmentAnchor = attachmentAnchor
      self.arrowEdge = arrowEdge
      self.content = content
    }

    // MARK: - Properties

    private let anchor: Anchor
    private let isPresented: Shared<Bool>
    private let attachmentAnchor: AttachmentAnchor
    private let arrowEdge: SDGInterface.Edge
    private let content: () -> Content

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        let generator: () -> CocoaView = {
          return CocoaView(
            CocoaImplementation(
              anchor: self.anchor,
              isPresented: self.isPresented,
              attachmentAnchor: self.attachmentAnchor,
              arrowEdge: self.arrowEdge,
              content: self.content
            )
          )
        }
        #if os(tvOS)
          return generator()
        #else
          return useSwiftUIOrFallback(to: {
            return generator()
          })
        #endif
      }
    #endif
  }

  #if os(tvOS)
    @available(tvOS 13, *)
    extension PopOver: CocoaViewImplementation {}
  #else
    @available(macOS 10.15, iOS 13, watchOS 6, *)
    @available(watchOS, unavailable)
    extension PopOver: SDGInterface.View, ViewShims
    where Anchor: SDGInterface.View, Content: SDGInterface.View {

      // MARK: - View

      #if canImport(SwiftUI) && !os(tvOS) && !(os(iOS) && arch(arm))
        public func swiftUI() -> some SwiftUI.View {
          let content = self.content
          return SwiftUIImplementation(
            anchor: anchor.swiftUI(),
            isPresented: isPresented,
            attachmentAnchor: PopoverAttachmentAnchor(attachmentAnchor),
            arrowEdge: SwiftUI.Edge(arrowEdge),
            content: { content().swiftUI() }
          )
        }
      #endif
    }
  #endif
#endif
