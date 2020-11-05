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

import SDGLogic

import SDGContextMenu
import SDGMenuBar

/// A type that represents an application.
///
/// Create an application by declaring a structure that conforms to the `Application` protocol.
public protocol Application: SystemInterface {

  /// Creates an application.
  init()

  #warning("Integrate this?")
  /// Returns the object which manages the application’s preferences.
  func preferenceManager() -> PreferenceManager?
}

extension Application {

  // MARK: - Launching

  @discardableResult private static func prepareForMain() -> Self {
    let application = Self()
    #if canImport(AppKit)
      NSApplication.shared.delegate = application.cocoaDelegate()
    #endif
    return application
  }

  #if !os(watchOS)
    // #workaround(Swift 5.3, Web doesn’t have Foundation yet.)
    #if !os(WASI)
      /// Initializes and runs the application.
      public static func main() -> Never {  // @exempt(from: tests)
        let application = prepareForMain()
        withExtendedLifetime(application) {
          #if canImport(AppKit)
            exit(NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv))
          #elseif canImport(UIKit)
            exit(
              UIApplicationMain(
                CommandLine.argc,
                CommandLine.unsafeArgv,
                nil,
                NSStringFromClass(UIApplicationDelegate.self)
              )
            )
          #else
            while true {
              RunLoop.current.run()
            }
          #endif
        }
      }
    #endif
  #endif

  internal func performPostLaunchSetUp() {
    #if canImport(UIKit) && !os(tvOS) && !os(watchOS)
      UIMenuController.shared.menuItems = ContextMenu().cocoa()
      UIMenuController.shared.update()
    #endif

    #if canImport(AppKit)
      let menuBar = self.menuBar.cocoa()
      NSApplication.shared.mainMenu = menuBar
      NSApplication.shared.servicesMenu =
        menuBar.items.first?.submenu?.items.first(where: { $0.submenu ≠ nil })?.submenu
      NSApplication.shared.windowsMenu = menuBar.items.dropLast().last?.submenu
      NSApplication.shared.helpMenu = menuBar.items.last?.submenu
    #endif

    #if canImport(AppKit)
      NSApplication.shared.activate(ignoringOtherApps: false)
    #endif
  }

  /// Preforms the same preparatory actions taken by `main()`, but without triggering the system’s main loop.
  ///
  /// This method can set up a portion of the application when helpful for tests, but it should only be called once. Do not call it separately before `main()`.
  public static func setUpWithoutMain() {
    let application = prepareForMain()
    _ = application.prepareToLaunch(LaunchDetails())
    application.performPostLaunchSetUp()
    _ = application.finishLaunching(LaunchDetails())
  }

  // MARK: - Cocoa

  #if canImport(AppKit)
    private func cocoaDelegate() -> NSApplicationDelegate {
      return NSApplicationDelegate(self)
    }
  #elseif canImport(UIKit) && !os(watchOS)
    private func cocoaDelegate() -> UIApplicationDelegate {
      return UIApplicationDelegate(self)
    }
  #endif
}
