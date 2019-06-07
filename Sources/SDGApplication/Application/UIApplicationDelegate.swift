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

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UIMenuController.shared.extend()
        return Application.shared.systemMediator?.applicationDidLaunch(
            LaunchDetails(options: launchOptions)) ?? false
    }
}
#endif
