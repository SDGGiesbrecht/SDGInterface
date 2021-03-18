/*
 SwiftUIApplication.swift

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

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(macOS 11, tvOS 14, iOS 14, watchOS 7, *)
  internal struct SwiftUIApplication<Application>: App
  where Application: LegacyApplication, Application.MenuBarType: MenuBarProtocol {

    #if canImport(AppKit)
      @NSApplicationDelegateAdaptor(NSApplicationDelegate<Application>.self) var applicationDelegate
    #endif

    #if canImport(UIKit)
      @UIApplicationDelegateAdaptor(UIApplicationDelegate<Application>.self) var applicationDelegate
    #endif

    // MARK: - Properties

    private let application: Application

    // MARK: - App

    internal init() {
      application = Application()
    }

    internal var body: some Scene {
      #warning("Not customized.")
      let scene = WindowGroup {
      }
      #if os(tvOS) || os(watchOS)
        return scene
      #else
        return scene.commands {
          application.menuBar.swiftUI()
        }
      #endif
    }
  }
#endif
