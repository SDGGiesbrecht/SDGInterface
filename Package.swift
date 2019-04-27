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
let package = Package(
    name: "SDGInterface",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11),
        .watchOS(.v4),
        .tvOS(.v11)
    ],
    products: [
        // The entire package.

        // @documentation(SDGInterface)
        /// A module representing the entire `SDGInterface` package. All the other modules can be used from this single import.
        .library(name: "SDGInterface", targets: ["SDGInterface"]),

        // Individual component modules.

        // @documentation(SDGInterfaceElements)
        /// Re‐usable interface elements, such as views, windows and menus.
        .library(name: "SDGInterfaceElements", targets: ["SDGInterfaceElements"]),

        // @documentation(SDGApplication)
        /// Specific, application‐level elements, such as the application delegate and menu bar.
        .library(name: "SDGApplication", targets: ["SDGApplication"])
    ],
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", .upToNextMinor(from: Version(0, 17, 0)))
    ],
    targets: [
        // The entire package.

        // #documentation(SDGInterface)
        /// A module representing the entire `SDGInterface` package. All the other modules can be used from this single import.
        .target(name: "SDGInterface", dependencies: [
            "SDGInterfaceElements",
            "SDGApplication"
            ]),

        // Individual component modules.

        // #documentation(SDGInterfaceElements)
        /// Re‐usable interface elements, such as views, windows and menus.
        .target(name: "SDGInterfaceElements", dependencies: [
            "SDGInterfaceLocalizations",
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

        // #documentation(SDGApplication)
        /// Specific, application‐level elements, such as the application delegate and menu bar.
        .target(name: "SDGApplication", dependencies: [
            "SDGInterfaceLocalizations",
            "SDGInterfaceElements",
            .product(name: "SDGLogic", package: "SDGCornerstone"),
            .product(name: "SDGLocalization", package: "SDGCornerstone")
            ], swiftSettings: [
                .define("VALIDATION", .when(configuration: .debug))
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
            .product(name: "SDGLogic", package: "SDGCornerstone"),
            .product(name: "SDGMathematics", package: "SDGCornerstone"),
            .product(name: "SDGText", package: "SDGCornerstone"),
            .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
            .product(name: "SDGLogicTestUtilities", package: "SDGCornerstone"),
            .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone")
            ]),

        .target(name: "SDGInterfaceSample", dependencies: [
            "SDGInterface"
            ])
    ]
)
