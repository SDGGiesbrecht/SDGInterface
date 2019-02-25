/*
 AuxiliaryWindow.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An window which plays a supporting role to another window.
public class AuxiliaryWindow: Window {

    // MARK: - Initialization

    private static let defaultSize = NSSize(width: 480, height: 270)

    #warning("Binding?")
    /// Creates an auxiliary window.
    public init(title: StrictString) {
        super.init(title: title, size: AuxiliaryWindow.defaultSize)
        configure()
    }

    private func configure() {
        collectionBehavior = NSWindow.CollectionBehavior.fullScreenAuxiliary
    }
}
