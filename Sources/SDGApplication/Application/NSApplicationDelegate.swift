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
        <#code#>
    }

    internal func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        <#code#>
    }

    internal func applicationWillTerminate(_ notification: Notification) {
        <#code#>
    }

    internal func applicationWillHide(_ notification: Notification) {
        <#code#>
    }

    internal func applicationDidHide(_ notification: Notification) {
        <#code#>
    }

    internal func applicationWillUnhide(_ notification: Notification) {
        <#code#>
    }

    internal func applicationDidUnhide(_ notification: Notification) {
        <#code#>
    }

    internal func applicationWillUpdate(_ notification: Notification) {
        <#code#>
    }

    internal func applicationDidUpdate(_ notification: Notification) {
        <#code#>
    }

    internal func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        <#code#>
    }

    internal func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        <#code#>
    }

    internal func application(_ application: NSApplication, willPresentError error: Error) -> Error {
        <#code#>
    }

    internal func applicationDidChangeScreenParameters(_ notification: Notification) {
        <#code#>
    }

    internal func application(_ application: NSApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        <#code#>
    }

    internal func application(
        _ application: NSApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([NSUserActivityRestoring]) -> Void) -> Bool {
        <#code#>
    }

    internal func application(
        _ application: NSApplication,
        didFailToContinueUserActivityWithType userActivityType: String,
        error: Error) {
        <#code#>
    }

    internal func application(_ application: NSApplication, didUpdate userActivity: NSUserActivity) {
        <#code#>
    }

    internal func application(
        _ application: NSApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        <#code#>
    }

    internal func application(_ application: NSApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        <#code#>
    }

    internal func application(_ application: NSApplication, didReceiveRemoteNotification userInfo: [String : Any]) {
        <#code#>
    }

    internal func application(_ application: NSApplication, open urls: [URL]) {
        <#code#>
    }

    internal func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        <#code#>
    }

    internal func application(_ sender: Any, openFileWithoutUI filename: String) -> Bool {
        <#code#>
    }

    internal func application(_ sender: NSApplication, openTempFile filename: String) -> Bool {
        <#code#>
    }

    internal func application(_ sender: NSApplication, openFiles filenames: [String]) {
        <#code#>
    }

    internal func applicationOpenUntitledFile(_ sender: NSApplication) -> Bool {
        <#code#>
    }

    internal func applicationShouldOpenUntitledFile(_ sender: NSApplication) -> Bool {
        <#code#>
    }

    internal internal func application(_ sender: NSApplication, printFile filename: String) -> Bool {
        <#code#>
    }

    internal func application(
        _ application: NSApplication,
        printFiles fileNames: [String],
        withSettings printSettings: [NSPrintInfo.AttributeKey : Any],
        showPrintPanels: Bool) -> NSApplication.PrintReply {
        <#code#>
    }

    internal func application(_ app: NSApplication, didDecodeRestorableState coder: NSCoder) {
        <#code#>
    }

    internal func application(_ app: NSApplication, willEncodeRestorableState coder: NSCoder) {
        <#code#>
    }

    internal func applicationDidChangeOcclusionState(_ notification: Notification) {
        <#code#>
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
