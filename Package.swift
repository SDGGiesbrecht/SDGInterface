// swift-tools-version:5.1

/*
 Package.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import PackageDescription

// #example(1, mediator) #example(2, main)
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
/// import SDGApplication
///
/// internal class SystemMediator: SDGApplication.SystemMediator {
///
///   internal func finishLaunching(_ details: LaunchDetails) -> Bool {
///     Application.setSamplesUp()
///     return true
///   }
/// }
/// ```
///
/// ```swift
/// Application.main(mediator: SystemMediator())
/// ```
let package = Package(
  name: "SDGInterface",
  products: [
    // @documentation(SDGApplication)
    /// Application‐level functionality and system interaction.
    .library(name: "SDGApplication", targets: ["SDGApplication"]),

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

    // @documentation(SDGKeyboard)
    /// Utilities for working with keyboard input.
    .library(name: "SDGKeyboard", targets: ["SDGKeyboard"]),

    // @documentation(SDGInterfaceBasics)
    /// Basic interface building blocks.
    .library(name: "SDGInterfaceBasics", targets: ["SDGInterfaceBasics"]),

    .library(name: "_SDGInterfaceSample", targets: ["SDGInterfaceSample"])
  ],
  dependencies: [
    .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", from: Version(4, 0, 0))
  ],
  targets: [
    // #documentation(SDGApplication)
    /// Application‐level functionality and system interaction.
    .target(
      name: "SDGApplication",
      dependencies: [
        "SDGInterfaceLocalizations",
        "SDGMenus",
        "SDGContextMenu",
        "SDGMenuBar",
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGCalendar", package: "SDGCornerstone")
      ],
      swiftSettings: [
        .define("VALIDATION", .when(configuration: .debug)),
        .define("UNHANDLED_SYSTEM_EVENT_LOGGING", .when(configuration: .debug))
      ]
    ),

    // #documentation(SDGMenuBar)
    /// A menu bar.
    .target(
      name: "SDGMenuBar",
      dependencies: [
        "SDGInterfaceBasics",
        "SDGMenus",
        "SDGContextMenu",
        "SDGInterfaceLocalizations",
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone")
      ]
    ),

    // #documentation(SDGContextMenu)
    /// A context menu.
    .target(
      name: "SDGContextMenu",
      dependencies: [
        "SDGLogic",
        "SDGMenus",
        "SDGInterfaceLocalizations",
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone")
      ]
    ),

    // #documentation(SDGErrorMessages)
    /// Error messages.
    .target(
      name: "SDGErrorMessages",
      dependencies: [
        "SDGInterfaceLocalizations",
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone")
      ]
    ),

    // #documentation(SDGMenus)
    /// Menus.
    .target(
      name: "SDGMenus",
      dependencies: [
        "SDGInterfaceBasics",
        "SDGInterfaceLocalizations",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone")
      ]
    ),

    // #documentation(SDGPopOvers)
    /// Pop‐over interfaces.
    .target(
      name: "SDGPopOvers",
      dependencies: [
        "SDGInterfaceBasics",
        "SDGViews",
        .product(name: "SDGLogic", package: "SDGCornerstone")
      ]
    ),

    // #documentation(SDGWindows)
    /// Windows.
    .target(
      name: "SDGWindows",
      dependencies: [
        "SDGInterfaceBasics",
        "SDGViews",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGGeometry", package: "SDGCornerstone")
      ],
      swiftSettings: [
        .define("TEST_COVERAGE_AIDS", .when(configuration: .debug))
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
        .product(name: "SDGMathematics", package: "SDGCornerstone")
      ]
    ),

    // #documentation(SDGProgressIndicators)
    /// Progress indicators.
    .target(
      name: "SDGProgressIndicators",
      dependencies: [
        "SDGInterfaceBasics",
        "SDGViews",
        "SDGTextDisplay",
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone")
      ]
    ),

    // #documentation(SDGButtons)
    /// Buttons.
    .target(
      name: "SDGButtons",
      dependencies: [
        "SDGInterfaceBasics",
        "SDGViews",
        "SDGTextDisplay",
        "SDGImageDisplay",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone")
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
        "SDGInterfaceBasics",
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
        .product(name: "SDGLocalization", package: "SDGCornerstone")
      ],
      swiftSettings: [
        .define("UNIDENTIFIED_PASTEBOARD_WARNINGS", .when(configuration: .debug))
      ]
    ),

    // #documentation(SDGViews)
    /// The view protocol.
    .target(
      name: "SDGViews",
      dependencies: [
        "SDGInterfaceBasics",
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone")
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

    // #documentation(SDGInterfaceBasics)
    /// Basic interface building blocks.
    .target(
      name: "SDGInterfaceBasics",
      dependencies: [
        "SDGInterfaceLocalizations",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGGeometry", package: "SDGCornerstone")
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
        .product(name: "SDGPersistence", package: "SDGCornerstone")
      ]
    ),

    // Internal tests.

    .target(
      name: "SDGApplicationTestUtilities",
      dependencies: [
        "SDGApplication",
        "SDGInterfaceSample",
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
      ],
      path: "Tests/SDGApplicationTestUtilities"
    ),

    .testTarget(
      name: "SDGInterfaceBasicsTests",
      dependencies: [
        "SDGInterfaceBasics",
        "SDGInterfaceLocalizations",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
      ]
    ),

    .testTarget(
      name: "SDGViewsTests",
      dependencies: [
        "SDGViews",
        "SDGWindows",
        "SDGApplication",
        "SDGInterfaceSample",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
      ]
    ),

    .testTarget(
      name: "SDGTextDisplayTests",
      dependencies: [
        "SDGInterfaceBasics",
        "SDGViews",
        "SDGWindows",
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
        .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone")
      ]
    ),

    .testTarget(
      name: "SDGImageDisplayTests",
      dependencies: [
        "SDGTextDisplay",
        "SDGApplication",
        "SDGInterfaceSample",
        "SDGApplicationTestUtilities",
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
      ]
    ),

    .testTarget(
      name: "SDGButtonsTests",
      dependencies: [
        "SDGInterfaceBasics",
        "SDGButtons",
        "SDGApplication",
        "SDGInterfaceSample",
        "SDGInterfaceLocalizations",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
      ]
    ),

    .testTarget(
      name: "SDGProgressIndicatorsTests",
      dependencies: [
        "SDGProgressIndicators",
        "SDGApplication",
        "SDGInterfaceSample",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
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
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
      ]
    ),

    .testTarget(
      name: "SDGKeyboardTests",
      dependencies: [
        "SDGKeyboard",
        "SDGApplicationTestUtilities",
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
      ]
    ),

    .testTarget(
      name: "SDGWindowsTests",
      dependencies: [
        "SDGInterfaceBasics",
        "SDGViews",
        "SDGWindows",
        "SDGInterfaceLocalizations",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
      ]
    ),

    .testTarget(
      name: "SDGPopOversTests",
      dependencies: [
        "SDGViews",
        "SDGWindows",
        "SDGPopOvers",
        "SDGApplication",
        "SDGInterfaceSample",
        "SDGApplicationTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
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
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
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
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
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
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
      ]
    ),

    .testTarget(
      name: "SDGApplicationTests",
      dependencies: [
        "SDGInterfaceBasics",
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
        .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone")
      ]
    ),

    .target(
      name: "SDGInterfaceSample",
      dependencies: [
        "SDGInterfaceLocalizations",
        "SDGInterfaceBasics",
        "SDGTextDisplay",
        "SDGImageDisplay",
        "SDGButtons",
        "SDGWindows",
        "SDGMenus",
        "SDGErrorMessages",
        "SDGMenuBar",
        "SDGApplication",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone")
      ]
    )
  ]
)

// #workaround(Swift 5.1.2, The generated Xcode project cannot import XCTest on iOS devices.)
import Foundation
let path = ProcessInfo.processInfo.environment["PATH"] ?? ""
let firstColon = path.range(of: ":")?.lowerBound ?? path.endIndex
let firstEntry = path[..<firstColon]
if firstEntry.hasSuffix("/Contents/Developer/usr/bin") {
  let sdgXCTestUtilities = package.targets.first(where: { $0.name == "SDGApplicationTestUtilities" }
  )!
  var settings = sdgXCTestUtilities.swiftSettings ?? []
  settings.append(.define("MANIFEST_LOADED_BY_XCODE"))
  sdgXCTestUtilities.swiftSettings = settings
}

// #workaround(workspace 0.27.1, Something here causes hard linking.)
for target in package.targets {
  var settings = target.swiftSettings ?? []
  defer { target.swiftSettings = settings }
  settings.append(.define("NO_PREVIEWS", .when(platforms: [.macOS])))
}
