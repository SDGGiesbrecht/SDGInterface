/*
 SwiftUIView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (((canImport(AppKit) || canImport(UIKit)) && !os(watchOS))) && (canImport(SwiftUI) && !(os(iOS) && arch(arm)))
import SwiftUI
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

/// A wrapped SwiftUI view.
@available(macOS 10.15, iOS 13, tvOS 13, *) // @exempt(from: unicode)
public final class SwiftUIView<V> : SpecificView where V : SwiftUI.View {

    // MARK: - Initialization

    /// Creates a wrapped SwiftUI view.
    ///
    /// - Parameters:
    ///     - view: The view.
    public init(_ view: V) {
        // @exempt(from: tests) #workaround(workspace version 0.25.0, macOS 10.15 is unavailable in CI.)
        nativeSwiftUIView = view
        #if canImport(AppKit)
        specificNative = NSHostingView(rootView: view)
        #elseif canImport(UIKit)
        let controller = UIHostingController(rootView: view)
        specificNative = controller.view
        #endif
    }

    // MARK: - SpecificView

    private let nativeSwiftUIView: V
    #if canImport(AppKit)
    public let specificNative: NSHostingView<V>
    #elseif canImport(UIKit)
    public let specificNative: UIView
    #endif

    // MARK: - View

    public var swiftUIView: AnyView {
        // @exempt(from: tests) #workaround(workspace version 0.25.0, macOS 10.15 is unavailable in CI.)
        return AnyView(nativeSwiftUIView)
    }
}
#endif
