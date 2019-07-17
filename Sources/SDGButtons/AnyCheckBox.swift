/*
 AnyCheckBox.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit

import SDGViews

/// A check box with no particular localization.
public protocol AnyCheckBox : View {
    // #documentation(SpecificView.specificNative)
    /// The specific native view.
    var specificNative: NSButton { get }

    func _refreshBindings()
}

extension AnyCheckBox {

    internal func refreshBindings() {
        _refreshBindings()
    }
}
#endif
