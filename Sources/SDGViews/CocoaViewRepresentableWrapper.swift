/*
 CocoaViewRepresentableWrapper.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)  // Wrapper not needed; uses SwiftUI natively.
  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    import SwiftUI

    #if canImport(AppKit)
      @available(macOS 10.15, *)
      extension CocoaViewRepresentableWrapper: NSViewRepresentable {}
    #endif
    #if canImport(UIKit)
      @available(iOS 13, tvOS 13, *)
      extension CocoaViewRepresentableWrapper: UIViewRepresentable {}
    #endif

    @available(macOS 10.15, tvOS 13, iOS 13, *)
    internal struct CocoaViewRepresentableWrapper {

      // MARK: - Initialization

      #if canImport(AppKit)
        internal init(_ view: NSView) {
          self.cocoaView = view
        }
      #elseif canImport(UIKit)
        internal init(_ view: UIView) {
          self.cocoaView = view
        }
      #endif

      // MARK: - Properties

      #if canImport(AppKit)
        private let cocoaView: NSView
      #elseif canImport(UIKit)
        private let cocoaView: UIView
      #endif

      #if canImport(AppKit)
        // MARK: - NSViewRepresentable

        func makeNSView(
          context: NSViewRepresentableContext<CocoaViewRepresentableWrapper>
        ) -> NSView {
          return cocoaView
        }

        func updateNSView(
          _ nsView: NSView,
          context: NSViewRepresentableContext<CocoaViewRepresentableWrapper>
        ) {}
      #endif

      #if canImport(UIKit)
        // MARK: - UIViewRepresentable

        func makeUIView(
          context: UIViewRepresentableContext<CocoaViewRepresentableWrapper>
        ) -> UIView {  // @exempt(from: tests) Not reachable from tests.
          return cocoaView
        }

        func updateUIView(
          _ uiView: UIView,
          context: UIViewRepresentableContext<CocoaViewRepresentableWrapper>
        ) {  // @exempt(from: tests) Not reachable from tests.
        }
      #endif
    }
  #endif
#endif
