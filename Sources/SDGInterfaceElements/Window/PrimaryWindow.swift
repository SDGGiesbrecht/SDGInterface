/*
 PrimaryWindow.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A window that can serve as the primary window.
public class PrimaryWindow<L>: Window<L> where L : Localization {

    #if canImport(AppKit)
    /// Creates a window.
    ///
    /// - Parameters:
    ///     - title: The title.
    public init(title: Shared<UserFacing<StrictString, L>>) {
        super.init(title: title, size: (Screen.main ?? Screen()).frame.size)
        collectionBehavior = .fullScreenPrimary
    }
    #endif
}
