/*
 SwiftUIApplication.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGLogic

#if canImport(SwiftUI)
  @available(macOS 11, tvOS 14, iOS 14, watchOS 7, *)
  internal struct SwiftUIApplication<Application>: App
  where
    Application: LegacyApplication,
    Application.MenuBarType: MenuBarProtocol,
    Application.MainWindow: WindowProtocol,
    Application.Preferences: View
  {

    #if canImport(AppKit)
      @NSApplicationDelegateAdaptor(NSApplicationDelegate<Application>.self) internal
        var applicationDelegate
    #endif

    #if canImport(UIKit) && !os(watchOS)
      @UIApplicationDelegateAdaptor(  // @exempt(from: tests)
        UIApplicationDelegate<Application>.self
      ) internal var applicationDelegate
    #endif

    // MARK: - Properties

    private let application: Application

    // MARK: - App

    internal init() {
      application = Application()
    }

    @SceneBuilder private var windows: some Scene {

      application.mainWindow.swiftUI()

      #if os(macOS)
        let preferences = application.preferences
        Settings {
          if ¬(preferences is EmptyView) {
            preferences.swiftUI()
              .padding()
          }
        }
      #endif
    }
    internal var body: some Scene {
      #if os(tvOS) || os(watchOS)
        windows
      #else
        windows.commands {
          application.menuBar.swiftUI()
        }
      #endif
    }
  }
#endif
