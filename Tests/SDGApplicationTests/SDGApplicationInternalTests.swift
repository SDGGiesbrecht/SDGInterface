/*
 SDGApplicationInternalTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGLogic
import SDGXCTestUtilities

@testable import SDGApplication
import SDGInterface
import SDGInterfaceLocalizations
import SDGInterfaceSample

final class SDGApplicationInternalTests : ApplicationTestCase {

    func testApplicationName() {
        let previous = ProcessInfo.applicationName
        func testAllLocalizations() {
            defer {
                ProcessInfo.applicationName = previous
            }
            let isolated = ApplicationNameForm.localizedIsolatedForm
            for localization in MenuBarLocalization.allCases {
                LocalizationSetting(orderOfPrecedence: [localization.code]).do {
                    _ = isolated.resolved()
                }
            }
        }
        testAllLocalizations()

        ProcessInfo.applicationName = { form in
            switch form {
            case .english(.canada):
                return "..."
            default:
                return nil
            }
        }
        testAllLocalizations()
    }

    func testUIApplicationDelegate() {
        struct Error: Swift.Error {}
        #if canImport(UIKit)
        let delegate = SDGApplication.UIApplicationDelegate()
        _ = delegate.application(UIApplication.shared, willFinishLaunchingWithOptions: nil)
        _ = delegate.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        delegate.applicationDidBecomeActive(UIApplication.shared)
        delegate.applicationWillResignActive(UIApplication.shared)
        delegate.applicationDidEnterBackground(UIApplication.shared)
        delegate.applicationWillEnterForeground(UIApplication.shared)
        delegate.applicationWillTerminate(UIApplication.shared)
        delegate.applicationProtectedDataDidBecomeAvailable(UIApplication.shared)
        delegate.applicationProtectedDataWillBecomeUnavailable(UIApplication.shared)
        delegate.applicationDidReceiveMemoryWarning(UIApplication.shared)
        delegate.applicationSignificantTimeChange(UIApplication.shared)
        _ = delegate.application(UIApplication.shared, shouldSaveApplicationState: NSCoder())
        _ = delegate.application(UIApplication.shared, shouldRestoreApplicationState: NSCoder())
        _ = delegate.application(
            UIApplication.shared,
            viewControllerWithRestorationIdentifierPath: [],
            coder: NSCoder())
        delegate.application(UIApplication.shared, willEncodeRestorableStateWith: NSCoder())
        delegate.application(UIApplication.shared, didDecodeRestorableStateWith: NSCoder())
        delegate.application(UIApplication.shared, handleEventsForBackgroundURLSession: "", completionHandler: {})
        delegate.application(UIApplication.shared, didRegisterForRemoteNotificationsWithDeviceToken: Data())
        delegate.application(UIApplication.shared, didFailToRegisterForRemoteNotificationsWithError: Error())
        delegate.application(
            UIApplication.shared,
            didReceiveRemoteNotification: [:],
            fetchCompletionHandler: { _ in })
        _ = delegate.application(UIApplication.shared, willContinueUserActivityWithType: "")
        _ = delegate.application(UIApplication.shared, continue: NSUserActivity(activityType: " "), restorationHandler: { _ in })
        delegate.application(UIApplication.shared, didUpdate: NSUserActivity(activityType: " "))
        #if !os(tvOS)
        delegate.application(
            UIApplication.shared,
            performActionFor: UIApplicationShortcutItem(type: "", localizedTitle: ""),
            completionHandler: { _ in })
        #endif
        delegate.application(UIApplication.shared, handleWatchKitExtensionRequest: nil, reply: { _ in })
        delegate.applicationShouldRequestHealthAuthorization(UIApplication.shared)
        _ = delegate.application(UIApplication.shared, open: URL(fileURLWithPath: ""))
        _ = delegate.application(UIApplication.shared, shouldAllowExtensionPointIdentifier: UIApplication.ExtensionPointIdentifier(rawValue: ""))
        #endif
    }
}
