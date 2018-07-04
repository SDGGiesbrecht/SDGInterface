/*
 ApplicationDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
/// A platform‐indepented alias for `NSApplicationDelegate`.
public typealias ApplicationDelegate = NSApplicationDelegate
#endif

extension ApplicationDelegate {

    /// Starts the application’s main run loop.
    public func main() -> Never {
        autoreleasepool {
            mainDelegate = self

            let application = Application.shared

            application.delegate = self
            application.run()
        }
        exit(0)
    }
}

// Permanent strong storage for the delegate.
private var mainDelegate: ApplicationDelegate?
