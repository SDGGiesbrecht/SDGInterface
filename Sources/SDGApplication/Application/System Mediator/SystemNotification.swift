/*
 SystemNotification.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A system notification.
public struct SystemNotification {

    // MARK: - Initialization

    /// Creates an empty notification.
    public init() {}

    // MARK: - Properties

    #if !os(Linux)
    /// The native notification.
    public var native: Notification?
    #endif
}
