/*
 ApplicationTestCase.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGInterface

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

open class ApplicationTestCase: TestCase {

  open override func setUp() {
    super.setUp()
    ApplicationTestCase.launch
  }
  private static let launch: Void = {
    #if !PLATFORM_LACKS_FOUNDATION_PROCESS_INFO
      if #available(watchOS 6, *) {
        let application = SampleApplication.setUpWithoutMain()
        #if canImport(AppKit) || canImport(UIKit)
          _ = application.finishLaunching(LaunchDetails())
        #endif
      }
    #endif
  }()

  open override func tearDown() {
    #if PLATFORM_HAS_COCOA_INTERFACE
      forEachWindow { window in
        window.close()
      }
      forEachWindow { window in  // @exempt(from: tests)
        #if canImport(AppKit)  // @exempt(from: tests)
          XCTAssert(false, "Failed to tear down window: \(window.native.title)")
        #else
          XCTAssert(false, "Failed to tear down window: \(window.native)")
        #endif
      }
    #endif
  }
}
