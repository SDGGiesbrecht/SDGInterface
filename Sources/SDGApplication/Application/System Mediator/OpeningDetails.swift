/*
 OpeningDetails.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Details about opening a file.
public struct OpeningDetails {

    // MARK: - Initialization

    /// Creates empty details.
    public init() {}

    // MARK: - Properties

    /// Some systems specify whether a user interface should be presented.
    public var withoutUserInterface: Bool?

    /// Some systems specify whether the application should remove the file when it is done with it.
    public var asTemporaryFile: Bool?

    #if canImport(UIKit) && !os(watchOS)
    /// Some systems specify options.
    public var options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    #endif
}
