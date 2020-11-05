/*
 Handoff.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3, Web doesn’t have Foundation yet.)
#if !os(WASI)
  import Foundation
#endif

/// An activity handoff.
public struct Handoff {

  // MARK: - Initialization

  /// Creates empty details.
  public init() {}

  // MARK: - Properties

  #if !(os(Windows) || os(Linux) || os(Android))
    // #workaround(Swift 5.3, Web doesn’t have Foundation yet.)
    #if !os(WASI)
      /// The activity.
      public var activity: NSUserActivity?
    #endif
  #endif
}
