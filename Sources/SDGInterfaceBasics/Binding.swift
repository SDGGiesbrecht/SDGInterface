/*
 Binding.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText
import SDGLocalization

/// An element of the user interface which can be either bound to a data model or to a static localized value.
public enum Binding<T, L> where L : Localization {

    // MARK: - Cases

    /// A static value.
    case `static`(UserFacing<T, L>)

    /// A binding to a data model.
    case binding(Shared<T>)

    // MARK: - Resolution

    /// Returns the resolved value of the binding.
    public func resolved() -> T {
        switch self {
        case .static(let localized):
            return localized.resolved()
        case .binding(let shared):
            return shared.value
        }
    }

    /// Convenience access to the shared instance of the `binding` case.
    public var shared: Shared<T>? {
        switch self {
        case .static:
            return nil
        case .binding(let shared):
            return shared
        }
    }
}
