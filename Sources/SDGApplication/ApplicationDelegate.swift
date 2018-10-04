/*
 ApplicationDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

#if canImport(AppKit)
public typealias _ApplicationDelegate = NSApplicationDelegate
#elseif canImport(UIKit)
public typealias _ApplicationDelegate = UIApplicationDelegate
#endif

/// An application delegate.
///
/// This inherits from `NSApplicationDelegate` or `UIApplicationDelegate`, and provides several additional API unifications.
open class ApplicationDelegate : NSObject, _ApplicationDelegate {

    // MARK: - Class Methods

    // Permanent strong storage for the delegate.
    private static var mainDelegate: ApplicationDelegate?
    /// Starts the application’s main run loop.
    public class func main() -> Never { // @exempt(from: tests)
        #if canImport(AppKit)
        let delegate = self.init()
        mainDelegate = delegate
        Application.shared.delegate = delegate
        exit(NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv))
        #elseif canImport(UIKit)
        exit(UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(self)))
        #endif
    }

    // MARK: - Initialization

    /// Creates an application delegate.
    public required override init() { // @exempt(from: tests) False coverage result in Xcode 9.4.1.
        super.init()
    }

    // MARK: - Launching

    /// Notifies the delegate that the application has been launched and initialized.
    ///
    /// This is a unification of `applicationDidFinishLaunching(:)` and `application(_:, didFinishLaunchingWithOptions:) -> Bool`. The default implementations of each redirect to this method.
    open func applicationDidFinishLaunching() {
        #if canImport(AppKit)
        Application.shared.menu = MenuBar.menuBar
        Application.shared.activate(ignoringOtherApps: false)
        #endif
    }

    // MARK: - Preferences

    /// This action method opens the application preferences. Override it to provide an implementation for the “Preferences...” menu item, which is otherwise hidden.
    @objc open func openPreferences(_ sender: Any?) {}

    // MARK: - NSApplicationDelegate & UIApplicationDelegate

    #if canImport(AppKit)
    /// Sent by the default notification center after the application has been launched and initialized but before it has received its first event.
    open func applicationDidFinishLaunching(_ notification: Notification) {
        applicationDidFinishLaunching()
    }
    #elseif canImport(UIKit)
    /// Tells the delegate that the launch process is almost done and the application is almost ready to run.
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        applicationDidFinishLaunching()
        return true
    }
    #endif
}
#endif

#if canImport(AppKit)
extension ApplicationDelegate : NSMenuItemValidation {

    /// Implemented to override the default action of enabling or disabling a specific menu item.
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
