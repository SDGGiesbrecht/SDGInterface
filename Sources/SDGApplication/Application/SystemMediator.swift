/*
 SystemMediator.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An object which mediates between the application and system events.
public protocol SystemMediator: AnyObject {

    /// Called before the application launches.
    func applicationWillLaunch(_ details: SystemEventDetails)
    /// Called when the application finishes launching.
    func applicationDidLaunch(_ details: SystemEventDetails)
}

extension SystemMediator {
    public func applicationWillLaunch(_ details: SystemEventDetails) {}
}
