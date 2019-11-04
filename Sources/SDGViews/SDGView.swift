/*
 SDGView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS) // Wrapper not needed; uses SwiftUI natively.
#if canImport(SwiftUI) && !os(iOS) // #workaround(xcodebuild -version 11.2, @availability checks are broken for iOS.) @exempt(from: unicode)
import SwiftUI

#if canImport(AppKit)
@available(macOS 10.15, *)
extension SDGView : NSViewRepresentable {}
#endif
#if canImport(UIKit)
@available(tvOS 13, *)
extension SDGView : UIViewRepresentable {}
#endif

@available(macOS 10.15, tvOS 13, *)
internal struct SDGView {

    // MARK: - Initialization

    internal init(_ view: SDGViews.View) {
        // @exempt(from: tests) #workaround(workspace version 0.25.0, macOS 10.15 is unavailable in CI.)
        self.sdgView = view
    }

    // MARK: - Properties

    private let sdgView: SDGViews.View

    #if canImport(AppKit)
    // MARK: - NSViewRepresentable

    func makeNSView(context: NSViewRepresentableContext<SDGView>) -> NSView {
        // @exempt(from: tests) #workaround(workspace version 0.25.0, macOS 10.15 is unavailable in CI.)
        return sdgView.native
    }

    func updateNSView(_ nsView: NSView, context: NSViewRepresentableContext<SDGView>) {}
    #endif

    #if canImport(UIKit)
    // MARK: - UIViewRepresentable

    func makeUIView(context: UIViewRepresentableContext<SDGView>) -> UIView { // @exempt(from: tests) Not reachable from tests.
        return sdgView.native
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SDGView>) { // @exempt(from: tests) Not reachable from tests.
    }
    #endif
}
#endif
#endif
