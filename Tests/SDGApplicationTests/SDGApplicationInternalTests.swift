/*
 SDGApplicationInternalTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGLogic
import SDGXCTestUtilities

@testable import SDGApplication
import SDGInterface
import SDGInterfaceLocalizations
import SDGInterfaceSample

final class SDGApplicationInternalTests : ApplicationTestCase {

    func testApplicationName() {
        let isolated = ApplicationNameForm.isolatedForm
        for localization in MenuBarLocalization.allCases {
            LocalizationSetting(orderOfPrecedence: [localization.code]).do {
                _ = isolated.resolved()
            }
        }
    }
}
