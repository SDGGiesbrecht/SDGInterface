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
    ///     - notification: Some systems provide an accompanying notification.
    func prepareToAcquireFocus(_ notification: Notification?)

    /// Called by some systems as the application finishes acquiring the system focus.
    ///
    /// - Parameters:
    ///     - notification: Some systems provide an accompanying notification.
    func finishAcquiringFocus(_ notification: Notification?)

    /// Called by some systems before the application resigns the system focus.
    ///
    /// - Parameters:
    ///     - notification: Some systems provide an accompanying notification.
    func prepareToResignFocus(_ notification: Notification?)

    /// Called by some systems as the application finishes resigning the system focus.
    ///
    /// - Parameters:
    ///     - notification: Some systems provide an accompanying notification.
    func finishResigningFocus(_ notification: Notification?)

    /// Called by some systems to request that the application terminate.
    ///
    /// - Parameters:
    ///     - lastWindowClosed: `true` if the termination request was triggered by the last window closing.
    func terminate() -> TerminationResponse

    /// Some systems will terminate the application automatically when the last window closes. Returning `false` requests that the application remain running.
    var remainsRunningWithNoWindows: Bool { get }

    /// Called by some systems before the application terminates.
    ///
    /// - Parameters:
    ///     - notification: Some systems provide an accompanying notification.
    func prepareToTerminate(_ notification: Notification?)

    /// Called by some systems before the application is hidden.
    ///
    /// - Parameters:
    ///     - notification: Some systems provide an accompanying notification.
    func prepareToHide(_ notification: Notification?)

    /// Called by some systems as the application finishes being hidden.
    ///
    /// - Parameters:
    ///     - notification: Some systems provide an accompanying notification.
    func finishHiding(_ notification: Notification?)

    /// Called by some systems before the application is unhidden.
    ///
    /// - Parameters:
    ///     - notification: Some systems provide an accompanying notification.
    func prepareToUnhide(_ notification: Notification?)

    /// Called by some systems as the application finishes being unhidden.
    ///
    /// - Parameters:
    ///     - notification: Some systems provide an accompanying notification.
    func finishUnhiding(_ notification: Notification?)

    /// Called by some systems before the interface update cycle begins.
    ///
    /// - Parameters:
    ///     - notification: Some systems provide an accompanying notification.
    func prepareToUpdateInterface(_ notification: Notification?)

    /// Called by some systems as the interface update cycle finishes.
    ///
    /// - Parameters:
    ///     - notification: Some systems provide an accompanying notification.
    func finishUpdatingInterface(_ notification: Notification?)

    /// Called by some systems when a user tries to open the application while it is already running.
    ///
    /// - Parameters:
    ///     - hasVisibleWindows: Some systems report whether or not they perceive the application to have visible windows.
    ///
    /// - Returns: `true` if the reopen operation has been handled, `false` to request that the operating system handle it.
    func reopen(hasVisibleWindows: Bool?) -> Bool

    /// Used by some systems as the dock menu.
    var dockMenu: NSMenu? { get }

    /// Called by some systems before displaying an error to the user.
    func preprocessErrorForDisplay(_ error: Error) -> Error

    /// Called by some systems when the screen changes.
    ///
    /// - Parameters:
    ///     - notification: Some systems provide an accompanying notification.
    func updateAccordingToScreenChange(_ notification: Notification?)

    /// Called by some systems as access to protected data is granted.
    func finishGainingAccessToProtectedData()

    /// Called by some systems before access to protected data is revoked.
    func prepareToLoseAccessToProtectedData()

    /// Called by some systems when an activity handoff begins.
    ///
    /// - Parameters:
    ///     - identifier: The activity identifier.
    ///
    /// - Returns: `true` if the user was notified, or `false` to request that the system notify the user.
    func notifyHandoffBegan(_ identifier: String) -> Bool

    /// Called by some systems to request a handoff from another device.
    ///
    /// - Parameters:
    ///     - handoff: The handoff activity.
    /// 	- details: Details about the handoff.
    ///
    /// - Returns: `true` if the handoff has been accepted, `false` to request that the system accept the handoff.
    func accept(handoff: NSUserActivity, details: HandoffDetails) -> Bool

    /// Called by some systems when an activity handoff fails.
    ///
    /// - Parameters:
    ///     - identifier: The activity identifier.
    ///
    /// - Returns: `true` if the user was notified, or `false` to request that the system notify the user.
    func notifyHandoffFailed(_ identifier: String, error: Error) -> Bool

    /// Called by some systems to allow preprocessing of the handoff before it is sent to another device.
    ///
    /// - Parameters:
    ///     - handoff: The handoff activity.
    func preprocess(handoff: NSUserActivity)

    /// Called by some systems as the remote notification registration finishes.
    func finishRegistrationForRemoteNotifications(deviceToken: Data)

    /// Called by some systems when remote notification registration fails.
    ///
    /// - Parameters:
    ///     - error: The error.
    func reportFailedRegistrationForRemoteNotifications(error: Error)

    /// Called by some systems to request that a remote notification be accepted.
    ///
    /// - Parameters:
    ///     - details: Details provided by the system.
    ///
    /// - Returns: The result of the fetch operation.
    func acceptRemoteNotification(details: RemoteNotificationDetails) -> FetchResult

    /// Called by some systems to request that one or more files be opened.
    ///
    /// - Parameters:
    ///     - details: Details provided by the system.
    ///
    /// - Returns: Whether or not the files could be opened successfully.
    func open(files: [URL], details: OpeningDetails) -> Bool

    /// Called by some systems to ask whether a new, blank file be created.
    ///
    /// - Returns: Whether or not a file should be created.
    func createNewBlankFile() -> Bool

    /// Called by some systems to request that a file be printed.
    func print(files: [URL], details: PrintingDetails) -> PrintingResponse

    /// Called by some systems to ask whether to encode a restorable state.
    ///
    /// - Parameters:
    ///     - coder: The coder.
    func shouldEncodeRestorableState(coder: NSCoder) -> Bool

    /// Called by some systems before encoding a restorable state.
    ///
    /// - Parameters:
    ///     - coder: The coder.
    func prepareToEncodeRestorableState(coder: NSCoder)

    /// Called by some systems to ask whether to restore a previous state.
    ///
    /// - Parameters:
    ///     - coder: The coder.
    func shouldRestorePreviousState(coder: NSCoder) -> Bool

    /// Called by some systems as restoration finishes.
    ///
    /// - Parameters:
    ///     - coder: The coder.
    func finishRestoring(coder: NSCoder)

    /// Called by some systems when the application’s occlusion changes.
    ///
    /// - Returns: `false` if the application cannot continue. Otherwise `true`.
    func updateAccordingToOcclusionChange(_ notification: Notification?)

    /// Called by some systems when memory is low.
    func purgeUnnecessaryMemory()

    /// Called by some systems when certain time changes occur.
    func updateAccordingToTimeChange()
}

extension SystemMediator {

    public func prepareToLaunch(_ details: LaunchDetails) -> Bool {
        return true
    }

    public func prepareToAcquireFocus(_ notification: Notification?) {}
    public func finishAcquiringFocus(_ notification: Notification?) {}
    public func prepareToResignFocus(_ notification: Notification?) {}
    public func finishResigningFocus(_ notification: Notification?) {}

    public func terminate() -> TerminationResponse {
        return .now
    }
    public var remainsRunningWithNoWindows: Bool {
        return false
    }
    public func prepareToTerminate(_ notification: Notification?) {}

    public func prepareToHide(_ notification: Notification?) {}
    public func finishHiding(_ notification: Notification?) {}
    public func prepareToUnhide(_ notification: Notification?) {}
    public func finishUnhiding(_ notification: Notification?) {}

    public func prepareToUpdateInterface(_ notification: Notification?) {}
    public func finishUpdatingInterface(_ notification: Notification?) {}

    public func reopen(hasVisibleWindows: Bool?) -> Bool {
        return false
    }

    public var dockMenu: NSMenu? {
        return nil
    }

    public func preprocessErrorForDisplay(_ error: Error) -> Error {
        return error
    }

    public func updateAccordingToScreenChange(_ notification: Notification?) {}

    public func finishGainingAccessToProtectedData() {}
    public func prepareToLoseAccessToProtectedData() {}

    public func notifyHandoffBegan(_ identifier: String) -> Bool {
        return false
    }
    public func accept(handoff: NSUserActivity, details: HandoffDetails) -> Bool {
        return false
    }
    public func notifyHandoffFailed(_ identifier: String, error: Error) -> Bool {
        return false
    }
    public func preprocess(handoff: NSUserActivity) {}

    public func finishRegistrationForRemoteNotifications(deviceToken: Data) {
        #if UNHANDLED_SYSTEM_EVENT_LOGGING
        Swift.print(#function)
        #endif
    }
    public func reportFailedRegistrationForRemoteNotifications(error: Error) {
        #if UNHANDLED_SYSTEM_EVENT_LOGGING
        Swift.print(#function)
        #endif
    }
    public func acceptRemoteNotification(details: RemoteNotificationDetails) -> FetchResult {
        #if UNHANDLED_SYSTEM_EVENT_LOGGING
        Swift.print(#function)
        #endif
        return .noData
    }

    public func open(files: [URL], details: OpeningDetails) -> Bool {
        #if UNHANDLED_SYSTEM_EVENT_LOGGING
        Swift.print(#function)
        #endif
        return false
    }

    public func createNewBlankFile() -> Bool {
        #if UNHANDLED_SYSTEM_EVENT_LOGGING
        Swift.print(#function)
        #endif
        return false
    }

    public func shouldCreateNewBlankFile() -> Bool {
        return true
    }

    public func print(files: [URL], details: PrintingDetails) -> PrintingResponse {
        #if UNHANDLED_SYSTEM_EVENT_LOGGING
        Swift.print(#function)
        #endif
        return .failure
    }

    public func shouldEncodeRestorableState(coder: NSCoder) -> Bool {
        return false
    }
    public func prepareToEncodeRestorableState(coder: NSCoder) {}
    public func shouldRestorePreviousState(coder: NSCoder) -> Bool {
        #if UNHANDLED_SYSTEM_EVENT_LOGGING
        Swift.print(#function)
        #endif
        return false
    }
    public func finishRestoring(coder: NSCoder) {}

    public func updateAccordingToOcclusionChange(_ notification: Notification?) {}

    public func purgeUnnecessaryMemory() {}

    public func updateAccordingToTimeChange() {}
}
