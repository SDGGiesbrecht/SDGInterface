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

#warning("Look at coding again.")

/// A precondition failure with a message stating that the type does not support coding.
///
/// - Parameters:
///     - type: The type.
public func codingNotSupported<L>(forType type: UserFacing<StrictString, L>) where L : Localization {
    assertionFailure(UserFacing<StrictString, APILocalization>({ localization in
        switch localization {
        case .englishCanada:
            return "“" + type.resolved() + "” does not support coding."
        }
    }))
}
