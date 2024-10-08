/*
 Handoff.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// An activity handoff.
public struct Handoff {

  // MARK: - Initialization

  /// Creates empty details.
  public init() {}

  // MARK: - Properties

  #if !PLATFORM_LACKS_FOUNDATION_NS_USER_ACTIVITY
    /// The activity.
    public var activity: NSUserActivity?
  #endif
}
