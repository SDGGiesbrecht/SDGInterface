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
import SDGLogic

internal class NSApplicationDelegate: NSObject, AppKit.NSApplicationDelegate, NSMenuItemValidation {

    // MARK: - Top Responder

    @objc internal func openPreferences(_ sender: Any?) {
        Application.shared.preferenceManager?.openPreferences()
    }

    // MARK: - NSApplicationDelegate

    internal func applicationWillFinishLaunching(_ notification: Notification) {
        _ = Application.shared.systemMediator?.prepareToLaunch(LaunchDetails(notification: notification))
    }

    internal func applicationDidFinishLaunching(_ notification: Notification) {

        NSApplication.shared.menu = MenuBar.menuBar
        NSApplication.shared.activate(ignoringOtherApps: false)

        _ = Application.shared.systemMediator?.finishLaunching(LaunchDetails(notification: notification))
    }

    internal func applicationWillBecomeActive(_ notification: Notification) {
        Application.shared.systemMediator?.prepareToAcquireFocus(FocusChangeDetails(notification: notification))
    }

    internal func applicationDidBecomeActive(_ notification: Notification) {
        Application.shared.systemMediator?.finishAcquiringFocus(FocusChangeDetails(notification: notification))
    }

    internal func applicationWillResignActive(_ notification: Notification) {
        Application.shared.systemMediator?.prepareToResignFocus(FocusChangeDetails(notification: notification))
    }

    internal func applicationDidResignActive(_ notification: Notification) {
        Application.shared.systemMediator?.finishResigningFocus(FocusChangeDetails(notification: notification))
    }

    internal func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        switch Application.shared.systemMediator?.terminate() ?? .now {
        case .now:
            return .terminateNow
        case .later:
            return .terminateLater
        case .cancel:
            return .terminateCancel
        }
    }

    internal func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return ¬(Application.shared.systemMediator?.remainsRunningWithNoWindows ?? false)
    }

    internal func applicationWillTerminate(_ notification: Notification) {
        Application.shared.systemMediator?.prepareToTerminate(TerminationDetails(notification: notification))
    }

    internal func applicationWillHide(_ notification: Notification) {
        Application.shared.systemMediator?.prepareToHide(HidingDetails(notification: notification))
    }

    internal func applicationDidHide(_ notification: Notification) {
        Application.shared.systemMediator?.finishHiding(HidingDetails(notification: notification))
    }

    internal func applicationWillUnhide(_ notification: Notification) {
        Application.shared.systemMediator?.prepareToUnhide(HidingDetails(notification: notification))
    }

    internal func applicationDidUnhide(_ notification: Notification) {
        Application.shared.systemMediator?.finishUnhiding(HidingDetails(notification: notification))
    }

    internal func applicationWillUpdate(_ notification: Notification) {
        Application.shared.systemMediator?.prepareToUpdateInterface(UpdateDetails(notification: notification))
    }

    internal func applicationDidUpdate(_ notification: Notification) {
        Application.shared.systemMediator?.finishUpdatingInterface(UpdateDetails(notification: notification))
    }

    internal func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        return ¬(Application.shared.systemMediator?.reopen(ReopeningDetails(hasVisibleWindows: flag)) ?? false)
    }

    internal func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        return Application.shared.systemMediator?.dockMenu
    }

    internal func application(_ application: NSApplication, willPresentError error: Error) -> Error {
        return Application.shared.systemMediator?.preprocessErrorForDisplay(error) ?? error
    }

    internal func applicationDidChangeScreenParameters(_ notification: Notification) {
        Application.shared.systemMediator?.updateAccordingToScreenChange(ScreenChangeDetails(
            notification: notification))
    }

    internal func application(_ application: NSApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        return Application.shared.systemMediator?.notifyHandoffBegan(userActivityType) ?? false
    }

    internal func application(
        _ application: NSApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([NSUserActivityRestoring]) -> Void) -> Bool {
        return Application.shared.systemMediator?.accept(
            handoff: userActivity,
            details: HandoffDetails(restorationHandler: restorationHandler)) ?? false
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
        didReceiveRemoteNotification userInfo: [String : Any]) {
        Application.shared.systemMediator?.acceptRemoteNotification(details: RemoteNotificationDetails(
            userInformation: userInfo))
    }

    internal func application(_ application: NSApplication, open urls: [URL]) {
        #warning("Not yet implemented.")
    }

    internal func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        #warning("Not yet implemented.")
        return false
    }

    internal func application(_ sender: Any, openFileWithoutUI filename: String) -> Bool {
        #warning("Not yet implemented.")
        return false
    }

    internal func application(_ sender: NSApplication, openTempFile filename: String) -> Bool {
        #warning("Not yet implemented.")
        return false
    }

    internal func application(_ sender: NSApplication, openFiles filenames: [String]) {
        #warning("Not yet implemented.")
    }

    internal func applicationOpenUntitledFile(_ sender: NSApplication) -> Bool {
        #warning("Not yet implemented.")
        return false
    }

    internal func applicationShouldOpenUntitledFile(_ sender: NSApplication) -> Bool {
        #warning("Not yet implemented.")
        return true
    }

    internal func application(_ sender: NSApplication, printFile filename: String) -> Bool {
        #warning("Not yet implemented.")
        return false
    }

    internal func application(
        _ application: NSApplication,
        printFiles fileNames: [String],
        withSettings printSettings: [NSPrintInfo.AttributeKey : Any],
        showPrintPanels: Bool) -> NSApplication.PrintReply {
        #warning("Not yet implemented.")
        return .printingFailure
    }

    internal func application(_ app: NSApplication, didDecodeRestorableState coder: NSCoder) {
        #warning("Not yet implemented.")
    }

    internal func application(_ app: NSApplication, willEncodeRestorableState coder: NSCoder) {
        #warning("Not yet implemented.")
    }

    internal func applicationDidChangeOcclusionState(_ notification: Notification) {
        #warning("Not yet implemented.")
    }

    // MARK: - NSMenuItemValidation

    internal func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        #warning("Verify this still works!")
        if menuItem.action == #selector(NSApplicationDelegate.openPreferences(_:)) {
            return Application.shared.preferenceManager ≠ nil
        }
        if let action = menuItem.action {
            return responds(to: action)
        } else {
            return false
        }
    }
}
#endif
