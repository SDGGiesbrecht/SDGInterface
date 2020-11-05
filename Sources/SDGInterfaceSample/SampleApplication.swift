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
import Foundation

import SDGText
import SDGLocalization

import SDGTextDisplay
import SDGWindows
import SDGApplication

internal struct SampleApplication: SDGApplication.Application {

  internal var applicationName: ProcessInfo.ApplicationNameResolver {
    return { form in
      switch form {
      case .english(let region):
        switch region {
        case .unitedKingdom, .unitedStates, .canada:
          return "Sample"
        }
      case .español(let preposición):
        switch preposición {
        case .ninguna:
          return "Ejemplar"
        case .de:
          return "del Ejemplar"
        }
      case .deutsch(let fall):
        switch fall {
        case .nominativ, .akkusativ, .dativ:
          return "Beispiel"
        }
      case .français(let préposition):
        switch préposition {
        case .aucune:
          return "Exemple"
        case .de:
          return "de l’Exemple"
        }

      case .ελληνικά(let πτώση):
        switch πτώση {
        case .ονομαστική:
          return "Παράδειγμα"
        case .αιτιατική:
          return "το Παράδειγμα"
        case .γενική:
          return "του Παραδείγματος"
        }
      case .עברית:
        return "דוגמה"
      }
    }
  }

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

public func setUpForTests() {
  let application = SampleApplication.setUpWithoutMain()
  #if canImport(AppKit) || canImport(UIKit)
    _ = application.finishLaunching(LaunchDetails())
  #endif
}
