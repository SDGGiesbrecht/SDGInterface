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

@available(macOS 11, *)
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
