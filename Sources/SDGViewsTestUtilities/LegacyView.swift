/*
 LegacyView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGViews

import SDGTesting

/// Tests a type’s conformance to LegacyView.
///
/// - Parameters:
///     - view: A view.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testLegacyViewConformance<T>(
  of view: T,
  file: StaticString = #file,
  line: UInt = #line
) where T: BidirectionalCollection {

}
