/*
 SystemMediator.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public func getSystemMediator() -> SDGApplication.SystemMediator {
  return SystemMediator()
}

// @example(mediator)
import SDGApplication

internal class SystemMediator: SDGApplication.SystemMediator {

  internal func finishLaunching(_ details: LaunchDetails) -> Bool {
    Application.setSamplesUp()
    return true
  }
}
// @endExample

extension SystemMediator {

  internal var remainsRunningWithNoWindows: Bool {  // @exempt(from: tests)
    return true
  }
}
