/*
 AnyButton.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import SDGViews

/// A button with no particular localization.
public protocol AnyButton : View {
    #if canImport(AppKit)
    // #documentation(SpecificView.specificNative)
    /// The specific native view.
    var specificNative: NSButton { get }
    #elseif canImport(UIKit)
    // #documentation(SpecificView.specificNative)
    /// The specific native view.
    var specificNative: UILabel { get }
    #endif
    func _refreshBindings()
}

extension AnyButton {

    internal func refreshBindings() {
        _refreshBindings()
    }
}
#endif
