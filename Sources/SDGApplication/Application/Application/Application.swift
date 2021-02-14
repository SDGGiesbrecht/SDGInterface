/*
 Application.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

import SDGLogic

import SDGInterface
import SDGContextMenu
import SDGMenuBar

/// A type that represents an application.
///
/// Create an application by declaring a structure that conforms to the `Application` protocol.
public protocol Application: SystemInterface {

  /// Creates an application.
  init()

  // #workaround(Swift 5.3.2, Web lacks ProcessInfo.)
  #if !os(WASI)
    /// A closure which produces the declined application name suitable for use in various gramatical contexts.
    var applicationName: ProcessInfo.ApplicationNameResolver { get }
  #endif

  /// The type that manages the application’s preferences.
  var preferenceManager: PreferenceManager? { get }
}

extension Application {

  public var preferenceManager: PreferenceManager? {
    return nil
  }

  // MARK: - Launching

  @discardableResult private static func prepareForMain() -> Self {
    let application = Self()
    // #workaround(Swift 5.3.2, Web lacks ProcessInfo.)
    #if !os(WASI)
      ProcessInfo.applicationName = application.applicationName
    #endif
    #if canImport(AppKit)
      let delegate = NSApplicationDelegate(application: application)
      permanentNSApplicationDelegateStorage = delegate
      NSApplication.shared.delegate = delegate
    #endif
    return application
  }

  #if !os(watchOS)
    // #workaround(Swift 5.3.2, Web lacks RunLoop.)
    #if !os(WASI)
      /// Initializes and runs the application.
      ///
      /// This method never returns. It is only marked `Void` for compatibility with `@main`.
      public static func main() {  // @exempt(from: tests)
        let application = prepareForMain()
        withExtendedLifetime(application) { () -> Never in
          #if canImport(AppKit)
            exit(NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv))
          #elseif canImport(UIKit)
            // Register the intended application externally, because UIApplicationMain insists on initializing its own.
            applicationToUse = application
            exit(
              UIApplicationMain(
                CommandLine.argc,
                CommandLine.unsafeArgv,
                nil,
                NSStringFromClass(UIApplicationDelegate<Self>.self)
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
  ///
  /// - Returns: The application instance that was set‐up.
  public static func setUpWithoutMain() -> Self {
    let application = prepareForMain()
    _ = application.prepareToLaunch(LaunchDetails())
    application.performPostLaunchSetUp()
    _ = application.finishLaunching(LaunchDetails())
    return application
  }
}
