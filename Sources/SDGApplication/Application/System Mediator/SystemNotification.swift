/*
 SystemNotification.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
#if canImport(Foundation)
  import Foundation
#endif

/// A system notification.
public struct SystemNotification {

  // MARK: - Initialization

  /// Creates an empty notification.
  public init() {}

  // MARK: - Properties

  #if !os(Linux)
    // #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
    #if canImport(Foundation)
      /// The native notification.
      public var native: Notification?
    #endif
  #endif
}
