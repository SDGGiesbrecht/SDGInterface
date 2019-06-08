/*
 SystemMediatorHandoffDetails.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Details about an activity handoff.
public struct SystemMediatorHandoffDetails {

    #if canImport(AppKit)
    /// The restoration handler.
    public let restorationHandler: ([NSUserActivityRestoring]) -> Void
    #endif

    #if canImport(UIKit)
    /// The restoration handler.
    public let restorationHandler: ([UIUserActivityRestoring]) -> Void
    #endif
}
