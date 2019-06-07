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
    internal func applicationWillFinishLaunching(_ notification: Notification) {
        Application.shared.systemMediator?.applicationWillLaunch(SystemEventDetails(notification: notification))
    }
    internal func applicationDidFinishLaunching(_ notification: Notification) {

        NSApplication.shared.menu = MenuBar.menuBar
        NSApplication.shared.activate(ignoringOtherApps: false)

        Application.shared.systemMediator?.applicationDidLaunch(SystemEventDetails(notification: notification))
    }
    #warning("Fill out this list.")
}
#endif
