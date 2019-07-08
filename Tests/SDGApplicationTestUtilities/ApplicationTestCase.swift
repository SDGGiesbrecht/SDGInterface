/*
 ApplicationTestCase.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(XCTest) && (!(os(iOS) || os(watchOS) || os(tvOS)) || targetEnvironment(simulator)) // XCTest does not contain bitcode.

import Foundation

import SDGApplication

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

open class ApplicationTestCase : TestCase {

    open override func setUp() {
        super.setUp()
        ApplicationTestCase.launch
    }
    static let launch: Void = {
        Application.setUp()
        let mediator = getSystemMediator()
        Application.setUpWithoutMain(mediator: mediator)
        #if canImport(AppKit)
        _ = mediator.finishLaunching(LaunchDetails())
        #elseif canImport(UIKit)
        _ = mediator.finishLaunching(LaunchDetails())
        #endif
    }()

    override func tearDown() {
        #if canImport(AppKit) || canImport(UIKit)
        forEachWindow { window in
            window.close()
        }
        #endif
    }
}

#endif
