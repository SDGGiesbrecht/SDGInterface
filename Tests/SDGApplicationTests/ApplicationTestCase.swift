/*
 ApplicationTestCase.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGXCTestUtilities

import SDGInterfaceSample

class ApplicationTestCase : TestCase {

    override func setUp() {
        super.setUp()
        launch
    }
    let launch: Void = {
        let mediator = getSystemMediator()
        Application.setUpWithoutMain(mediator: mediator)
        Application.setUp()
        #if canImport(AppKit)
        _ = mediator.finishLaunching(LaunchDetails())
        #elseif canImport(UIKit)
        _ = mediator.application(Application.shared)
        #endif
    }()
}
