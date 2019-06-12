/*
 Label.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGInterfaceLocalizations

#if canImport(AppKit)
public typealias _LabelSuperclass = NSTextField
#else
public typealias _LabelSuperclass = UILabel
#endif

/// A text label.
open class Label<L> : _LabelSuperclass, SharedValueObserver where L : Localization {

    // MARK: - Initialization

    /// Creates a text label.
    ///
    /// - Parameters:
    ///     - text: The text of the label.
    public init(text: Shared<UserFacing<StrictString, L>>) {
        self.labelText = text

        super.init(frame: CGRect.zero)

        text.register(observer: self)
        LocalizationSetting.current.register(observer: self)

        #if canImport(AppKit)
        isBordered = false
        isBezeled = false
        drawsBackground = false
        #endif
        lineBreakMode = .byTruncatingTail

        #if canImport(AppKit)
        if let theCell = self.cell as? NSTextFieldCell {
            theCell.isScrollable = false
            theCell.usesSingleLineMode = true
        }

        isSelectable = false
        isEditable = false
        #endif

        font = Font.forLabels
    }

    @available(*, unavailable) public required init?(coder: NSCoder) { // @exempt(from: unicode)
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Label"
            }
        }))
        return nil
    }

    // MARK: - Properties

    /// The text of the label.
    public var labelText: Shared<UserFacing<StrictString, L>> {
        didSet {
            oldValue.cancel(observer: self)
            labelText.register(observer: self)
        }
    }

    // MARK: - SharedValueObserver

    public func valueChanged(for identifier: String) {
        let string = String(labelText.value.resolved())
        #if canImport(AppKit)
        stringValue = string
        #else
        text = string
        #endif
    }
}
#endif
