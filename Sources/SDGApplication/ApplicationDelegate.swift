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
// [_Define Documentation: SDGInterface.ApplicationDelegate_]
/// An alias for `NSApplicationDelegate` or `UIApplicationDelegate`.
public typealias ApplicationDelegate = NSApplicationDelegate
#elseif canImport(UIKit)
// [_Inherit Documentation: SDGInterface.ApplicationDelegate_]
/// An alias for `NSApplicationDelegate` or `UIApplicationDelegate`.
public typealias ApplicationDelegate = UIApplicationDelegate
#endif

extension ApplicationDelegate {

    /// Starts the application’s main run loop.
    public func main() -> Never {
        Application.shared.delegate = self
        #if canImport(AppKit)
        exit(NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv))
        #elseif canImport(UIKit)
        exit(UIApplicationMain(CommandLine.argc, UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)), nil, nil))
        #endif
    }
}

// Permanent strong storage for the delegate.
private var mainDelegate: ApplicationDelegate?

#endif
