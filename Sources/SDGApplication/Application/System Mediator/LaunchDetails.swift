/*
 LaunchDetails.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit)
  import UIKit
#endif

/// Details about the launch.
public struct LaunchDetails {

  // MARK: - Initialization

  /// Creates empty details.
  public init() {}

  // MARK: - Properties

  /// Some systems provide an accompanying notification.
  public var notification: SystemNotification?

  #if canImport(UIKit) && !os(watchOS)
    /// Some systems specify options.
    public var options: [UIApplication.LaunchOptionsKey: Any]?
  #endif
}
