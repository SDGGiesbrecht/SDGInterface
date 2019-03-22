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

#if canImport(AppKit)
public typealias LabelSuperclass = NSTextField
#else
public typealias LabelSuperclass = UILabel
#endif

/// A text label.
open class Label<L>: LabelSuperclass, SharedValueObserver where L : Localization {

    // MARK: - Initialization

    /// Creates a text label.
    public init(text: Shared<UserFacing<StrictString, L>>) {
        self.labelText = text

        super.init(frame: CGRect.zero)

        text.register(observer: self)
        LocalizationSetting.current.register(observer: self)

        #if canImport(AppKit)
        isBordered = false
        isBezeled = false
        drawsBackground = false
        #else
        #warning("iOS?")
        #endif
        lineBreakMode = .byTruncatingTail

        #if canImport(AppKit)
        if let theCell = self.cell as? NSTextFieldCell {
            theCell.isScrollable = false
            theCell.usesSingleLineMode = true
        }

        isSelectable = false
        isEditable = false
        #else
        #warning("iOS?")
        #endif

        font = Font.forLabels
    }

    @available(*, unavailable) public required init?(coder: NSCoder) {
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Label"
            }
        }))
        return nil
    }

    // MARK: - Properties

    public var labelText: Shared<UserFacing<StrictString, L>> {
        didSet {
            oldValue.cancel(observer: self)
            labelText.register(observer: self)
        }
    }

    // MARK: - SharedValueObserver

    public func valueChanged(for identifier: String) {
        stringValue = String(labelText.value.resolved())
    }
}
