/*
 UIApplicationDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit) && !os(watchOS)
internal class UIApplicationDelegate: NSObject, UIKit.UIApplicationDelegate {

    // MARK: - UIApplicationDelegate

    internal func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        var details = LaunchDetails()
        details.options = launchOptions
        return Application.shared.systemMediator?.prepareToLaunch(details) ?? false
    }

    internal func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        Application.postLaunchSetUp()

        var details = LaunchDetails()
        details.options = launchOptions
        return Application.shared.systemMediator?.finishLaunching(details) ?? false
    }

    internal func applicationDidBecomeActive(_ application: UIApplication) {
        Application.shared.systemMediator?.finishAcquiringFocus(nil)
    }

    internal func applicationWillResignActive(_ application: UIApplication) {
        Application.shared.systemMediator?.prepareToResignFocus(nil)
    }

    internal func applicationDidEnterBackground(_ application: UIApplication) {
        Application.shared.systemMediator?.finishResigningFocus(nil)
    }

    internal func applicationWillEnterForeground(_ application: UIApplication) {
        Application.shared.systemMediator?.prepareToAcquireFocus(nil)
    }

    internal func applicationWillTerminate(_ application: UIApplication) {
        Application.shared.systemMediator?.prepareToTerminate(nil)
    }

    internal func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        Application.shared.systemMediator?.finishGainingAccessToProtectedData()
    }

    internal func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        Application.shared.systemMediator?.prepareToLoseAccessToProtectedData()
    }

    internal func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        Application.shared.systemMediator?.purgeUnnecessaryMemory()
    }

    internal func applicationSignificantTimeChange(_ application: UIApplication) {
        Application.shared.systemMediator?.updateAccordingToTimeChange()
    }

    internal func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return Application.shared.systemMediator?.shouldEncodeRestorableState(coder: coder) ?? false
    }

    internal func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return Application.shared.systemMediator?.shouldRestorePreviousState(coder: coder) ?? false
    }

    internal func application(
        _ application: UIApplication,
        viewControllerWithRestorationIdentifierPath identifierComponents: [String],
        coder: NSCoder) -> UIViewController? {
        return Application.shared.systemMediator?.viewController(
            forRestorationIdentifierPath: identifierComponents,
            coder: coder).viewController
    }

    internal func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        Application.shared.systemMediator?.prepareToEncodeRestorableState(coder: coder)
    }

    internal func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        Application.shared.systemMediator?.finishRestoring(coder: coder)
    }

    internal func application(
        _ application: UIApplication,
        handleEventsForBackgroundURLSession identifier: String,
        completionHandler: @escaping () -> Void) {
        Application.shared.systemMediator?.handleEventsForBackgroundURLSession(identifier)
        completionHandler()
    }

    internal func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Application.shared.systemMediator?.finishRegistrationForRemoteNotifications(deviceToken: deviceToken)
    }

    internal func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Application.shared.systemMediator?.reportFailedRegistrationForRemoteNotifications(error: error)
    }

    internal func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        var details = RemoteNotificationDetails()
        details.userInformation = userInfo
        let result = Application.shared.systemMediator?.acceptRemoteNotification(
            details: details) ?? .noData
        completionHandler(result.native)
    }

    internal func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        return Application.shared.systemMediator?.notifyHandoffBegan(userActivityType) ?? false
    }

    internal func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        var details = HandoffDetails()
        details.restorationHandler = restorationHandler
        return Application.shared.systemMediator?.accept(
            handoff: userActivity,
            details: details) ?? false
    }

    internal func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        Application.shared.systemMediator?.preprocess(handoff: userActivity)
    }

    #if !os(tvOS)
    internal func application(
        _ application: UIApplication,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void) {
        var details = QuickActionDetails()
        details.shortcutItem = shortcutItem
        let result = Application.shared.systemMediator?.performQuickAction(
            details: details) ?? false
        completionHandler(result)
    }
    #endif

    internal func application(
        _ application: UIApplication,
        handleWatchKitExtensionRequest userInfo: [AnyHashable : Any]?,
        reply: @escaping ([AnyHashable : Any]?) -> Void) {
        let result = Application.shared.systemMediator?.handleWatchRequest(userInformation: userInfo)
        reply(result)
    }

    internal func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        Application.shared.systemMediator?.requestHealthAuthorization()
    }

    internal func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var details = OpeningDetails()
        details.options = options
        return Application.shared.systemMediator?.open(
            files: [url],
            details: details) ?? false
    }

    internal func application(
        _ application: UIApplication,
        shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier
        ) -> Bool {
        var details = ExtensionDetails()
        details.pointIdentifier = extensionPointIdentifier
        return Application.shared.systemMediator?.shouldAllowExtension(
            details: details) ?? true
    }
}
#endif
