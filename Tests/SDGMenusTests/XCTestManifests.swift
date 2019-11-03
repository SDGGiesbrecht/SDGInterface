/*
 XCTestManifests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !canImport(ObjectiveC)
import XCTest

extension APITests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__APITests = [
        ("testKeyModifiers", testKeyModifiers),
        ("testMenu", testMenu),
        ("testMenuComponent", testMenuComponent),
        ("testMenuEntry", testMenuEntry),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(APITests.__allTests__APITests),
    ]
}
#endif
