// swift-tools-version:5.0

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
/// internal class SystemMediator : SDGApplication.SystemMediator {
///
///     internal func finishLaunching(_ details: LaunchDetails) -> Bool {
///         Application.setSamplesUp()
///         return true
///     }
/// }
/// ```
///
/// ```swift
/// Application.main(mediator: SystemMediator())
/// ```
let package = Package(
    name: "SDGInterface",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11),
        .watchOS(.v4),
        .tvOS(.v11)
    ],
    products: [
        // @documentation(SDGApplication)
        /// Application‐level functionality and system interaction.
        .library(name: "SDGApplication", targets: ["SDGApplication"]),

        // @documentation(SDGMenuBar)
        /// A menu bar.
        .library(name: "SDGMenuBar", targets: ["SDGMenuBar"]),

        // @documentation(SDGMenus)
        /// Menus.
        .library(name: "SDGMenus", targets: ["SDGMenus"]),

        // @documentation(SDGInterfaceElements)
        /// Re‐usable interface elements, such as views, windows and menus.
        .library(name: "SDGInterfaceElements", targets: ["SDGInterfaceElements"]),

        // @documentation(SDGInterfaceBasics)
        /// A menu bar.
        .library(name: "SDGInterfaceBasics", targets: ["SDGInterfaceBasics"])
    ],
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", from: Version(1, 0, 0))
    ],
    targets: [
        // #documentation(SDGApplication)
        /// Application‐level functionality and system interaction.
        .target(name: "SDGApplication", dependencies: [
            "SDGInterfaceLocalizations",
            "SDGInterfaceElements",
            "SDGMenuBar",
            .product(name: "SDGLogic", package: "SDGCornerstone"),
            .product(name: "SDGText", package: "SDGCornerstone"),
            .product(name: "SDGLocalization", package: "SDGCornerstone"),
            .product(name: "SDGCalendar", package: "SDGCornerstone")
            ], swiftSettings: [
                .define("VALIDATION", .when(configuration: .debug)),
                .define("UNHANDLED_SYSTEM_EVENT_LOGGING", .when(configuration: .debug))
            ]),

        // #documentation(SDGMenuBar)
        /// A menu bar.
        .target(name: "SDGMenuBar", dependencies: [
            "SDGInterfaceBasics",
            "SDGMenus",
            "SDGInterfaceLocalizations",
            .product(name: "SDGMathematics", package: "SDGCornerstone"),
            .product(name: "SDGText", package: "SDGCornerstone"),
            .product(name: "SDGLocalization", package: "SDGCornerstone")
            ]),

        // #documentation(SDGMenus)
        /// Menus.
        .target(name: "SDGMenus", dependencies: [
            "SDGInterfaceBasics",
            .product(name: "SDGControlFlow", package: "SDGCornerstone"),
            .product(name: "SDGText", package: "SDGCornerstone"),
            .product(name: "SDGLocalization", package: "SDGCornerstone")
            ]),

        // #documentation(SDGInterfaceElements)
        /// Re‐usable interface elements, such as views, windows and menus.
        .target(name: "SDGInterfaceElements", dependencies: [
            "SDGInterfaceLocalizations",
            "SDGMenus",
            .product(name: "SDGControlFlow", package: "SDGCornerstone"),
            .product(name: "SDGLogic", package: "SDGCornerstone"),
            .product(name: "SDGMathematics", package: "SDGCornerstone"),
            .product(name: "SDGCollections", package: "SDGCornerstone"),
            .product(name: "SDGText", package: "SDGCornerstone"),
            .product(name: "SDGLocalization", package: "SDGCornerstone")
            ], swiftSettings: [
                .define("UNIDENTIFIED_PASTEBOARD_WARNINGS", .when(configuration: .debug)),
                .define("SCREEN_LOCATION_WARNINGS", .when(configuration: .debug))
            ]),

        // #documentation(SDGInterfaceBasics)
        /// A menu bar.
        .target(name: "SDGInterfaceBasics", dependencies: [
            "SDGInterfaceLocalizations",
            .product(name: "SDGControlFlow", package: "SDGCornerstone"),
            .product(name: "SDGText", package: "SDGCornerstone"),
            .product(name: "SDGLocalization", package: "SDGCornerstone")
            ]),

        // Internal modules.

        .target(name: "SDGInterfaceLocalizations", dependencies: [
            .product(name: "SDGLocalization", package: "SDGCornerstone")
            ]),

        // Internal utilities.

        .testTarget(name: "SDGInterfaceResourceGenerationTests", dependencies: [
            "SDGInterfaceElements",
            .product(name: "SDGText", package: "SDGCornerstone"),
            .product(name: "SDGLocalization", package: "SDGCornerstone"),
            .product(name: "SDGPersistence", package: "SDGCornerstone")
            ]),

        // Internal tests.

        .testTarget(name: "SDGApplicationTests", dependencies: [
            "SDGApplication",
            "SDGInterfaceLocalizations",
            "SDGInterfaceSample",
            .product(name: "SDGControlFlow", package: "SDGCornerstone"),
            .product(name: "SDGLogic", package: "SDGCornerstone"),
            .product(name: "SDGMathematics", package: "SDGCornerstone"),
            .product(name: "SDGText", package: "SDGCornerstone"),
            .product(name: "SDGLocalization", package: "SDGCornerstone"),
            .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
            .product(name: "SDGLogicTestUtilities", package: "SDGCornerstone"),
            .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone")
            ]),

        .target(name: "SDGInterfaceSample", dependencies: [
            "SDGApplication",
            .product(name: "SDGControlFlow", package: "SDGCornerstone"),
            .product(name: "SDGMathematics", package: "SDGCornerstone"),
            .product(name: "SDGText", package: "SDGCornerstone"),
            .product(name: "SDGLocalization", package: "SDGCornerstone")
            ])
    ]
)
