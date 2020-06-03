/*
 InternalTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

@testable import SDGButtons

import SDGInterfaceLocalizations

import SDGApplicationTestUtilities

final class InternalTests: ApplicationTestCase {

  func testButtonCocoaImplementation() {
    #if canImport(AppKit) || canImport(UIKit)
      let button = Button(
        label: UserFacing<StrictString, InterfaceLocalization>({ _ in "Button" }),
        action: {}
      )
      legacyMode = true
      defer { legacyMode = false }
      let cocoa = button.cocoa().native as! Button.Superclass
      #if canImport(AppKit)
        cocoa.sendAction(cocoa.action, to: cocoa.target)
      #else
        cocoa.sendActions(for: .primaryActionTriggered)
      #endif
    #endif
  }
}
