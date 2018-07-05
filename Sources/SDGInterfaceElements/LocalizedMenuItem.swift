/*
 LocalizedMenuItem.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterfaceLocalizations

open class LocalizedMenuItem<L : Localization> : MenuItem, SharedValueObserver {

    // MARK: - Initialization

    public init(label: Shared<UserFacing<StrictString, L>>, action: Selector? = nil, keyEquivalent: String? = nil, modifierMask: NSEvent.ModifierFlags = [], target: AnyObject? = nil, indented: Bool = false) {

        self.label = label
        self.indented = indented

        super.init(title: label.value.resolved(indented: indented), action: action, keyEquivalent: keyEquivalent ?? "")

        self.target = target

        LocalizationSetting.current.register(observer: self)
    }

    @available(*, unavailable) public required init(coder decoder: NSCoder) {
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "MenuItem"
            }
        }))
    }

    // MARK: - Properties

    /// The label.
    public var label: Shared<UserFacing<StrictString, L>>

    /// Whether the label is indented.
    public var indented: Bool

    // MARK: - SharedValueObserver

    // [_Inherit Documentation: SDGCornerstone.SharedValueObserver.valueChanged(for:)_]
    /// Called when a value changes.
    ///
    /// - Parameters:
    ///     - identifier: The identifier that was specified when the observer was registered. This can be used to differentiate between several values watched by the same observer.
    ///
    /// - SeeAlso: `register(observer:identifier)`
    public func valueChanged(for identifier: String) {
        self.title = label.value.resolved(indented: indented)
    }
}

extension UserFacing where Element == StrictString {

    fileprivate func resolved(indented: Bool) -> String {
        var result = resolved()
        if indented {
            result.prepend("\u{9}")
        }
        return String(result)
    }
}
