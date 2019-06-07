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
    ///
    /// - Parameters:
    ///     - details: Details provided by the system.
    ///
    /// - Returns: `false` if the application cannot continue. Otherwise `true`.
    func prepareToLaunch(_ details: LaunchDetails) -> Bool

    /// Called as application finishes launching.
    ///
    /// - Parameters:
    ///     - details: Details provided by the system.
    ///
    /// - Returns: `false` if the application cannot continue. Otherwise `true`.
    func finishLaunching(_ details: LaunchDetails) -> Bool

    /// Called before the application acquires the system focus.
    ///
    /// - Parameters:
    ///     - details: Details provided by the system.
    func prepareToAcquireFocus(_ details: FocusChangeDetails)

    /// Called as the application finishes acquiring the system focus.
    ///
    /// - Parameters:
    ///     - details: Details provided by the system.
    func finishAcquiringFocus(_ details: FocusChangeDetails)

    /// Called before the application resigns the system focus.
    ///
    /// - Parameters:
    ///     - details: Details provided by the system.
    func prepareToResignFocus(_ details: FocusChangeDetails)

    /// Called as the application finishes resigning the system focus.
    ///
    /// - Parameters:
    ///     - details: Details provided by the system.
    func finishResigningFocus(_ details: FocusChangeDetails)
}

extension SystemMediator {

    public func prepareToLaunch(_ details: LaunchDetails) -> Bool {
        return true
    }
}
