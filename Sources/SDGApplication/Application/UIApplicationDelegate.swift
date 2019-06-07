/*
 UIApplicationDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit)
internal class UIApplicationDelegate: NSObject, UIKit.UIApplicationDelegate {

    // MARK: - UIApplicationDelegate

    internal func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return Application.shared.systemMediator?.prepareToLaunch(LaunchDetails(
            options: launchOptions)) ?? false
    }

    internal func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        UIMenuController.shared.extend()

        return Application.shared.systemMediator?.finishLaunching(LaunchDetails(
            options: launchOptions)) ?? false
    }

    internal func applicationDidBecomeActive(_ application: UIApplication) {
        Application.shared.systemMediator?.finishAcquiringFocus(FocusChangeDetails())
    }

    internal func applicationWillResignActive(_ application: UIApplication) {
        Application.shared.systemMediator?.prepareToResignFocus(FocusChangeDetails())
    }

    internal func applicationDidEnterBackground(_ application: UIApplication) {
        Application.shared.systemMediator?.finishResigningFocus(FocusChangeDetails())
    }

    internal func applicationWillEnterForeground(_ application: UIApplication) {
        Application.shared.systemMediator?.prepareToAcquireFocus(FocusChangeDetails())
    }

    internal func applicationWillTerminate(_ application: UIApplication) {
        Application.shared.systemMediator?.prepareToTerminate(TerminationDetails())
    }

    internal func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        #warning("Not yet implemented.")
    }

    internal func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        #warning("Not yet implemented.")
    }

    internal func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        #warning("Not yet implemented.")
    }

    internal func applicationSignificantTimeChange(_ application: UIApplication) {
        #warning("Not yet implemented.")
    }

    internal func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        #warning("Not yet implemented.")
        return false
    }

    internal func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        #warning("Not yet implemented.")
        return false
    }

    internal func application(
        _ application: UIApplication,
        viewControllerWithRestorationIdentifierPath identifierComponents: [String],
        coder: NSCoder) -> UIViewController? {
        #warning("Not yet implemented.")
        return nil
    }

    internal func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        #warning("Not yet implemented.")
    }

    internal func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        #warning("Not yet implemented.")
    }

    internal func application(
        _ application: UIApplication,
        handleEventsForBackgroundURLSession identifier: String,
        completionHandler: @escaping () -> Void) {
        #warning("Not yet implemented.")
    }

    internal func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        #warning("Not yet implemented.")
    }

    internal func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        #warning("Not yet implemented.")
    }

    internal func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        #warning("Not yet implemented.")
    }

    internal func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        #warning("Not yet implemented.")
        return false
    }

    internal func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        #warning("Not yet implemented.")
        return false
    }

    internal func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        #warning("Not yet implemented.")
    }

    internal func application(
        _ application: UIApplication,
        didFailToContinueUserActivityWithType userActivityType: String,
        error: Error) {
        #warning("Not yet implemented.")
    }

    internal func application(
        _ application: UIApplication,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void) {
        #warning("Not yet implemented.")
    }

    internal func application(
        _ application: UIApplication,
        handleWatchKitExtensionRequest userInfo: [AnyHashable : Any]?,
        reply: @escaping ([AnyHashable : Any]?) -> Void) {
        #warning("Not yet implemented.")
    }

    internal func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        #warning("Not yet implemented.")
    }

    internal func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        #warning("Not yet implemented.")
        return false
    }

    internal func application(
        _ application: UIApplication,
        shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier
        ) -> Bool {
        #warning("Not yet implemented.")
        return true
    }

    internal func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        #warning("Not yet implemented.")
        return .all
    }
}
#endif
