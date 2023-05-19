/*
 ViewControllerRestorationResponse.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit)
  import UIKit
#endif

/// A response to a request for a view controller during state restoration.
public struct ViewControllerRestorationResponse {

  // MARK: - Initialization

  /// Creates a response.
  public init() {}

  // MARK: - Properties

  #if canImport(UIKit) && !os(watchOS)
    /// The controller.
    public var viewController: UIViewController?
  #endif
}
