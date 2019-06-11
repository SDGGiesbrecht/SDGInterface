/*
 HandoffDetails.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Details about an activity handoff.
public struct HandoffDetails {

    // MARK: - Initialization

    /// Creates empty details.
    public init() {}

    // MARK: - Properties

    #if canImport(AppKit)
    /// Some systems provide a restoration handler.
    ///
    /// - Parameters:
    ///     - restorableObjects: Interface objects to restore state to.
    public var restorationHandler: ((_ restorableObjects: [NSUserActivityRestoring]) -> Void)?
    #endif

    #if canImport(UIKit) && !os(watchOS)
    /// Some systems provide a restoration handler.
    ///
    /// - Parameters:
    ///     - restorableObjects: Interface objects to restore state to.
    public var restorationHandler: ((_ restorableObjects: [UIUserActivityRestoring]) -> Void)?
    #endif
}
