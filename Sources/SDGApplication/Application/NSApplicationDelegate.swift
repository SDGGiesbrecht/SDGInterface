/*
 NSApplicationDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit

import SDGLogic

internal class NSApplicationDelegate : NSObject, AppKit.NSApplicationDelegate, _NSApplicationDelegateProtocol, NSMenuItemValidation {

    // MARK: - Top Responder

    @objc internal func openPreferences(_ sender: Any?) {
        Application.shared.preferenceManager?.openPreferences()
    }

    // MARK: - NSApplicationDelegate

    internal func applicationWillFinishLaunching(_ notification: Notification) {
        var details = LaunchDetails()
        details.notification = notification
        _ = Application.shared.systemMediator?.prepareToLaunch(details)
    }

    internal func applicationDidFinishLaunching(_ notification: Notification) {

        Application.postLaunchSetUp()

        var details = LaunchDetails()
        details.notification = notification
        _ = Application.shared.systemMediator?.finishLaunching(details)
    }

    internal func applicationWillBecomeActive(_ notification: Notification) {
        Application.shared.systemMediator?.prepareToAcquireFocus(notification)
    }

    internal func applicationDidBecomeActive(_ notification: Notification) {
        Application.shared.systemMediator?.finishAcquiringFocus(notification)
    }

    internal func applicationWillResignActive(_ notification: Notification) {
        Application.shared.systemMediator?.prepareToResignFocus(notification)
    }

    internal func applicationDidResignActive(_ notification: Notification) {
        Application.shared.systemMediator?.finishResigningFocus(notification)
    }

    internal func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        return (Application.shared.systemMediator?.terminate() ?? .now).native
    }

    internal func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return ¬(Application.shared.systemMediator?.remainsRunningWithNoWindows ?? false)
    }

    internal func applicationWillTerminate(_ notification: Notification) {
        Application.shared.systemMediator?.prepareToTerminate(notification)
    }

    internal func applicationWillHide(_ notification: Notification) {
        Application.shared.systemMediator?.prepareToHide(notification)
    }

    internal func applicationDidHide(_ notification: Notification) {
        Application.shared.systemMediator?.finishHiding(notification)
    }

    internal func applicationWillUnhide(_ notification: Notification) {
        Application.shared.systemMediator?.prepareToUnhide(notification)
    }

    internal func applicationDidUnhide(_ notification: Notification) {
        Application.shared.systemMediator?.finishUnhiding(notification)
    }

    internal func applicationWillUpdate(_ notification: Notification) {
        Application.shared.systemMediator?.prepareToUpdateInterface(notification)
    }

    internal func applicationDidUpdate(_ notification: Notification) {
        Application.shared.systemMediator?.finishUpdatingInterface(notification)
    }

    internal func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        return ¬(Application.shared.systemMediator?.reopen(hasVisibleWindows: flag) ?? false)
    }

    internal func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        return Application.shared.systemMediator?.dockMenu?.native
    }

    internal func application(_ application: NSApplication, willPresentError error: Error) -> Error {
        return Application.shared.systemMediator?.preprocessErrorForDisplay(error) ?? error
    }

    internal func applicationDidChangeScreenParameters(_ notification: Notification) {
        Application.shared.systemMediator?.updateAccordingToScreenChange(notification)
    }

    internal func application(_ application: NSApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        return Application.shared.systemMediator?.notifyHandoffBegan(userActivityType) ?? false
    }

    internal func application(
        _ application: NSApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([NSUserActivityRestoring]) -> Void) -> Bool {
        var details = HandoffDetails()
        details.restorationHandler = restorationHandler
        return Application.shared.systemMediator?.accept(
            handoff: userActivity,
            details: details) ?? false
    }

    internal func application(_ application: NSApplication, didUpdate userActivity: NSUserActivity) {
        Application.shared.systemMediator?.preprocess(handoff: userActivity)
    }

    internal func application(
        _ application: NSApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Application.shared.systemMediator?.finishRegistrationForRemoteNotifications(deviceToken: deviceToken)
    }

    internal func application(
        _ application: NSApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Application.shared.systemMediator?.reportFailedRegistrationForRemoteNotifications(error: error)
    }

    internal func application(
        _ application: NSApplication,
        didReceiveRemoteNotification userInfo: [String: Any]) {
        var details = RemoteNotificationDetails()
        details.userInformation = userInfo
        _ = Application.shared.systemMediator?.acceptRemoteNotification(
            details: details)
    }

    internal func application(_ application: NSApplication, open urls: [URL]) {
        var details = OpeningDetails()
        details.withoutUserInterface = false
        details.asTemporaryFile = false
        _ = Application.shared.systemMediator?.open(
            files: urls,
            details: details)
    }

    internal func application(_ sender: Any, openFileWithoutUI filename: String) -> Bool {
        var details = OpeningDetails()
        details.withoutUserInterface = true
        details.asTemporaryFile = false
        return Application.shared.systemMediator?.open(
            files: [URL(fileURLWithPath: filename)],
            details: details) ?? false
    }

    internal func application(_ sender: NSApplication, openTempFile filename: String) -> Bool {
        var details = OpeningDetails()
        details.withoutUserInterface = false
        details.asTemporaryFile = true
        return Application.shared.systemMediator?.open(
            files: [URL(fileURLWithPath: filename)],
            details: details) ?? false
    }

    internal func applicationOpenUntitledFile(_ sender: NSApplication) -> Bool {
        return Application.shared.systemMediator?.createNewBlankFile() ?? false
    }

    internal func applicationShouldOpenUntitledFile(_ sender: NSApplication) -> Bool {
        return Application.shared.systemMediator?.shouldCreateNewBlankFile() ?? true
    }

    internal func application(
        _ application: NSApplication,
        printFiles fileNames: [String],
        withSettings printSettings: [NSPrintInfo.AttributeKey: Any],
        showPrintPanels: Bool) -> NSApplication.PrintReply {
        var details = PrintingDetails()
        details.settings = printSettings
        details.displayPanels = showPrintPanels
        let result = Application.shared.systemMediator?.print(
            files: fileNames.map({ URL(fileURLWithPath: $0) }),
            details: details) ?? .failure
        return result.native
    }

    internal func application(_ app: NSApplication, didDecodeRestorableState coder: NSCoder) {
        Application.shared.systemMediator?.finishRestoring(coder: coder)
    }

    internal func application(_ app: NSApplication, willEncodeRestorableState coder: NSCoder) {
        Application.shared.systemMediator?.prepareToEncodeRestorableState(coder: coder)
    }

    internal func applicationDidChangeOcclusionState(_ notification: Notification) {
        Application.shared.systemMediator?.updateAccordingToOcclusionChange(notification)
    }

    // MARK: - NSMenuItemValidation

    internal func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        if menuItem.action == #selector(NSApplicationDelegate.openPreferences(_:)),
            Application.shared.preferenceManager == nil {
            menuItem.isHidden = true
            return false
        }
        if let action = menuItem.action {
            return responds(to: action)
        } else {
            return false
        }
    }
}
#endif
