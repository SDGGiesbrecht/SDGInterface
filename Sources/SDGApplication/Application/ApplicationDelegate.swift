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

#if canImport(AppKit)
public typealias _ApplicationDelegate = AppKit.NSApplicationDelegate
#elseif canImport(UIKit)
public typealias _ApplicationDelegate = UIKit.UIApplicationDelegate
#endif

/// An application delegate.
///
/// This inherits from `NSApplicationDelegate` or `UIApplicationDelegate`, and provides several additional API unifications.
open class ApplicationDelegate : NSObject, _ApplicationDelegate {

    // MARK: - Preferences

    /// This action method opens the application preferences. Override it to provide an implementation for the “Preferences...” menu item, which is otherwise hidden.
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc open func openPreferences(_ sender: Any?) {}

    // MARK: - NSApplicationDelegate & UIApplicationDelegate

    #if canImport(UIKit)
    /// Tells the delegate that the launch process is almost done and the application is almost ready to run.
    ///
    /// - Parameters:
    ///     - application: The application object.
    ///     - launchOptions: A dictionary indicating the reason the application was launched.
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        #warning("No longer connected.")
        return true
    }
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
        let openPreferencesSelector = #selector(ApplicationDelegate.openPreferences)
        if menuItem.action == openPreferencesSelector,
            method(for: openPreferencesSelector) == ApplicationDelegate.instanceMethod(for: openPreferencesSelector) {
            // Primitive method not overridden.
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
