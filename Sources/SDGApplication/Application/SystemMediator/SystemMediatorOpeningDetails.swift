/*
 SystemMediatorOpeningDetails.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Details about opening a file.
public struct SystemMediatorOpeningDetails {

    /// The system is requesting that no user interface be presented.
    public let withoutUserInterface: Bool

    /// The system is requesting that the application remove the file when it is done with it.
    public let asTemporaryFile: Bool

    #if canImport(UIKit)
    /// The options.
    public let options: [UIApplication.OpenURLOptionsKey : Any]
    #endif
}
