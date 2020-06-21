/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGImageDisplay
import SDGApplication

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests: ApplicationTestCase {

  func testCocoaImage() {
    #if canImport(AppKit) || canImport(UIKit)
      var image = CocoaImage()
      let native = CocoaImage.NativeType()
      image.native = native
      _ = image.native
    #endif
  }

  func testImage() {
    #if canImport(AppKit) || canImport(UIKit)
      Application.shared.demonstrateImage()

      #if canImport(SwiftUI)
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          let swiftUI = SwiftUI.Image(CocoaImage())
          let image = Image(swiftUI)
          _ = image.swiftUI()
          _ = image.cocoaImage()
        }
      #endif
    #endif
  }
}
