/*
 Menu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit

import SDGControlFlow
import SDGText
import SDGLocalization
import SDGInterfaceLocalizations

/// A localized menu.
open class Menu<L : Localization> : NSMenu, SharedValueObserver {

    // MARK: - Initialization

    /// Creates a localized menu with the specified label.
    ///
    /// - Parameters:
    ///     - label: A label for the menu.
    public init(label: Shared<UserFacing<StrictString, L>>) {
        self.label = label
        super.init(title: String(label.value.resolved()))
        label.register(observer: self)
        LocalizationSetting.current.register(observer: self)
    }

    @available(*, unavailable) public required init(coder decoder: NSCoder) { // @exempt(from: unicode)
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Menu"
            }
        }))
        preconditionFailure()
    }

    // MARK: - Properties

    /// The label.
    public var label: Shared<UserFacing<StrictString, L>> {
        didSet {
            oldValue.cancel(observer: self)
            label.register(observer: self)
        }
    }

    // MARK: - SharedValueObserver

    public func valueChanged(for identifier: String) {
        self.title = String(label.value.resolved())
    }
}
#endif
