/*
 LegacyView.swift

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

  import SDGInterfaceBasics
  import SDGViews

  @available(watchOS 6, *)
  extension LegacyView {

    /// A shimmed version of `SwiftUI.View.popover(isPresented:attachmentAnchor:arrowEdge:content:)` with no availability constraints.
    ///
    /// - Parameters:
    ///   - isPresented: Whether the pop‐over is presented.
    ///   - attachmentAnchor: The anchor where the pop‐over is attached.
    ///   - arrowEdge: The edge where the pop‐over’s arrow is located.
    ///   - content: The content of the pop‐over.
    @available(watchOS, unavailable)
    public func popOver<Content>(
      isPresented: Shared<Bool>,
      attachmentAnchor: AttachmentAnchor = .rectangle(.bounds),
      arrowEdge: SDGInterfaceBasics.Edge = .top,
      content: @escaping () -> Content
    ) -> PopOver<Self, Content> {
      return PopOver(
        anchor: self,
        isPresented: isPresented,
        attachmentAnchor: attachmentAnchor,
        arrowEdge: arrowEdge,
        content: content
      )
    }

    #if !os(tvOS) && !os(watchOS)
      internal func useSwiftUIOrFallback(to fallback: () -> CocoaView) -> CocoaView {
        return useSwiftUIOrFallback(to: fallback, useFallbackRegardless: legacyMode)
      }
    #endif

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      @available(macOS 10.15, tvOS 13, iOS 13, *)
      internal func adjustForLegacyMode() -> SwiftUI.AnyView {
        return resolved(usingCocoa: legacyMode)
      }
    #endif
  }
#endif
