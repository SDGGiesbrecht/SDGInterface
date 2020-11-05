/*
 Application.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3, Web doesn’t have Foundation yet.)
#if !os(WASI)
  import Foundation
#endif
#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGText
import SDGLocalization

import SDGInterfaceBasics
import SDGViews
import SDGTextDisplay
import SDGImageDisplay
import SDGButtons
import SDGWindows
import SDGErrorMessages
import SDGMenuBar
import SDGApplication

#warning("Moved to other file?")
extension SampleApplication {

  #if !os(watchOS)
    // #workaround(Swift 5.3, Web doesn’t have Foundation yet.)
    #if !os(WASI)
      public static func setUpAndMain() -> Never {  // @exempt(from: tests)
        #warning("This example needs to be moved.")
        // @example(main)
        SampleApplication.main()
        // @endExample
      }
    #endif
  #endif

  internal func setSamplesUp() {
    setMenuUp()
  }

  #warning("This probably doesn’t belong here.")
  private func setMenuUp() {
    #if canImport(UIKit) && !os(tvOS) && !os(watchOS)
      let editor = TextEditor(contents: Shared(RichText()))
      let window = Window(
        type: .primary(nil),
        name: ApplicationNameForm.localizedIsolatedForm,
        content: editor.cocoa()
      )
      if ProcessInfo.processInfo
        .environment["XCTestConfigurationFilePath"] == nil
      {  // #exempt(from: tests)
        // This call fails during tests.
        window.display()
      }
    #endif
  }
}
