/*
 Application.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type that represents an application.
///
/// Create an application by declaring a structure that conforms to the `Application` protocol.
@available(macOS 11, tvOS 14, iOS 14, watchOS 7, *)
public protocol Application: LegacyApplication
where MenuBarType: MenuBarProtocol, MainWindow: WindowProtocol, Preferences: View {}

@available(macOS 11, tvOS 14, iOS 14, watchOS 7, *)
extension Application {

  #if !PLATFORM_LACKS_FOUNDATION_RUN_LOOP
    /// Initializes and runs the application in the modern manner.
    ///
    /// This variant of `main` uses SwiftUI on some platforms and thus is unavailable on older platform versions.
    public static func modernMain() {  // @exempt(from: tests)
      #if canImport(SwiftUI)
        usingSwiftUI = true
      #endif
      let application = prepareForMain()
      withExtendedLifetime(application) {
        #if canImport(SwiftUI)
          applicationToUse = application
          SwiftUIApplication<Self>.main()
        #else
          legacyMain()
        #endif
      }
    }

    public static func main() {  // @exempt(from: tests)
      modernMain()
    }
  #endif
}
