/*
 Application.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
#if canImport(Foundation)
  import Foundation
#endif
#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

import SDGContextMenu
#if !os(Windows)  // #workaround(Swift 5.1.3, Windows cannot find the dependency.)
  import SDGMenuBar
#endif

/// The application.
public final class Application {

  // MARK: - Static Properties

  /// The application.
  public static let shared: Application = Application()

  // MARK: - Initialization

  private init() {
    #if canImport(AppKit)
      nativeDelegate = NSApplicationDelegate()
    #elseif canImport(UIKit) && !os(watchOS)
      nativeDelegate = UIApplicationDelegate()
    #endif
  }

  // MARK: - Properties

  #if canImport(AppKit)
    private var nativeDelegate: NSApplicationDelegate
  #elseif canImport(UIKit) && !os(watchOS)
    private var nativeDelegate: UIApplicationDelegate
  #endif

  internal var systemMediator: SystemMediator?

  /// An object which manages the application’s preferences.
  public var preferenceManager: PreferenceManager?

  // MARK: - Launching

  /// Preforms the same preparatory actions taken by `main(mediator:)`, but without triggering the system’s main loop.
  ///
  /// This method can set up a portion of the application when helpful for tests, but it should only be called once. Do not call it separately before `main(mediator)`.
  ///
  /// - Parameters:
  ///     - mediator: An object which will mediate between the application and system events.
  private class func prepareForMain(mediator: SystemMediator) {
    Application.shared.systemMediator = mediator
    #if canImport(AppKit)
      NSApplication.shared.delegate = shared.nativeDelegate
    #endif
  }

  #if !os(watchOS)
    // #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
    #if canImport(Foundation)
      /// Starts the application’s main run loop.
      ///
      /// - Parameters:
      ///     - mediator: An object which will mediate between the application and system events.
      public class func main(mediator: SystemMediator) -> Never {  // @exempt(from: tests)
        prepareForMain(mediator: mediator)
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
    #endif
  #endif

  internal class func postLaunchSetUp() {
    #if canImport(UIKit) && !os(watchOS) && !os(tvOS)
      _ = ContextMenu.contextMenu
    #endif

    #if canImport(AppKit)
      _ = MenuBar.menuBar
    #endif

    #if canImport(AppKit)
      NSApplication.shared.activate(ignoringOtherApps: false)
    #endif
  }

  /// Preforms the same preparatory actions taken by `main(mediator:)`, but without triggering the system’s main loop.
  ///
  /// This method can set up a portion of the application when helpful for tests, but it should only be called once. Do not call it separately before `main(mediator:)`.
  ///
  /// - Parameters:
  ///     - mediator: An object which will mediate between the application and system events.
  public class func setUpWithoutMain(mediator: SystemMediator) {
    prepareForMain(mediator: mediator)
    _ = mediator.prepareToLaunch(LaunchDetails())
    postLaunchSetUp()
    _ = mediator.finishLaunching(LaunchDetails())
  }
}
