/*
 Window.SwiftUIImplementation.WindowFinder.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(macOS 11, tvOS 14, iOS 14, *)
  extension Window.SwiftUIImplementation {

    internal struct WindowFinder {
      internal var onFound: (CocoaWindow?) -> Void
    }
  }

  #if canImport(AppKit)
    @available(macOS 11, *)
    extension Window.SwiftUIImplementation.WindowFinder: NSViewRepresentable {

      internal func makeNSView(context: Context) -> some NSView {
        let view = NSView()
        DispatchQueue.main.async {
          onFound(view.window.map({ CocoaWindow($0) }))
        }
        return view
      }

      internal func updateNSView(_ nsView: NSViewType, context: Context) {}
    }
  #endif

  #if canImport(UIKit)
    @available(tvOS 14, iOS 14, *)
    extension Window.SwiftUIImplementation.WindowFinder: UIViewRepresentable {

      internal func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
          onFound(view.window.map({ CocoaWindow($0) }))
        }
        return view
      }

      internal func updateUIView(_ uiView: UIViewType, context: Context) {}
    }
  #endif
#endif
