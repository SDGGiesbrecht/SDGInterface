/*
 LaunchDetails.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Details about the launch.
public struct LaunchDetails {

    #if canImport(AppKit)
    /// The notification.
    public let notification: Notification
    #endif

    #if canImport(UIKit)
    /// The options.
    public let options: [UIApplication.LaunchOptionsKey: Any]?
    #endif
}
