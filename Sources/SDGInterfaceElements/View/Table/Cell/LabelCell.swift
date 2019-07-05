/*
 LabelCell.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit

import SDGControlFlow
import SDGMathematics
import SDGText
import SDGLocalization

import SDGTextDisplay

import SDGInterfaceLocalizations

/// A label table cell.
open class LabelCell<L> : TableCellView where L : Localization {

    // MARK: - Properties

    private let label: Label<L>

    // MARK: - Initialization

    /// Creates a label table cell.
    public init() {
        label = Label(text: .binding(Shared("")))
        super.init(frame: CGRect.zero)

        fill(with: label.native, on: .horizontal, margin: .specific(label.native.fittingSize.height ÷ 16))
        fill(with: label.native, on: .vertical, margin: .none)
    }

    @available(*, unavailable) public required init?(coder decoder: NSCoder) { // @exempt(from: unicode)
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
    ///
    /// - Parameters:
    ///     - contentKeyPath: The key path of the content’s property.
    public func bindText(contentKeyPath: String) {
        bind(subview: label.native, keyPath: .value, to: contentKeyPath)
    }

    /// Binds the text colour to a content property.
    ///
    /// - Parameters:
    ///     - contentKeyPath: The key path of the content’s property.
    public func bindTextColour(contentKeyPath: String) {
        bind(subview: label.native, keyPath: .textColor, to: contentKeyPath)
    }
}
#endif
