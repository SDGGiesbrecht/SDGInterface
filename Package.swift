// swift-tools-version:5.4

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
///   @available(macOS 11, tvOS 14, iOS 14, watchOS 7, *)
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
/// .define("PLATFORM_LACKS_FOUNDATION_PROCESS_INFO", .when(platforms: [.wasi])),
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
    .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", from: Version(7, 2, 3))
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
    // #workaround(Swift 5.4.2, Web lacks Foundation.ProcessInfo.)
    // #workaround(Swift 5.4.2, Web lacks Foundation.RunLoop.)
    // @example(conditions)
    .define("PLATFORM_LACKS_FOUNDATION_PROCESS_INFO", .when(platforms: [.wasi])),
    .define("PLATFORM_LACKS_FOUNDATION_RUN_LOOP", .when(platforms: [.wasi])),
    // @endExample

    // Internal:
    // #workaround(SDGCornerstone 7.2.4, Web lacks TestCase.)
    .define("PLATFORM_LACKS_SDG_CORNERSTONE_TEST_CASE", .when(platforms: [.watchOS])),
  ])
}
