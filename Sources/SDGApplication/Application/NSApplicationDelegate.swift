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
internal class NSApplicationDelegate: NSObject, AppKit.NSApplicationDelegate {

    // MARK: - Top Responder

    @objc internal func openPreferences(_ sender: Any?) {
        Application.shared.preferenceManager?.openPreferences()
    }

    // MARK: - NSApplicationDelegate

    internal func applicationWillFinishLaunching(_ notification: Notification) {
        Application.shared.systemMediator?.applicationWillLaunch(LaunchDetails(notification: notification))
    }

    internal func applicationDidFinishLaunching(_ notification: Notification) {

        NSApplication.shared.menu = MenuBar.menuBar
        NSApplication.shared.activate(ignoringOtherApps: false)

        _ = Application.shared.systemMediator?.applicationDidLaunch(LaunchDetails(notification: notification))
    }
    #warning("Fill out this list.")
}
#endif
