/*
 Service.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGInterface

final class ServiceExample: Service {

  // MARK: - Service

  init() {}

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS_INFO
    var applicationName: ProcessInfo.ApplicationNameResolver {
      return { _ in "..." }
    }
  #endif

  #if PLATFORM_LACKS_FOUNDATION_RUN_LOOP
    static func main() {}
  #endif
}
