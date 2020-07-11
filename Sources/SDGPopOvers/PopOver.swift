/*
 PopOver.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGInterfaceBasics
  import SDGViews

  /// The result of `popOver(isPresented:attachmentAnchor:arrowEdge:content:)`.
  public struct PopOver<Anchor, Content>: LegacyView where Anchor: LegacyView, Content: LegacyView {

    // MARK: - Initialization

    internal init(
      anchor: Anchor,
      isPresented: Shared<Bool>,
      attachmentAnchor: AttachmentAnchor,
      arrowEdge: SDGInterfaceBasics.Edge,
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
    private let arrowEdge: SDGInterfaceBasics.Edge
    private let content: () -> Content

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        return useSwiftUIOrFallback(to: {
          #warning("Not implemented yet.")
          fatalError()
        })
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension PopOver: SDGViews.View, ViewShims where Anchor: SDGViews.View, Content: SDGViews.View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        #warning("Not implemented yet.")
        return EmptyView()
      }
    #endif
  }
#endif
