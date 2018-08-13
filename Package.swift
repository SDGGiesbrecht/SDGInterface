// swift-tools-version:4.1

/*
 Package.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import PackageDescription

let package = Package(
    name: "SDGInterface",
    products: [
        // The entire package.
        .library(name: "SDGInterface", targets: ["SDGInterface"]),

        // Individual component modules.
        .library(name: "SDGApplication", targets: ["SDGApplication"])
    ],
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", .upToNextMinor(from: Version(0, 10, 0)))
    ],
    targets: [
        // The entire package.
        .target(name: "SDGInterface", dependencies: [
            "SDGInterfaceElements",
            "SDGApplication"
            ]),

        // Individual component modules.
        .target(name: "SDGApplication", dependencies: [
            "SDGInterfaceLocalizations",
            "SDGInterfaceElements",
            .productItem(name: "SDGLogic", package: "SDGCornerstone")
            ]),
        .target(name: "SDGInterfaceElements", dependencies: [
            "SDGInterfaceLocalizations",
            .productItem(name: "SDGControlFlow", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone")
            ]),

        // Internal
        .target(name: "SDGInterfaceLocalizations", dependencies: [
            .productItem(name: "SDGLocalization", package: "SDGCornerstone")
            ]),

        // Internal tests.
        .testTarget(name: "SDGApplicationTests", dependencies: [
            "SDGApplication",
            "SDGInterfaceLocalizations",
            "SDGInterfaceSample",
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ]),

        .target(name: "SDGInterfaceSample", dependencies: [
            "SDGInterface"
            ])
    ]
)
