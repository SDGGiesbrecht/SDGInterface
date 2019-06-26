/*
 TextEditingResponder.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// An object which responds to actions related to editing text.
@objc public protocol TextEditingResponder : TextDisplayResponder {

    /// Normalizes the selection to NFKD.
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc func normalizeText(_ sender: Any?)
}
