/*
 PopOver.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !os(tvOS) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGControlFlow

  @available(macOS 10.15, iOS 13, watchOS 6, *)
  @available(watchOS, unavailable)
  extension PopOver where Anchor: SDGInterface.View, Content: SDGInterface.View {

    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      internal let anchor: Anchor.SwiftUIView
      @ObservedObject internal var isPresented: Shared<Bool>
      internal let attachmentAnchor: PopoverAttachmentAnchor
      internal let arrowEdge: SwiftUI.Edge
      internal let content: () -> Content.SwiftUIView

      // MARK: - View

      internal var body: some SwiftUI.View {  // @exempt(from: tests) Unreachable on watchOS.
        #if DEBUG
          _ = content()  // Eager execution to simplify testing.
        #endif
        return anchor.popover(
          isPresented: $isPresented.value,
          attachmentAnchor: attachmentAnchor,
          arrowEdge: arrowEdge,
          content: content
        )
      }
    }
  }
#endif
