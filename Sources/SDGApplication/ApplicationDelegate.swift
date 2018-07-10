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
// MARK: - #if !os(watchOS)

#if canImport(AppKit)
// MARK: - #if canImport(AppKit)
/// :nodoc:
public typealias _ApplicationDelegate = NSApplicationDelegate
#elseif canImport(UIKit)
// MARK: - #elseif canImport(UIKit)
/// :nodoc:
public typealias _ApplicationDelegate = UIApplicationDelegate
#endif

/// An application delegate.
///
/// This inherits from `NSApplicationDelegate` or `UIApplicationDelegate`, and provides several additional API unifications.
open class ApplicationDelegate : NSObject, _ApplicationDelegate {

    // MARK: - Initialization

    /// Creates an application delegate.
    public required override init() { // [_Exempt from Test Coverage_] False coverage result in Xcode 9.4.1.
        super.init()
    }

    // MARK: - Launching

    /// Notifies the delegate that the application has been launched and initialized.
    ///
    /// This is a unification of `applicationDidFinishLaunching(:)` and `application(_:, didFinishLaunchingWithOptions:) -> Bool`. The default implementations of each redirect to this method.
    open func applicationDidFinishLaunching() {
        NSApplication.shared.activate(ignoringOtherApps: false)
    }
}

extension ApplicationDelegate {

    // Permanent strong storage for the delegate.
    private static var mainDelegate: ApplicationDelegate?
    /// Starts the application’s main run loop.
    public class func main() -> Never { // [_Exempt from Test Coverage_]
        #if canImport(AppKit)
        let delegate = self.init()
        mainDelegate = delegate
        Application.shared.delegate = delegate
        exit(NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv))
        #elseif canImport(UIKit)
        exit(UIApplicationMain(CommandLine.argc, UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)), nil, NSStringFromClass(self)))
        #endif
    }
}

#if canImport(AppKit)
extension ApplicationDelegate {

    /// Sent by the default notification center after the application has been launched and initialized but before it has received its first event.
    open func applicationDidFinishLaunching(_ notification: Notification) {
        applicationDidFinishLaunching()
    }
}
#elseif canImport(UIKit)
extension ApplicationDelegate {

    /// Tells the delegate that the launch process is almost done and the application is almost ready to run.
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        applicationDidFinishLaunching()
        return true
    }
}
#endif

#endif
