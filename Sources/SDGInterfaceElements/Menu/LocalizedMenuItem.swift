/*
 LocalizedMenuItem.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS) && !os(tvOS)

import SDGInterfaceLocalizations

/// A localized menu item.
open class LocalizedMenuItem<L : Localization> : NSMenuItem, SharedValueObserver {

    // MARK: - Initialization

    /// Creates a localized menu item with the specified label and action.
    ///
    /// - Parameters:
    ///     - label: A label for the menu item.
    ///     - action: (Optional.) An action for the menu item.
    public init(label: Shared<UserFacing<StrictString, L>>, action: Selector? = nil) {

        self.label = label

        let startingTitle = String(label.value.resolved())
        #if canImport(AppKit)
        super.init(title: startingTitle, action: action, keyEquivalent: "")
        #elseif canImport(UIKit)
        super.init(title: startingTitle, action: action ?? #selector(NSObject._placeholderMethod))
        #endif

        LocalizationSetting.current.register(observer: self)
    }

    @available(*, unavailable) public required init(coder decoder: NSCoder) { // @exempt(from: unicode)
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "LocalizedMenuItem"
            }
        }))
        preconditionFailure()
    }

    // MARK: - Properties

    /// The label.
    public var label: Shared<UserFacing<StrictString, L>>

    // MARK: - SharedValueObserver

    public func valueChanged(for identifier: String) {
        self.title = String(label.value.resolved())
    }
}

#endif
