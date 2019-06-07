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

    /// Called by some systems before the application launches.
    ///
    /// - Parameters:
    ///     - details: Details provided by the system.
    ///
    /// - Returns: `false` if the application cannot continue. Otherwise `true`.
    func prepareToLaunch(_ details: LaunchDetails) -> Bool

    /// Called by some systems as the application finishes launching.
    ///
    /// - Parameters:
    ///     - details: Details provided by the system.
    ///
    /// - Returns: `false` if the application cannot continue. Otherwise `true`.
    func finishLaunching(_ details: LaunchDetails) -> Bool

    /// Called by some systems before the application acquires the system focus.
    ///
    /// - Parameters:
    ///     - details: Details provided by the system.
    func prepareToAcquireFocus(_ details: FocusChangeDetails)

    /// Called by some systems as the application finishes acquiring the system focus.
    ///
    /// - Parameters:
    ///     - details: Details provided by the system.
    func finishAcquiringFocus(_ details: FocusChangeDetails)

    /// Called by some systems before the application resigns the system focus.
    ///
    /// - Parameters:
    ///     - details: Details provided by the system.
    func prepareToResignFocus(_ details: FocusChangeDetails)

    /// Called by some systems as the application finishes resigning the system focus.
    ///
    /// - Parameters:
    ///     - details: Details provided by the system.
    func finishResigningFocus(_ details: FocusChangeDetails)

    /// Called by some systems to request that the application terminate.
    ///
    /// - Parameters:
    ///     - lastWindowClosed: `true` if the termination request was triggered by the last window closing.
    func terminate() -> TerminationResponse

    /// Some systems will terminate the application automatically when the last window closes. Returning `false` requests that the application remain running.
    var remainsRunningWithNoWindows: Bool { get }
}

extension SystemMediator {

    public func prepareToLaunch(_ details: LaunchDetails) -> Bool {
        return true
    }

    public func prepareToAcquireFocus(_ details: FocusChangeDetails) {}
    public func finishAcquiringFocus(_ details: FocusChangeDetails) {}
    public func prepareToResignFocus(_ details: FocusChangeDetails) {}
    public func finishResigningFocus(_ details: FocusChangeDetails) {}

    public func terminate() -> TerminationResponse {
        return .now
    }

    public var remainsRunningWithNoWindows: Bool {
        return false
    }
}
