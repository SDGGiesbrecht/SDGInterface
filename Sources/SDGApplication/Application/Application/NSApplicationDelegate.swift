/*
 NSApplicationDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SDGLogic

  import SDGMenuBar

  /// See Application.prepareForMain()
  internal var permanentNSApplicationDelegateStorage: NSObject?

  internal class NSApplicationDelegate<Application>: NSObject, AppKit.NSApplicationDelegate,
    _NSApplicationDelegateProtocol, NSMenuItemValidation
  where Application: SDGApplication.Application {

    // MARK: - Initialization

    internal init(application: Application) {
      self.application = application
    }

    // MARK: - Properties

    private let application: Application

    // MARK: - Top Responder

    @objc internal func openPreferences(_ sender: Any?) {
      application.preferenceManager?.openPreferences()
    }

    // MARK: - NSApplicationDelegate

    internal func applicationWillFinishLaunching(_ notification: Notification) {
      var system = SystemNotification()
      system.foundation = notification
      var details = LaunchDetails()
      details.notification = system
      _ = application.prepareToLaunch(details)
    }

    internal func applicationDidFinishLaunching(_ notification: Notification) {

      application.performPostLaunchSetUp()

      var system = SystemNotification()
      system.foundation = notification
      var details = LaunchDetails()
      details.notification = system
      _ = application.finishLaunching(details)
    }

    internal func applicationWillBecomeActive(_ notification: Notification) {
      var system = SystemNotification()
      system.foundation = notification
      application.prepareToAcquireFocus(system)
    }

    internal func applicationDidBecomeActive(_ notification: Notification) {
      var system = SystemNotification()
      system.foundation = notification
      application.finishAcquiringFocus(system)
    }

    internal func applicationWillResignActive(_ notification: Notification) {
      var system = SystemNotification()
      system.foundation = notification
      application.prepareToResignFocus(system)
    }

    internal func applicationDidResignActive(_ notification: Notification) {
      var system = SystemNotification()
      system.foundation = notification
      application.finishResigningFocus(system)
    }

    internal func applicationShouldTerminate(
      _ sender: NSApplication
    ) -> NSApplication.TerminateReply {
      return application.terminate().cocoa
    }

    internal func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
      return ¬application.remainsRunningWithNoWindows
    }

    internal func applicationWillTerminate(_ notification: Notification) {
      var system = SystemNotification()
      system.foundation = notification
      application.prepareToTerminate(system)
    }

    internal func applicationWillHide(_ notification: Notification) {
      var system = SystemNotification()
      system.foundation = notification
      application.prepareToHide(system)
    }

    internal func applicationDidHide(_ notification: Notification) {
      var system = SystemNotification()
      system.foundation = notification
      application.finishHiding(system)
    }

    internal func applicationWillUnhide(_ notification: Notification) {
      var system = SystemNotification()
      system.foundation = notification
      application.prepareToUnhide(system)
    }

    internal func applicationDidUnhide(_ notification: Notification) {
      var system = SystemNotification()
      system.foundation = notification
      application.finishUnhiding(system)
    }

    internal func applicationWillUpdate(_ notification: Notification) {
      var system = SystemNotification()
      system.foundation = notification
      application.prepareToUpdateInterface(system)
    }

    internal func applicationDidUpdate(_ notification: Notification) {
      var system = SystemNotification()
      system.foundation = notification
      application.finishUpdatingInterface(system)
    }

    internal func applicationShouldHandleReopen(
      _ sender: NSApplication,
      hasVisibleWindows flag: Bool
    ) -> Bool {
      return ¬application.reopen(hasVisibleWindows: flag)
    }

    internal func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
      return application.dockMenu?.cocoa()
    }

    internal func application(_ application: NSApplication, willPresentError error: Error) -> Error
    {
      return self.application.preprocessErrorForDisplay(error)
    }

    internal func applicationDidChangeScreenParameters(_ notification: Notification) {
      var system = SystemNotification()
      system.foundation = notification
      application.updateAccordingToScreenChange(system)
    }

    internal func application(
      _ application: NSApplication,
      willContinueUserActivityWithType userActivityType: String
    ) -> Bool {
      return self.application.notifyHandoffBegan(userActivityType)
    }

    internal func application(
      _ application: NSApplication,
      continue userActivity: NSUserActivity,
      restorationHandler: @escaping ([NSUserActivityRestoring]) -> Void
    ) -> Bool {
      var handoff = Handoff()
      handoff.activity = userActivity
      var details = HandoffAcceptanceDetails()
      details.restorationHandler = restorationHandler
      return self.application.accept(handoff: handoff, details: details)
    }

    internal func application(_ application: NSApplication, didUpdate userActivity: NSUserActivity)
    {
      var handoff = Handoff()
      handoff.activity = userActivity
      self.application.preprocess(handoff: handoff)
    }

    internal func application(
      _ application: NSApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
      self.application.finishRegistrationForRemoteNotifications(
        deviceToken: deviceToken
      )
    }

    internal func application(
      _ application: NSApplication,
      didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
      self.application.reportFailedRegistrationForRemoteNotifications(
        error: error
      )
    }

    internal func application(
      _ application: NSApplication,
      didReceiveRemoteNotification userInfo: [String: Any]
    ) {
      var details = RemoteNotificationDetails()
      details.userInformation = userInfo
      _ = self.application.acceptRemoteNotification(
        details: details
      )
    }

    internal func application(_ application: NSApplication, open urls: [URL]) {
      var details = OpeningDetails()
      details.withoutUserInterface = false
      details.asTemporaryFile = false
      _ = self.application.open(
        files: urls,
        details: details
      )
    }

    internal func application(_ sender: Any, openFileWithoutUI filename: String) -> Bool {
      var details = OpeningDetails()
      details.withoutUserInterface = true
      details.asTemporaryFile = false
      return application.open(
        files: [URL(fileURLWithPath: filename)],
        details: details
      )
    }

    internal func application(_ sender: NSApplication, openTempFile filename: String) -> Bool {
      var details = OpeningDetails()
      details.withoutUserInterface = false
      details.asTemporaryFile = true
      return application.open(
        files: [URL(fileURLWithPath: filename)],
        details: details
      )
    }

    internal func applicationOpenUntitledFile(_ sender: NSApplication) -> Bool {
      return application.createNewBlankFile()
    }

    internal func applicationShouldOpenUntitledFile(_ sender: NSApplication) -> Bool {
      return application.shouldCreateNewBlankFile()
    }

    internal func application(
      _ application: NSApplication,
      printFiles fileNames: [String],
      withSettings printSettings: [NSPrintInfo.AttributeKey: Any],
      showPrintPanels: Bool
    ) -> NSApplication.PrintReply {
      var details = PrintingDetails()
      details.settings = printSettings
      details.displayPanels = showPrintPanels
      let result =
        self.application.print(
          files: fileNames.map({ URL(fileURLWithPath: $0) }),
          details: details
        )
      return result.cocoa
    }

    internal func application(_ app: NSApplication, didDecodeRestorableState coder: NSCoder) {
      application.finishRestoring(coder: coder)
    }

    internal func application(_ app: NSApplication, willEncodeRestorableState coder: NSCoder) {
      application.prepareToEncodeRestorableState(coder: coder)
    }

    internal func applicationDidChangeOcclusionState(_ notification: Notification) {
      var system = SystemNotification()
      system.foundation = notification
      application.updateAccordingToOcclusionChange(system)
    }

    // MARK: - NSMenuItemValidation

    internal func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
      if menuItem.action == #selector(NSApplicationDelegate.openPreferences(_:)),
        application.preferenceManager == nil
      {
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
