/*
 CocoaViewRepresentableWrapper.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(SwiftUI) && !(os(iOS) && arch(arm)))
  #if (canImport(AppKit) || (canImport(UIKit) && !os(watchOS)))
    import SwiftUI

    #if canImport(AppKit)
      @available(macOS 10.15, *)
      extension CocoaViewRepresentableWrapper: NSViewRepresentable {}
    #else
      @available(iOS 13, tvOS 13, *)
      extension CocoaViewRepresentableWrapper: UIViewRepresentable {}
    #endif

    @available(macOS 10.15, tvOS 13, iOS 13, *)
    internal struct CocoaViewRepresentableWrapper {

      // MARK: - Initialization

      internal init(_ view: CocoaView) {
        self.cocoaView = view
      }

      // MARK: - Properties

      private let cocoaView: CocoaView

      #if canImport(AppKit)
        // MARK: - NSViewRepresentable

        internal func makeNSView(
          context: NSViewRepresentableContext<CocoaViewRepresentableWrapper>
        ) -> NSView {
          return cocoaView.native
        }

        internal func updateNSView(
          _ nsView: NSView,
          context: NSViewRepresentableContext<CocoaViewRepresentableWrapper>
        ) {}
      #else
        // MARK: - UIViewRepresentable

        private func makeUIView(
          context: UIViewRepresentableContext<CocoaViewRepresentableWrapper>
        ) -> UIView {  // @exempt(from: tests) Not reachable from tests.
          return cocoaView.native
        }

        private func updateUIView(
          _ uiView: UIView,
          context: UIViewRepresentableContext<CocoaViewRepresentableWrapper>
        ) {  // @exempt(from: tests) Not reachable from tests.
        }
      #endif
    }
  #endif
#endif
