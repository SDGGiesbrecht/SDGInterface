/*
 Button.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterfaceLocalizations

/// A button.
public class Button<L>: NSButton, SharedValueObserver where L : Localization {

    /// Creates a button.
    ///
    /// - Parameters:
    ///     - label: The label.
    public init(label: Shared<UserFacing<StrictString, L>>) {

        self.label = label

        super.init(frame: NSZeroRect)

        bezelStyle = .rounded
        setButtonType(.momentaryPushIn)
        font = Font.forLabels

        label.register(observer: self)
        LocalizationSetting.current.register(observer: self)
    }

    @available(*, unavailable) public required init?(coder: NSCoder) { // @exempt(from: unicode)
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Button"
            }
        }))
        return nil
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
        title = String(label.value.resolved())
    }
}
