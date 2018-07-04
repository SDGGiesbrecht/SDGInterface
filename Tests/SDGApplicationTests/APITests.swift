/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGXCTestUtilities

import SDGInterface

final class SDGApplicationAPITests : XCTestCase {

    func testApplicationDelegate() {
        let delegate = ApplicationDelegate()
        #if canImport(AppKit)
        delegate.applicationDidFinishLaunching(Notification(name: Application.didFinishLaunchingNotification))
        #elseif canImport(UIKit)
        _ = delegate.application(Application.shared)
        #endif
    }
}
