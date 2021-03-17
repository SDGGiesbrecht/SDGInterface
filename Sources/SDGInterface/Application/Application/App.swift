/*
 App.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

@available(macOS 11, *)
internal struct SwiftUIApplication<Application>: App
where Application: SDGInterface.Application {

  // MARK: - Properties

  private let application: Application

  // MARK: - App

  internal init() {
    application = Application()
  }

  internal var body: some Scene {
    #warning("Not customized.")
    WindowGroup {
    }
    .commands {
      application.menuBar.swiftUI()
    }
  }
}
