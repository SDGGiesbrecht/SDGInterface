/*
 HandoffAcceptanceDetails.swift

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
#if canImport(UIKit)
  import UIKit
#endif

/// Details about the acceptance of an activity handoff.
public struct HandoffAcceptanceDetails {

  // MARK: - Initialization

  /// Creates empty details.
  public init() {}

  // MARK: - Properties

  #if canImport(AppKit)
    /// Some systems provide a restoration handler.
    public var restorationHandler: ((_ restorableObjects: [NSUserActivityRestoring]) -> Void)?
  #endif

  #if canImport(UIKit) && !os(watchOS)
    /// Some systems provide a restoration handler.
    public var restorationHandler: ((_ restorableObjects: [UIUserActivityRestoring]) -> Void)?
  #endif
}
