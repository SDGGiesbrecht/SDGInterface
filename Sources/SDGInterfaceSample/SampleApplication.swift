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
