/*
 Application.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The application.
public final class Application {

    // MARK: - Static Properties

    /// The application.
    public static let shared = Application()

    // MARK: - Initialization

    private init() {
        #if canImport(AppKit)
        nativeDelegate = NSApplicationDelegate()
        #elseif canImport(UIKit)
        nativeDelegate = UIApplicationDelegate()
        #endif
    }

    // MARK: - Properties

    #if canImport(AppKit)
    private var nativeDelegate: NSApplicationDelegate
    #elseif canImport(UIKit)
    private var nativeDelegate: UIApplicationDelegate
    #endif

    internal var systemMediator: SystemMediator?

    // MARK: - Launching

    /// Starts the application’s main run loop.
    public class func main(mediator: SystemMediator) -> Never { // @exempt(from: tests)
        Application.shared.systemMediator = mediator
        #if canImport(AppKit)
        NSApplication.shared.delegate = shared.nativeDelegate
        exit(NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv))
        #elseif canImport(UIKit)
        exit(UIApplicationMain(
            CommandLine.argc,
            CommandLine.unsafeArgv,
            nil,
            NSStringFromClass(UIApplicationDelegate.self)))
        #endif
    }
}
