/*
 MenuBarAction.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension MenuBar {

    public struct Action {

        // MARK: - Static Properties

        /// The action which opens the preferences.
        public static let openPreferences: Action = Action(
            selector: #selector(NSApplicationDelegate.openPreferences(_:)))

        // MARK: - Initialization

        /// Creates an action.
        ///
        /// - Parameters:
        ///     - selector: The selector.
        public init(selector: Selector) {
            self.selector = selector
        }

        // MARK: - Properties

        /// The selector.
        public let selector: Selector
    }
}
