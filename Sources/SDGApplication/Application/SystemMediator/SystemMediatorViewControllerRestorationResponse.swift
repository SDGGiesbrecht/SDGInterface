/*
 SystemMediatorViewControllerRestorationResponse.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A response to a request for a view controller during state restoration.
public struct SystemMediatorViewControllerRestorationResponse {

    // MARK: - Initialization

    /// Creates a response.
    public init() {}

    // MARK: - Properties

    #if canImport(UIKit)
    /// The controller.
    public var viewController: UIViewController?
    #endif
}
