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
        <#code#>
    }

    internal func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        <#code#>
    }

    internal func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        <#code#>
    }

    internal func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        <#code#>
    }

    internal func applicationSignificantTimeChange(_ application: UIApplication) {
        <#code#>
    }

    internal func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        <#code#>
    }

    internal func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        <#code#>
    }

    internal func application(
        _ application: UIApplication,
        viewControllerWithRestorationIdentifierPath identifierComponents: [String],
        coder: NSCoder) -> UIViewController? {
        <#code#>
    }

    internal func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        <#code#>
    }

    internal func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        <#code#>
    }

    internal func application(
        _ application: UIApplication,
        handleEventsForBackgroundURLSession identifier: String,
        completionHandler: @escaping () -> Void) {
        <#code#>
    }

    internal func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        <#code#>
    }

    internal func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        <#code#>
    }

    internal func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        <#code#>
    }

    internal func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        <#code#>
    }

    internal func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        <#code#>
    }

    internal func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        <#code#>
    }

    internal func application(
        _ application: UIApplication,
        didFailToContinueUserActivityWithType userActivityType: String,
        error: Error) {
        <#code#>
    }

    internal func application(
        _ application: UIApplication,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void) {
        <#code#>
    }

    internal func application(
        _ application: UIApplication,
        handleWatchKitExtensionRequest userInfo: [AnyHashable : Any]?,
        reply: @escaping ([AnyHashable : Any]?) -> Void) {
        <#code#>
    }

    internal func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        <#code#>
    }

    internal func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        <#code#>
    }

    internal func application(
        _ application: UIApplication,
        shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier
        ) -> Bool {
        <#code#>
    }

    internal func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        <#code#>
    }
}
#endif
