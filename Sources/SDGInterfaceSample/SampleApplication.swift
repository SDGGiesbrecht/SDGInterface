/*
 SampleApplication.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMenuBar

// @example(application)
import SDGText
import SDGLocalization

import SDGTextDisplay
import SDGWindows
import SDGApplication

#warning("Rename file?")
internal struct SampleApplication: SDGApplication.Application {

  internal func finishLaunching(_ details: LaunchDetails) -> Bool {
    let helloWorld = UserFacing<StrictString, AnyLocalization>({ _ in "Hello, world!" })
    Window(
      type: .auxiliary(nil),
      name: helloWorld,
      content: Label(helloWorld)
    ).display()
    #warning("Should be moved below? Is this important for tests?")
    // Application.setSamplesUp()
    return true
  }
}
// @endExample

extension SampleApplication {

  // MARK: - Application

  internal var preferenceManager: SDGApplication.PreferenceManager? {
    return PreferenceManager()
  }

  // MARK: - SystemInterface

  #if canImport(AppKit)
    internal var menuBar: MenuBar {
      return MenuBar(applicationSpecificSubmenus: [
        MenuBar.sample()
      ])
    }
  #endif

  internal var remainsRunningWithNoWindows: Bool {  // @exempt(from: tests)
    return true
  }
}
