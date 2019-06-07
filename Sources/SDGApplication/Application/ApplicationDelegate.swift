/*
 ApplicationDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

import SDGLogic

#if canImport(AppKit)
public typealias _ApplicationDelegate = AppKit.NSApplicationDelegate
#elseif canImport(UIKit)
public typealias _ApplicationDelegate = UIKit.UIApplicationDelegate
#endif

/// An application delegate.
///
/// This inherits from `NSApplicationDelegate` or `UIApplicationDelegate`, and provides several additional API unifications.
open class ApplicationDelegate : NSObject, _ApplicationDelegate {

    // MARK: - NSApplicationDelegate & UIApplicationDelegate

    #if canImport(UIKit)
    /// Tells the delegate that the launch process is almost done and the application is almost ready to run.
    ///
    /// - Parameters:
    ///     - application: The application object.
    ///     - launchOptions: A dictionary indicating the reason the application was launched.

    #endif
}
#endif

#if canImport(AppKit)
extension ApplicationDelegate : NSMenuItemValidation {

    /// Implemented to override the default action of enabling or disabling a specific menu item.
    ///
    /// - Parameters:
    ///     - menuItem: The menu item.
    open func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
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
