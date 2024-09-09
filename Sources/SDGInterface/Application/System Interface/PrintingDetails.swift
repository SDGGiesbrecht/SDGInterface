/*
 PrintingDetails.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit
#endif

/// Details about printing.
public struct PrintingDetails {

  // MARK: - Initialization

  /// Creates empty details.
  public init() {}

  // MARK: - Properties

  #if canImport(AppKit)
    /// Some systems specify settings.
    public var settings: [NSPrintInfo.AttributeKey: Any] = [:]
  #endif

  /// Some systems may specify whether or not to display customization panels.
  public var displayPanels: Bool? = nil
}
