/*
 AuxiliaryWindow.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit

import SDGControlFlow
import SDGText
import SDGLocalization

/// An window which plays a supporting role to another window.
open class AuxiliaryWindow<L> : Window<L> where L : Localization {

    // MARK: - Initialization

    internal static var defaultSize: NSSize {
        return NSSize(width: 480, height: 270)
    }

    /// Creates an auxiliary window.
    public init(title: Shared<UserFacing<StrictString, L>>) {
        super.init(title: title, size: AuxiliaryWindow.defaultSize)
        finishInitialization()
    }

    private func finishInitialization() {
        collectionBehavior = NSWindow.CollectionBehavior.fullScreenAuxiliary
    }
}
#endif
