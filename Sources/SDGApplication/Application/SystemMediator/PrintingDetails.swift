/*
 PrintingDetails.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Details about printing.
public struct PrintingDetails {

    #if canImport(AppKit)
    /// The settings.
    public var settings: [NSPrintInfo.AttributeKey : Any]
    #endif

    #if canImport(AppKit)
    /// Whether or not to display customization panels.
    public var displayPanels: Bool
    #endif
}
