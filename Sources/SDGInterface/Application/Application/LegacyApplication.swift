/*
 LegacyApplication.swift

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
import SDGLocalization

internal var usingSwiftUI = false

/// The subset of the `Application` protocol that can be conformed to even on platform versions preceding SwiftUI’s availability.
public protocol LegacyApplication: SystemInterface {

  /// Creates an application.
  init()

  // #workaround(Swift 5.3.2, Web lacks ProcessInfo.)
  #if !os(WASI)
    /// A closure which produces the declined application name suitable for use in various gramatical contexts.
    var applicationName: ProcessInfo.ApplicationNameResolver { get }

    /// The application identifier.
    var applicationIdentifier: String { get }
  #endif

  /// The type of the main window.
  associatedtype MainWindow: LegacyWindow
  /// The application’s main window.
  var mainWindow: MainWindow { get }

  /// The type that manages the application’s preferences.
  var preferenceManager: PreferenceManager? { get }

  /// Initializes and runs the application.
  ///
  /// This method never returns. It is only marked `Void` for compatibility with `@main`.
  static func main()
}

extension LegacyApplication {

  public var preferenceManager: PreferenceManager? {
    return nil
  }

  // MARK: - Launching

  @discardableResult internal static func prepareForMain() -> Self {
    let application = Self()
    // #workaround(Swift 5.3.2, Web lacks ProcessInfo.)
    #if !os(WASI)
      ProcessInfo.applicationIdentifier = application.applicationIdentifier
      ProcessInfo.applicationName = application.applicationName
    #endif
    #if canImport(AppKit)
    if ¬usingSwiftUI {
      let delegate = NSApplicationDelegate(application: application)
      permanentNSApplicationDelegateStorage = delegate
      NSApplication.shared.delegate = delegate
    }
    #endif
    return application
  }

  // #workaround(Swift 5.3.2, Web lacks RunLoop.)
  #if !os(WASI)
    internal static func _legacyMain(application: Self) -> Never {  // @exempt(from: tests)
      #if canImport(AppKit)
        exit(NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv))
      #elseif canImport(UIKit) && !os(watchOS)
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
    /// Initializes and runs the application in the legacy manner.
    ///
    /// This variant of `main` works on platform versions preceding SwiftUI’s availability.
    public static func legacyMain() -> Never {  // @exempt(from: tests)
      let application = prepareForMain()
      withExtendedLifetime(application) {
        _legacyMain(application: application)
      }
    }
    public static func main() {  // @exempt(from: tests)
      legacyMain()
    }
  #endif

  internal func performPostLaunchSetUp() {
    #if canImport(UIKit) && !os(tvOS) && !os(watchOS)
      UIMenuController.shared.menuItems = ContextMenu().cocoa()
      UIMenuController.shared.update()
    #endif

    #if canImport(AppKit)
    if ¬usingSwiftUI {
      hidePreferences.value = preferenceManager == nil
      let menuBar = self.menuBar.cocoa()
      NSApplication.shared.mainMenu = menuBar
      NSApplication.shared.servicesMenu =
        menuBar.items.first?.submenu?.items.first(where: { $0.submenu ≠ nil })?.submenu
      NSApplication.shared.windowsMenu = menuBar.items.dropLast().last?.submenu
      NSApplication.shared.helpMenu = menuBar.items.last?.submenu
    }
    #endif

    #if canImport(AppKit)
    if ¬usingSwiftUI {
      NSApplication.shared.activate(ignoringOtherApps: false)
    }
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
    _ = application.setUpAndFinishLaunching(LaunchDetails())
    return application
  }

  internal func setUpAndFinishLaunching(_ details: LaunchDetails) -> Bool {
    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      if ¬usingSwiftUI {
        mainWindow.display()
      }
    #elseif DEBUG
      _ = mainWindow  // Eager execution to simplify testing.
    #endif
    return finishLaunching(details)
  }

  // MARK: - SystemInterface

  public func finishLaunching(_ details: LaunchDetails) -> Bool {
    return true
  }
}
