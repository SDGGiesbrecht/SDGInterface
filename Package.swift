// swift-tools-version:5.3

/*
 Package.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import PackageDescription

// #example(1, application) #example(2, main) #example(3, conditions)
/// SDGInterface provides tools for implementing a graphical user interface.
///
/// > [Καὶ ὁ Λόγος σὰρξ ἐγένετο καὶ ἐσκήνωσεν ἐν ἡμῖν, καὶ ἐθεασάμεθα τὴν δόξαν αὐτοῦ, δόξαν ὡς μονογενοῦς παρὰ πατρός, πλήρης χάριτος καὶ ἀληθείας.](https://www.biblegateway.com/passage/?search=John+1&version=SBLGNT;NIV)
/// >
/// > [And the Word became flesh and dwelt among us and we have watched His glory, the glory of the Only Begotten of the Father, full of grace and truth.](https://www.biblegateway.com/passage/?search=John+1&version=SBLGNT;NIV)
/// >
/// > ―‎יוחנן⁩/Yoẖanan
///
/// ### Features
///
/// - API unification accross platforms.
/// - Localized menu bar.
///
/// ### Example Usage
///
/// ```swift
/// import Foundation
///
/// import SDGText
/// import SDGLocalization
///
/// import SDGInterface
///
/// #if !(os(iOS) && arch(arm))
///   @available(macOS 11, watchOS 6, *)
///   extension SampleApplication: Application {}
/// #endif
///
/// @available(watchOS 6, *)
/// public struct SampleApplication: LegacyApplication {
///
///   public init() {}
///
///   public var applicationName: ProcessInfo.ApplicationNameResolver {
///     return { form in
///       switch form {
///       case .english(let region):
///         switch region {
///         case .unitedKingdom, .unitedStates, .canada:
///           return "Sample"
///         }
///       case .español(let preposición):
///         switch preposición {
///         case .ninguna:
///           return "Ejemplar"
///         case .de:
///           return "del Ejemplar"
///         }
///       case .deutsch(let fall):
///         switch fall {
///         case .nominativ, .akkusativ, .dativ:
///           return "Beispiel"
///         }
///       case .français(let préposition):
///         switch préposition {
///         case .aucune:
///           return "Exemple"
///         case .de:
///           return "de l’Exemple"
///         }
///
///       case .ελληνικά(let πτώση):
///         switch πτώση {
///         case .ονομαστική:
///           return "Παράδειγμα"
///         case .αιτιατική:
///           return "το Παράδειγμα"
///         case .γενική:
///           return "του Παραδείγματος"
///         }
///       case .עברית:
///         return "דוגמה"
///       }
///     }
///   }
///
///   public var applicationIdentifier: String {
///     return "com.example.SampleApplication"
///   }
///
///   public static func main() {  // @exempt(from: tests)
///     #if os(iOS) && arch(arm)
///       legacyMain()
///     #else
///       if #available(macOS 11, tvOS 14, iOS 14, watchOS 7, *) {
///         modernMain()
///       } else {
///         legacyMain()
///       }
///     #endif
///   }
///
///   public var mainWindow: Window<Label<InterfaceLocalization>, InterfaceLocalization> {
///     return Window(
///       type: .primary(nil),
///       name: UserFacing<StrictString, InterfaceLocalization>({ localization in
///         switch localization {
///         case .englishCanada:
///           return "Sample"
///         }
///       }),
///       content: Label(
///         UserFacing<StrictString, InterfaceLocalization>({ localization in
///           switch localization {
///           case .englishCanada:
///             return "Hello, world!"
///           }
///         })
///       )
///     )
///   }
/// }
/// ```
///
/// ```swift
/// @main extension SampleApplication {}
/// ```
///
/// Some platforms lack certain features. The compilation conditions which appear throughout the documentation are defined as follows:
///
/// ```swift
/// .define("PLATFORM_LACKS_FOUNDATION_RUN_LOOP", .when(platforms: [.wasi])),
/// ```
let package = Package(
  name: "SDGInterface",
  products: [
    // @documentation(SDGInterface)
    /// Basic interface building blocks.
    .library(name: "SDGInterface", targets: ["SDGInterface"]),
    // @documentation(SDGInterfaceTestUtilities)
    /// Utilities for testing code which uses `SDGInterface`.
    .library(name: "SDGInterfaceTestUtilities", targets: ["SDGInterfaceTestUtilities"]),

    // @documentation(SDGErrorMessages)
    /// Error messages.
    .library(name: "SDGErrorMessages", targets: ["SDGErrorMessages"]),

    // @documentation(SDGProgressIndicators)
    /// Progress indicators.
    .library(name: "SDGProgressIndicators", targets: ["SDGProgressIndicators"]),

    // @documentation(SDGKeyboard)
    /// Utilities for working with keyboard input.
    .library(name: "SDGKeyboard", targets: ["SDGKeyboard"]),

    .library(name: "_SDGInterfaceSample", targets: ["SDGInterfaceSample"]),
  ],
  dependencies: [
    .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", from: Version(7, 0, 0))
  ],
  targets: [

    // #documentation(SDGInterface)
    /// Basic interface building blocks.
    .target(
      name: "SDGInterface",
      dependencies: [
        "SDGInterfaceLocalizations",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGGeometry", package: "SDGCornerstone"),
        .product(name: "SDGCalendar", package: "SDGCornerstone"),
      ]
    ),
    // #documentation(SDGInterfaceTestUtilities)
    /// Utilities for testing code which uses `SDGInterface`.
    .target(
      name: "SDGInterfaceTestUtilities",
      dependencies: [
        "SDGInterface",
        "SDGInterfaceLocalizations",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGTesting", package: "SDGCornerstone"),
      ]
    ),

    // #documentation(SDGErrorMessages)
    /// Error messages.
    .target(
      name: "SDGErrorMessages",
      dependencies: [
        "SDGInterfaceLocalizations",
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
      ]
    ),

    // #documentation(SDGProgressIndicators)
    /// Progress indicators.
    .target(
      name: "SDGProgressIndicators",
      dependencies: [
        "SDGInterfaceLocalizations",
        "SDGInterface",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
      ]
    ),

    // #documentation(SDGKeyboard)
    /// Utilities for working with keyboard input.
    .target(
      name: "SDGKeyboard",
      dependencies: [
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
      ]
    ),

    // Internal modules.

    .target(
      name: "SDGInterfaceLocalizations",
      dependencies: [
        .product(name: "SDGLocalization", package: "SDGCornerstone")
      ]
    ),

    // Internal utilities.

    .testTarget(
      name: "SDGInterfaceResourceGeneration",
      dependencies: [
        "SDGInterface",
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGPersistence", package: "SDGCornerstone"),
      ]
    ),

    // Internal tests.

    .target(
      name: "SDGInterfaceInternalTestUtilities",
      dependencies: [
        "SDGInterface",
        "SDGInterfaceSample",
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ],
      path: "Tests/SDGInterfaceInternalTestUtilities"
    ),

    .testTarget(
      name: "SDGInterfaceTests",
      dependencies: [
        "SDGInterface",
        "SDGInterfaceSample",
        "SDGInterfaceLocalizations",
        "SDGInterfaceTestUtilities",
        "SDGInterfaceInternalTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGLogicTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .testTarget(
      name: "SDGProgressIndicatorsTests",
      dependencies: [
        "SDGInterface",
        "SDGProgressIndicators",
        "SDGInterfaceSample",
        "SDGInterfaceTestUtilities",
        "SDGInterfaceInternalTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .testTarget(
      name: "SDGKeyboardTests",
      dependencies: [
        "SDGKeyboard",
        "SDGInterfaceInternalTestUtilities",
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .target(
      name: "SDGInterfaceSample",
      dependencies: [
        "SDGInterfaceLocalizations",
        "SDGInterface",
        "SDGProgressIndicators",
        "SDGErrorMessages",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
      ]
    ),
  ]
)

for target in package.targets {
  var swiftSettings = target.swiftSettings ?? []
  defer { target.swiftSettings = swiftSettings }
  swiftSettings.append(contentsOf: [
    // #workaround(workspace version 0.36.3, Bug prevents centralization of windows conditions.)
    // #workaround(Swift 5.3.3, Web lacks Foundation.RunLoop.)
    // @example(conditions)
    .define("PLATFORM_LACKS_FOUNDATION_RUN_LOOP", .when(platforms: [.wasi])),
    // @endExample
  ])
}

if ProcessInfo.processInfo.environment["TARGETING_WATCHOS"] == "true" {
  // #workaround(xcodebuild -version 12.4, Test targets don’t work on watchOS.) @exempt(from: unicode)
  package.targets.removeAll(where: { $0.isTest })
}

// Windows Tests (Generated automatically by Workspace.)
import Foundation
if ProcessInfo.processInfo.environment["TARGETING_WINDOWS"] == "true" {
  var tests: [Target] = []
  var other: [Target] = []
  for target in package.targets {
    if target.type == .test {
      tests.append(target)
    } else {
      other.append(target)
    }
  }
  package.targets = other
  package.targets.append(
    contentsOf: tests.map({ test in
      return .target(
        name: test.name,
        dependencies: test.dependencies,
        path: test.path ?? "Tests/\(test.name)",
        exclude: test.exclude,
        sources: test.sources,
        publicHeadersPath: test.publicHeadersPath,
        cSettings: test.cSettings,
        cxxSettings: test.cxxSettings,
        swiftSettings: test.swiftSettings,
        linkerSettings: test.linkerSettings
      )
    })
  )
  package.targets.append(
    .target(
      name: "WindowsTests",
      dependencies: tests.map({ Target.Dependency.target(name: $0.name) }),
      path: "Tests/WindowsTests"
    )
  )
}
// End Windows Tests
