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
        Application.shared.systemMediator?.applicationWillLaunch(LaunchDetails(notification: notification))
    }

    internal func applicationDidFinishLaunching(_ notification: Notification) {

        NSApplication.shared.menu = MenuBar.menuBar
        NSApplication.shared.activate(ignoringOtherApps: false)

        _ = Application.shared.systemMediator?.applicationDidLaunch(LaunchDetails(notification: notification))
    }
    #warning("Fill out this list.")

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
