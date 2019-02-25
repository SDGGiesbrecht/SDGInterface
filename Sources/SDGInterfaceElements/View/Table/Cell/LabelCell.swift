/*
 LabelCell.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SDGInterfaceLocalizations

#warning("Rethink binding.")

/// A label table cell.
open class LabelCell: NSTableCellView {

    // MARK: - Properties

    private var label: Label

    // MARK: - Initialization

    /// Creates a label table cell.
    public init() {
        label = Label(text: "")
        super.init(frame: NSRect.zero)

        fill(with: label, on: .horizontal, margin: .specific(label.fittingSize.height ÷ 16))
        fill(with: label, on: .vertical, margin: .none)
    }

    public required init?(coder decoder: NSCoder) {
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "LabelCell"
            }
        }))
        return nil
    }

    // MARK: - Binding

    /// Binds the text to a content property.
    public func bindText(contentKeyPath: String) {
        bind(subview: label, keyPath: .value, to: contentKeyPath)
    }

    /// Binds the text colour to a content property.
    public func bindTextColour(contentKeyPath: String) {
        bind(subview: label, keyPath: .textColor, to: contentKeyPath)
    }
}
