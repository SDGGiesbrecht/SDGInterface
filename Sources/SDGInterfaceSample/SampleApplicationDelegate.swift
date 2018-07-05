/*
 SampleApplicationDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)
// MARK: - #if !os(watchOS)

// [_Define Example: sample_]
public final class SampleApplicationDelegate : ApplicationDelegate {

    public override func applicationDidFinishLaunching() {
        super.applicationDidFinishLaunching()

        print("Hello, world!")
    }
}
// [_End_]

#endif
