/*
 ExtensionDetails.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit)
  import UIKit
#endif

/// Details about an extension.
public struct ExtensionDetails {

  // MARK: - Initialization

  /// Creates empty details.
  public init() {}

  // MARK: - Properties

  #if canImport(UIKit) && !os(watchOS)
    /// Some systems provide the point identifier.
    public var pointIdentifier: UIApplication.ExtensionPointIdentifier?
  #endif
}
