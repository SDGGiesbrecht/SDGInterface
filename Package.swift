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
        .library(name: "SDGInterface", targets: ["SDGInterface"])
    ],
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", .upToNextMinor(from: Version(0, 10, 0)))
    ],
    targets: [
        .target(name: "SDGInterface", dependencies: [
            ]),
        .testTarget(name: "SDGInterfaceTests", dependencies: [
            "SDGInterface",
            .productItem(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ]),

        .target(name: "SDGInterfaceMacOSSample", dependencies: [
            "SDGInterface"
            ])
    ]
)
