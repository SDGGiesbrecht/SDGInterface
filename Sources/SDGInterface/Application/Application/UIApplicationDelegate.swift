/*
 UIApplicationDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit)
  import UIKit

  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

  /// See Application.main().
  internal var applicationToUse: Any?

  #if !os(watchOS)

    internal class UIApplicationDelegate<Application>: NSObject, UIKit.UIApplicationDelegate
    where Application: LegacyApplication {

      // MARK: - Initialization

      internal init(application: Application) {
        self.application = application
      }

      internal override convenience init() {  // @exempt(from: tests)
        // Only reachable through UIApplicationMain.
        guard let application = applicationToUse as? Application else {
          preconditionFailure(
            UserFacing<StrictString, APILocalization>({ localization in
              switch localization {
              case .englishCanada:
                return "Cannot initialize a delegate when no application has been registered."
              }
            })
          )
        }
        self.init(application: application)
      }

      // MARK: - Properties

      private let application: Application

      // MARK: - UIApplicationDelegate

      internal func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
      ) -> Bool {
        var details = LaunchDetails()
        details.options = launchOptions
        return self.application.prepareToLaunch(details)
      }

      internal func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
      ) -> Bool {

        self.application.performPostLaunchSetUp()

        var details = LaunchDetails()
        details.options = launchOptions
        return self.application.setUpAndFinishLaunching(details)
      }

      internal func applicationDidBecomeActive(_ application: UIApplication) {
        self.application.finishAcquiringFocus(nil)
      }

      internal func applicationWillResignActive(_ application: UIApplication) {
        self.application.prepareToResignFocus(nil)
      }

      internal func applicationDidEnterBackground(_ application: UIApplication) {
        self.application.finishResigningFocus(nil)
      }

      internal func applicationWillEnterForeground(_ application: UIApplication) {
        self.application.prepareToAcquireFocus(nil)
      }

      internal func applicationWillTerminate(_ application: UIApplication) {
        self.application.prepareToTerminate(nil)
      }

      internal func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        self.application.finishGainingAccessToProtectedData()
      }

      internal func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        self.application.prepareToLoseAccessToProtectedData()
      }

      internal func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        self.application.purgeUnnecessaryMemory()
      }

      internal func applicationSignificantTimeChange(_ application: UIApplication) {
        self.application.updateAccordingToTimeChange()
      }

      internal func application(
        _ application: UIApplication,
        shouldSaveApplicationState coder: NSCoder
      ) -> Bool {
        return self.application.shouldEncodeRestorableState(coder: coder)
      }

      internal func application(
        _ application: UIApplication,
        shouldRestoreApplicationState coder: NSCoder
      ) -> Bool {
        return self.application.shouldRestorePreviousState(coder: coder)
      }

      internal func application(
        _ application: UIApplication,
        viewControllerWithRestorationIdentifierPath identifierComponents: [String],
        coder: NSCoder
      ) -> UIViewController? {
        return self.application.viewController(
          forRestorationIdentifierPath: identifierComponents,
          coder: coder
        ).viewController
      }

      internal func application(
        _ application: UIApplication,
        willEncodeRestorableStateWith coder: NSCoder
      ) {
        self.application.prepareToEncodeRestorableState(coder: coder)
      }

      internal func application(
        _ application: UIApplication,
        didDecodeRestorableStateWith coder: NSCoder
      ) {
        self.application.finishRestoring(coder: coder)
      }

      internal func application(
        _ application: UIApplication,
        handleEventsForBackgroundURLSession identifier: String,
        completionHandler: @escaping () -> Void
      ) {
        self.application.handleEventsForBackgroundURLSession(identifier)
        completionHandler()
      }

      internal func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
      ) {
        self.application.finishRegistrationForRemoteNotifications(
          deviceToken: deviceToken
        )
      }

      internal func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
      ) {
        self.application.reportFailedRegistrationForRemoteNotifications(
          error: error
        )
      }

      internal func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
      ) {
        var details = RemoteNotificationDetails()
        details.userInformation = userInfo
        let result =
          self.application.acceptRemoteNotification(
            details: details
          )
        completionHandler(result.cocoa)
      }

      internal func application(
        _ application: UIApplication,
        willContinueUserActivityWithType userActivityType: String
      ) -> Bool {
        return self.application.notifyHandoffBegan(userActivityType)
      }

      internal func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
      ) -> Bool {
        var handoff = Handoff()
        handoff.activity = userActivity
        var details = HandoffAcceptanceDetails()
        details.restorationHandler = restorationHandler
        return self.application.accept(
          handoff: handoff,
          details: details
        )
      }

      internal func application(
        _ application: UIApplication,
        didUpdate userActivity: NSUserActivity
      ) {
        var handoff = Handoff()
        handoff.activity = userActivity
        self.application.preprocess(handoff: handoff)
      }

      #if !os(tvOS)
        internal func application(
          _ application: UIApplication,
          performActionFor shortcutItem: UIApplicationShortcutItem,
          completionHandler: @escaping (Bool) -> Void
        ) {
          var details = QuickActionDetails()
          details.shortcutItem = shortcutItem
          let result =
            self.application.performQuickAction(
              details: details
            )
          completionHandler(result)
        }
      #endif

      internal func application(
        _ application: UIApplication,
        handleWatchKitExtensionRequest userInfo: [AnyHashable: Any]?,
        reply: @escaping ([AnyHashable: Any]?) -> Void
      ) {
        let result = self.application.handleWatchRequest(userInformation: userInfo)
        reply(result)
      }

      internal func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        self.application.requestHealthAuthorization()
      }

      internal func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
      ) -> Bool {
        var details = OpeningDetails()
        details.options = options
        return self.application.open(
          files: [url],
          details: details
        )
      }

      internal func application(
        _ application: UIApplication,
        shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication
          .ExtensionPointIdentifier
      ) -> Bool {
        var details = ExtensionDetails()
        details.pointIdentifier = extensionPointIdentifier
        return self.application.shouldAllowExtension(
          details: details
        )
      }
    }
  #endif
#endif
