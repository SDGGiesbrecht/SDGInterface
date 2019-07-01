/*
 HandoffDetails.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

/// Details about an activity handoff.
public struct HandoffDetails {

    // MARK: - Initialization

    /// Creates empty details.
    public init() {}

    // MARK: - Properties

    #if canImport(AppKit) || canImport(UIKit)
    /// The native activity.
    public var handoffDetails: NSUserActivity?
    #endif
}
