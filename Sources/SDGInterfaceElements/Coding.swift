/*
 Coding.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterfaceLocalizations

// @documentation(codingNotSupported)
/// Do not use. This type does not support coding.

/// A precondition failure with a message stating that the type does not support coding.
///
/// - Parameters:
///     - type: The type.
public func codingNotSupported<L>(forType type: UserFacing<StrictString, L>) -> Never where L : Localization {
    preconditionFailure(UserFacing<StrictString, APILocalization>({ localization in
        switch localization {
        case .englishCanada:
            return "“" + type.resolved() + "” does not support coding."
        }
    }))
}
