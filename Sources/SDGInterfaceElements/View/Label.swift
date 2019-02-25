/*
 Label.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterfaceLocalizations

/// A text label.
open class Label<L>: NSTextField, SharedValueObserver where L : Localization {

    // MARK: - Initialization

    /// Creates a text label.
    public init(text: Shared<UserFacing<StrictString, L>>) {
        self.text = text

        super.init(frame: NSZeroRect)

        text.register(observer: self)
        LocalizationSetting.current.register(observer: self)

        isBordered = false
        isBezeled = false
        drawsBackground = false
        lineBreakMode = .byTruncatingTail

        if let theCell = self.cell as? NSTextFieldCell {
            theCell.isScrollable = false
            theCell.usesSingleLineMode = true
        }

        isSelectable = false
        isEditable = false

        font = Font.forLabels
    }

    public required init?(coder: NSCoder) {
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Label"
            }
        }))
        return nil
    }

    // MARK: - Properties

    public var text: Shared<UserFacing<StrictString, L>> {
        didSet {
            oldValue.cancel(observer: self)
            text.register(observer: self)
        }
    }

    // MARK: - SharedValueObserver

    public func valueChanged(for identifier: String) {
        stringValue = String(text.value.resolved())
    }
}
