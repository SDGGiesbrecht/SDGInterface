/*
 SystemMediator.swift

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

import SDGMenus

/// An object which mediates between the application and system events.
public protocol SystemMediator {

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
  func prepareToAcquireFocus(_ notification: SystemNotification?)

  /// Called by some systems as the application finishes acquiring the system focus.
  ///
  /// - Parameters:
  ///     - notification: Some systems provide an accompanying notification.
  func finishAcquiringFocus(_ notification: SystemNotification?)

  /// Called by some systems before the application resigns the system focus.
  ///
  /// - Parameters:
  ///     - notification: Some systems provide an accompanying notification.
  func prepareToResignFocus(_ notification: SystemNotification?)

  /// Called by some systems as the application finishes resigning the system focus.
  ///
  /// - Parameters:
  ///     - notification: Some systems provide an accompanying notification.
  func finishResigningFocus(_ notification: SystemNotification?)

  /// Called by some systems to request that the application terminate.
  func terminate() -> TerminationResponse

  /// On platforms which offer to terminate the application automatically when the last window closes, returning `false` requests that the application remain running.
  var remainsRunningWithNoWindows: Bool { get }

  /// Called by some systems before the application terminates.
  ///
  /// - Parameters:
  ///     - notification: Some systems provide an accompanying notification.
  func prepareToTerminate(_ notification: SystemNotification?)

  /// Called by some systems before the application is hidden.
  ///
  /// - Parameters:
  ///     - notification: Some systems provide an accompanying notification.
  func prepareToHide(_ notification: SystemNotification?)

  /// Called by some systems as the application finishes being hidden.
  ///
  /// - Parameters:
  ///     - notification: Some systems provide an accompanying notification.
  func finishHiding(_ notification: SystemNotification?)

  /// Called by some systems before the application is unhidden.
  ///
  /// - Parameters:
  ///     - notification: Some systems provide an accompanying notification.
  func prepareToUnhide(_ notification: SystemNotification?)

  /// Called by some systems as the application finishes being unhidden.
  ///
  /// - Parameters:
  ///     - notification: Some systems provide an accompanying notification.
  func finishUnhiding(_ notification: SystemNotification?)

  /// Called by some systems before the interface update cycle begins.
  ///
  /// - Parameters:
  ///     - notification: Some systems provide an accompanying notification.
  func prepareToUpdateInterface(_ notification: SystemNotification?)

  /// Called by some systems as the interface update cycle finishes.
  ///
  /// - Parameters:
  ///     - notification: Some systems provide an accompanying notification.
  func finishUpdatingInterface(_ notification: SystemNotification?)

  /// Called by some systems when a user tries to open the application while it is already running.
  ///
  /// - Parameters:
  ///     - hasVisibleWindows: Some systems report whether or not they perceive the application to have visible windows.
  ///
  /// - Returns: `true` if the reopen operation has been handled, `false` to request that the operating system handle it.
  func reopen(hasVisibleWindows: Bool?) -> Bool

  #if canImport(AppKit)
    /// Used by some systems as the dock menu.
    var dockMenu: AnyMenu? { get }
  #endif

  /// Called by some systems before displaying an error to the user.
  ///
  /// - Parameters:
  ///     - error: The error.
  func preprocessErrorForDisplay(_ error: Error) -> Error

  /// Called by some systems when the screen changes.
  ///
  /// - Parameters:
  ///     - notification: Some systems provide an accompanying notification.
  func updateAccordingToScreenChange(_ notification: SystemNotification?)

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
  func accept(handoff: Handoff, details: HandoffAcceptanceDetails) -> Bool

  /// Called by some systems when an activity handoff fails.
  ///
  /// - Parameters:
  ///     - identifier: The activity identifier.
  ///     - error: The error that occurred.
  ///
  /// - Returns: `true` if the user was notified, or `false` to request that the system notify the user.
  func notifyHandoffFailed(_ identifier: String, error: Error) -> Bool

  /// Called by some systems to allow preprocessing of the handoff before it is sent to another device.
  ///
  /// - Parameters:
  ///     - handoff: The handoff activity.
  func preprocess(handoff: Handoff)

  // #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
  #if canImport(Foundation)
    /// Called by some systems as the remote notification registration finishes.
    ///
    /// - Parameters:
    ///     - deviceToken: The device token
    func finishRegistrationForRemoteNotifications(deviceToken: Data)
  #endif

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
  func acceptRemoteNotification(
    details: RemoteNotificationDetails
  ) -> FetchResult

  // #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
  #if canImport(Foundation)
    /// Called by some systems to request that one or more files be opened.
    ///
    /// - Parameters:
    ///     - files: The files to open.
    ///     - details: Details provided by the system.
    ///
    /// - Returns: Whether or not the files could be opened successfully.
    func open(files: [URL], details: OpeningDetails) -> Bool
  #endif

  /// Called by some systems to request that a new, blank file be created.
  ///
  /// - Returns: Whether or not the file was successfully created.
  func createNewBlankFile() -> Bool

  /// Called by some systems to ask whether a new, blank file should be created.
  ///
  /// - Returns: Whether or not a file should be created.
  func shouldCreateNewBlankFile() -> Bool

  // #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
  #if canImport(Foundation)
    /// Called by some systems to request that a file be printed.
    ///
    /// - Parameters:
    ///     - files: The files to open.
    ///     - details: Details provided by the system.
    func print(files: [URL], details: PrintingDetails) -> PrintingResponse
  #endif

  // #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
  #if canImport(Foundation)
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

    /// Returns the controller for a particular restoration identifier path.
    ///
    /// - Parameters:
    ///     - path: The path.
    ///     - coder: The coder.
    func viewController(
      forRestorationIdentifierPath path: [String],
      coder: NSCoder
    ) -> ViewControllerRestorationResponse
  #endif

  /// Called by some systems when the application’s occlusion changes.
  ///
  /// - Parameters:
  ///     - notification: Some systems provide an accompanying notification.
  func updateAccordingToOcclusionChange(_ notification: SystemNotification?)

  /// Called by some systems when memory is low.
  func purgeUnnecessaryMemory()

  /// Called by some systems when certain time changes occur.
  func updateAccordingToTimeChange()

  /// Called by some systems to request that a background URL session event be handled.
  ///
  /// - Parameters:
  ///     - identifier: The session identifier.
  func handleEventsForBackgroundURLSession(_ identifier: String)

  /// Called by some systems to request that a quick action from the home screen be performed.
  ///
  /// - Parameters:
  ///     - details: Details provided by the system.
  ///
  /// - Returns: Whether or not the action succeeded.
  func performQuickAction(details: QuickActionDetails) -> Bool

  /// Called by some systems to request that a watch request be handled.
  ///
  /// - Parameters:
  ///     - userInformation: The user information.
  func handleWatchRequest(userInformation: [AnyHashable: Any]?) -> [AnyHashable: Any]?

  /// Called by some systems when the application should request health authorization.
  func requestHealthAuthorization()

  /// Called by some systems to ask whether an extension should be allowed.
  ///
  /// - Parameters:
  ///     - details: Details provided by the system.
  func shouldAllowExtension(details: ExtensionDetails) -> Bool
}

extension SystemMediator {

  public func prepareToLaunch(_ details: LaunchDetails) -> Bool {
    return true
  }

  public func prepareToAcquireFocus(_ notification: SystemNotification?) {}
  public func finishAcquiringFocus(_ notification: SystemNotification?) {}
  public func prepareToResignFocus(_ notification: SystemNotification?) {}
  public func finishResigningFocus(_ notification: SystemNotification?) {}

  public func terminate() -> TerminationResponse {
    return .now
  }
  public var remainsRunningWithNoWindows: Bool {
    return false
  }
  public func prepareToTerminate(_ notification: SystemNotification?) {}

  public func prepareToHide(_ notification: SystemNotification?) {}
  public func finishHiding(_ notification: SystemNotification?) {}
  public func prepareToUnhide(_ notification: SystemNotification?) {}
  public func finishUnhiding(_ notification: SystemNotification?) {}

  public func prepareToUpdateInterface(_ notification: SystemNotification?) {}
  public func finishUpdatingInterface(_ notification: SystemNotification?) {}

  public func reopen(hasVisibleWindows: Bool?) -> Bool {
    return false
  }

  #if canImport(AppKit)
    public var dockMenu: AnyMenu? {
      return nil
    }
  #endif

  public func preprocessErrorForDisplay(_ error: Error) -> Error {
    return error
  }

  public func updateAccordingToScreenChange(_ notification: SystemNotification?) {}

  public func finishGainingAccessToProtectedData() {}
  public func prepareToLoseAccessToProtectedData() {}

  public func notifyHandoffBegan(_ identifier: String) -> Bool {
    return false
  }
  public func accept(handoff: Handoff, details: HandoffAcceptanceDetails) -> Bool {
    return false
  }
  public func notifyHandoffFailed(_ identifier: String, error: Error) -> Bool {
    return false
  }
  public func preprocess(handoff: Handoff) {}

  // #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
  #if canImport(Foundation)
    public func finishRegistrationForRemoteNotifications(deviceToken: Data) {
      #if DEBUG
        Swift.print(#function)
      #endif
    }
  #endif
  public func reportFailedRegistrationForRemoteNotifications(error: Error) {
    #if DEBUG
      Swift.print(#function)
    #endif
  }
  public func acceptRemoteNotification(
    details: RemoteNotificationDetails
  ) -> FetchResult {
    #if DEBUG
      Swift.print(#function)
    #endif
    return .noData
  }

  public func open(files: [URL], details: OpeningDetails) -> Bool {
    #if DEBUG
      Swift.print(#function)
    #endif
    return false
  }

  public func createNewBlankFile() -> Bool {
    return false
  }

  public func shouldCreateNewBlankFile() -> Bool {
    return true
  }

  // #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
  #if canImport(Foundation)
    public func print(files: [URL], details: PrintingDetails) -> PrintingResponse {
      #if DEBUG
        Swift.print(#function)
      #endif
      return .failure
    }

    public func shouldEncodeRestorableState(coder: NSCoder) -> Bool {
      return false
    }
    public func prepareToEncodeRestorableState(coder: NSCoder) {}
    public func shouldRestorePreviousState(coder: NSCoder) -> Bool {
      #if DEBUG
        Swift.print(#function)
      #endif
      return false
    }
    public func finishRestoring(coder: NSCoder) {}
    public func viewController(
      forRestorationIdentifierPath path: [String],
      coder: NSCoder
    ) -> ViewControllerRestorationResponse {
      #if DEBUG
        Swift.print(#function)
      #endif
      return ViewControllerRestorationResponse()
    }
  #endif

  public func updateAccordingToOcclusionChange(_ notification: SystemNotification?) {}

  public func purgeUnnecessaryMemory() {}

  public func updateAccordingToTimeChange() {}

  public func handleEventsForBackgroundURLSession(_ identifier: String) {}

  public func performQuickAction(details: QuickActionDetails) -> Bool {
    #if DEBUG
      Swift.print(#function)
    #endif
    return false
  }

  public func handleWatchRequest(userInformation: [AnyHashable: Any]?) -> [AnyHashable: Any]? {
    #if DEBUG
      Swift.print(#function)
    #endif
    return nil
  }

  public func requestHealthAuthorization() {
    #if DEBUG
      Swift.print(#function)
    #endif
  }

  public func shouldAllowExtension(details: ExtensionDetails) -> Bool {
    return true
  }
}
