/*
 AnySwiftUIView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if ((canImport(AppKit) || canImport(UIKit)) && !os(watchOS)) && canImport(SwiftUI)
import SwiftUI
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif


/// A wrapped SwiftUI view.
@available(macOS 10.15, *)
public final class AnySwiftUIView<V> : SpecificView where V : SwiftUI.View {

    // MARK: - Initialization

    /// Creates a wrapped SwiftUI view.
    public init(_ view: V) {
        #if canImport(AppKit)
        specificNative = NSHostingView(rootView: view)
        #elseif canImport(UIKit)
        specificNative = UIHostingView(rootView: view)
        #endif
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
    public let specificNative: NSHostingView<V>
    #elseif canImport(UIKit)
    public let specificNative: UIHostingView<V>
    #endif
}
#endif
