/*
 RemoteNotificationDetails.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Details about a remote notification.
public struct RemoteNotificationDetails {

  // MARK: - Initialization

  /// Creates empty details.
  public init() {}

  // MARK: - Properties

  #if canImport(AppKit)
    /// Some systems provide user information.
    public var userInformation: [String: Any] = [:]
  #endif

  #if canImport(UIKit)
    /// Some systems provide user information.
    public var userInformation: [AnyHashable: Any] = [:]
  #endif
}
