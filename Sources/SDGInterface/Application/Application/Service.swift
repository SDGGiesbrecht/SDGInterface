/*
 Service.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

/// A type that represents a service or application.
///
/// A service can display interface elements when relevant, but generally hides until called upon.
///
/// Create a service by declaring a structure that conforms directly to the `Service` protocol.
///
/// - Note: In contrast to services, applications are primarily driven by a user interface. Applications should also conform to the `Application` protocol, which inherits from `Service` in order to share members relevant to both.
public protocol Service: SystemInterface {

  /// Creates an application.
  init()

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS_INFO
    /// A closure which produces the declined application name suitable for use in various gramatical contexts.
    var applicationName: ProcessInfo.ApplicationNameResolver { get }

    /// The application identifier.
    var applicationIdentifier: String { get }
  #endif

  /// The type of the preferences view.
  associatedtype Preferences: LegacyView
  /// The preferences view.
  var preferences: Preferences { get }

  /// Initializes and runs the application.
  ///
  /// This method never returns. It is only marked `Void` for compatibility with `@main`.
  static func main()

  func _displayMainWindow()
}

extension Service {

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS_INFO
    public var applicationIdentifier: String {
      return ProcessInfo.applicationIdentifier
    }
  #endif

  public var preferences: EmptyView {
    return EmptyView()
  }

  // MARK: - Launching

  @discardableResult internal static func prepareForMain() -> Self {
    let application = Self()
    #if !PLATFORM_LACKS_FOUNDATION_PROCESS_INFO
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

  #if !PLATFORM_LACKS_FOUNDATION_RUN_LOOP
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
        hidePreferences.value = preferences is EmptyView
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

    #if canImport(AppKit)
      if let object = self as? NSObject {
        NSApplication.shared.servicesProvider = object
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
    _displayMainWindow()
    return finishLaunching(details)
  }

  public func _displayMainWindow() {}

  // MARK: - SystemInterface

  public func finishLaunching(_ details: LaunchDetails) -> Bool {
    return true
  }
}
