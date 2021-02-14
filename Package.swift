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

// #example(1, application) #example(2, main)
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
/// import SDGTextDisplay
/// import SDGWindows
/// import SDGApplication
///
/// public struct SampleApplication: SDGApplication.Application {
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
///   public func finishLaunching(_ details: LaunchDetails) -> Bool {
///     Swift.print("Hello, world!")
///     return true
///   }
/// }
/// ```
///
/// ```swift
/// @main extension SampleApplication {}
/// ```
let package = Package(
  name: "SDGInterface",
  products: [
    // @documentation(SDGApplication)
    /// Application‐level functionality and system interaction.
    .library(name: "SDGApplication", targets: ["SDGApplication"]),

    // @documentation(SDGInterface)
    /// Basic interface building blocks.
    .library(name: "SDGInterface", targets: ["SDGInterface"]),

    // @documentation(SDGMenuBar)
    /// A menu bar.
    .library(name: "SDGMenuBar", targets: ["SDGMenuBar"]),

    // @documentation(SDGContextMenu)
    /// A context menu.
    .library(name: "SDGContextMenu", targets: ["SDGContextMenu"]),

    // @documentation(SDGErrorMessages)
    /// Error messages.
    .library(name: "SDGErrorMessages", targets: ["SDGErrorMessages"]),

    // @documentation(SDGMenus)
    /// Menus.
    .library(name: "SDGMenus", targets: ["SDGMenus"]),

    // @documentation(SDGPopOvers)
    /// Pop‐over interfaces.
    .library(name: "SDGPopOvers", targets: ["SDGPopOvers"]),

    // @documentation(SDGWindows)
    /// Windows.
    .library(name: "SDGWindows", targets: ["SDGWindows"]),

    // @documentation(SDGTables)
    /// Tables.
    .library(name: "SDGTables", targets: ["SDGTables"]),

    // @documentation(SDGProgressIndicators)
    /// Progress indicators.
    .library(name: "SDGProgressIndicators", targets: ["SDGProgressIndicators"]),

    // @documentation(SDGButtons)
    /// Buttons.
    .library(name: "SDGButtons", targets: ["SDGButtons"]),

    // @documentation(SDGImageDisplay)
    /// Images.
    .library(name: "SDGImageDisplay", targets: ["SDGImageDisplay"]),

    // @documentation(SDGTextDisplay)
    /// Text.
    .library(name: "SDGTextDisplay", targets: ["SDGTextDisplay"]),

    // @documentation(SDGViews)
    /// The view protocol.
    .library(name: "SDGViews", targets: ["SDGViews"]),
    // @documentation(SDGViewsTestUtilities)
    /// Utilities for testing code which uses `SDGViews`.
    .library(name: "SDGViewsTestUtilities", targets: ["SDGViewsTestUtilities"]),

    // @documentation(SDGKeyboard)
    /// Utilities for working with keyboard input.
    .library(name: "SDGKeyboard", targets: ["SDGKeyboard"]),

    .library(name: "_SDGInterfaceSample", targets: ["SDGInterfaceSample"]),
  ],
  dependencies: [
    .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", from: Version(6, 2, 0))
  ],
  targets: [
    // #documentation(SDGApplication)
    /// Application‐level functionality and system interaction.
    .target(
      name: "SDGApplication",
      dependencies: [
        "SDGInterfaceLocalizations",
        "SDGInterface",
        "SDGMenus",
        "SDGContextMenu",
        "SDGMenuBar",
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGCalendar", package: "SDGCornerstone"),
      ]
    ),

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
      ]
    ),

    // #documentation(SDGMenuBar)
    /// A menu bar.
    .target(
      name: "SDGMenuBar",
      dependencies: [
        "SDGInterface",
        "SDGMenus",
        "SDGContextMenu",
        "SDGInterfaceLocalizations",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
      ]
    ),

    // #documentation(SDGContextMenu)
    /// A context menu.
    .target(
      name: "SDGContextMenu",
      dependencies: [
        "SDGMenus",
        "SDGInterfaceLocalizations",
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
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

    // #documentation(SDGMenus)
    /// Menus.
    .target(
      name: "SDGMenus",
      dependencies: [
        "SDGInterface",
        "SDGInterfaceLocalizations",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
      ]
    ),

    // #documentation(SDGPopOvers)
    /// Pop‐over interfaces.
    .target(
      name: "SDGPopOvers",
      dependencies: [
        "SDGInterface",
        "SDGViews",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
      ]
    ),

    // #documentation(SDGWindows)
    /// Windows.
    .target(
      name: "SDGWindows",
      dependencies: [
        "SDGInterface",
        "SDGViews",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGGeometry", package: "SDGCornerstone"),
      ]
    ),

    // #documentation(SDGTables)
    /// Tables.
    .target(
      name: "SDGTables",
      dependencies: [
        "SDGViews",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
      ]
    ),

    // #documentation(SDGProgressIndicators)
    /// Progress indicators.
    .target(
      name: "SDGProgressIndicators",
      dependencies: [
        "SDGInterfaceLocalizations",
        "SDGInterface",
        "SDGViews",
        "SDGTextDisplay",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
      ]
    ),

    // #documentation(SDGButtons)
    /// Buttons.
    .target(
      name: "SDGButtons",
      dependencies: [
        "SDGInterface",
        "SDGViews",
        "SDGTextDisplay",
        "SDGImageDisplay",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
      ]
    ),

    // #documentation(SDGImageDisplay)
    /// Images.
    .target(
      name: "SDGImageDisplay",
      dependencies: [
        "SDGViews"
      ]
    ),

    // #documentation(SDGTextDisplay)
    /// Text.
    .target(
      name: "SDGTextDisplay",
      dependencies: [
        "SDGInterface",
        "SDGViews",
        "SDGTables",
        "SDGWindows",
        "SDGPopOvers",
        "SDGMenus",
        "SDGContextMenu",
        "SDGInterfaceLocalizations",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
      ]
    ),

    // #documentation(SDGViews)
    /// The view protocol.
    .target(
      name: "SDGViews",
      dependencies: [
        "SDGInterface",
        "SDGInterfaceLocalizations",
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
      ]
    ),
    // #documentation(SDGViewsTestUtilities)
    /// Utilities for testing code which uses `SDGViews`.
    .target(
      name: "SDGViewsTestUtilities",
      dependencies: [
        "SDGViews",
        "SDGWindows",
        "SDGInterfaceLocalizations",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGTesting", package: "SDGCornerstone"),
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
        "SDGTextDisplay",
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGPersistence", package: "SDGCornerstone"),
      ]
    ),

    // Internal tests.

    .target(
      name: "SDGApplicationTestUtilities",
      dependencies: [
        "SDGApplication",
        "SDGInterfaceSample",
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ],
      path: "Tests/SDGApplicationTestUtilities"
    ),

    .testTarget(
      name: "SDGInterfaceTests",
      dependencies: [
        "SDGInterface",
        "SDGInterfaceLocalizations",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .testTarget(
      name: "SDGViewsTests",
      dependencies: [
        "SDGInterface",
        "SDGViews",
        "SDGWindows",
        "SDGApplication",
        "SDGInterfaceSample",
        "SDGViewsTestUtilities",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .testTarget(
      name: "SDGTextDisplayTests",
      dependencies: [
        "SDGInterface",
        "SDGViews",
        "SDGWindows",
        "SDGApplication",
        "SDGInterfaceLocalizations",
        "SDGInterfaceSample",
        "SDGViewsTestUtilities",
        "SDGApplicationTestUtilities",
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
      name: "SDGImageDisplayTests",
      dependencies: [
        "SDGTextDisplay",
        "SDGApplication",
        "SDGInterfaceSample",
        "SDGViewsTestUtilities",
        "SDGApplicationTestUtilities",
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .testTarget(
      name: "SDGButtonsTests",
      dependencies: [
        "SDGInterface",
        "SDGViews",
        "SDGImageDisplay",
        "SDGButtons",
        "SDGApplication",
        "SDGInterfaceSample",
        "SDGInterfaceLocalizations",
        "SDGViewsTestUtilities",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .testTarget(
      name: "SDGProgressIndicatorsTests",
      dependencies: [
        "SDGTextDisplay",
        "SDGProgressIndicators",
        "SDGApplication",
        "SDGInterfaceSample",
        "SDGViewsTestUtilities",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .testTarget(
      name: "SDGTablesTests",
      dependencies: [
        "SDGViews",
        "SDGTextDisplay",
        "SDGTables",
        "SDGWindows",
        "SDGApplication",
        "SDGInterfaceSample",
        "SDGViewsTestUtilities",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .testTarget(
      name: "SDGKeyboardTests",
      dependencies: [
        "SDGKeyboard",
        "SDGApplicationTestUtilities",
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .testTarget(
      name: "SDGWindowsTests",
      dependencies: [
        "SDGInterface",
        "SDGViews",
        "SDGWindows",
        "SDGInterfaceLocalizations",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .testTarget(
      name: "SDGPopOversTests",
      dependencies: [
        "SDGInterface",
        "SDGViews",
        "SDGWindows",
        "SDGPopOvers",
        "SDGApplication",
        "SDGInterfaceSample",
        "SDGViewsTestUtilities",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .testTarget(
      name: "SDGMenusTests",
      dependencies: [
        "SDGMenus",
        "SDGInterfaceLocalizations",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .testTarget(
      name: "SDGContextMenuTests",
      dependencies: [
        "SDGMenus",
        "SDGContextMenu",
        "SDGInterfaceLocalizations",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .testTarget(
      name: "SDGMenuBarTests",
      dependencies: [
        "SDGMenus",
        "SDGContextMenu",
        "SDGMenuBar",
        "SDGInterfaceLocalizations",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),

    .testTarget(
      name: "SDGApplicationTests",
      dependencies: [
        "SDGInterface",
        "SDGViews",
        "SDGTextDisplay",
        "SDGWindows",
        "SDGMenus",
        "SDGContextMenu",
        "SDGMenuBar",
        "SDGApplication",
        "SDGInterfaceLocalizations",
        "SDGInterfaceSample",
        "SDGApplicationTestUtilities",
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

    .target(
      name: "SDGInterfaceSample",
      dependencies: [
        "SDGInterfaceLocalizations",
        "SDGInterface",
        "SDGTextDisplay",
        "SDGImageDisplay",
        "SDGButtons",
        "SDGProgressIndicators",
        "SDGWindows",
        "SDGMenus",
        "SDGErrorMessages",
        "SDGMenuBar",
        "SDGApplication",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
      ]
    ),
  ]
)

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
