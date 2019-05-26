/*
 CheckBoxCell.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SDGInterfaceLocalizations

/// A check box table cell.
public class CheckBoxCell<L> : TableCellView where L : Localization {

    // MARK: - Initialization

    /// Creates a check box cell.
    public init() {
        checkBox = CheckBox(label: Shared(UserFacing<StrictString, L>({ _ in "" })))
        super.init(frame: NSZeroRect)
        fill(with: checkBox, on: .horizontal, margin: .specific(checkBox.fittingSize.height ÷ 16))
        fill(with: checkBox, on: .vertical, margin: .none)
    }

    @available(*, unavailable) public required init?(coder decoder: NSCoder) { // @exempt(from: unicode)
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "CheckBoxCell"
            }
        }))
        return nil
    }

    // MARK: - Properties

    private var checkBox: CheckBox<L>

    // MARK: - Layout

    /// :nodoc:
    public override var minimumHeight: CGFloat {
        return LabelCell<L>().minimumHeight
    }

    // MARK: - Binding

    /// Binds the label to a content property.
    ///
    /// - Parameters:
    ///     - contentKeyPath: The key path of the content’s property.
    public func bindLabel(contentKeyPath: String) {
        bind(subview: checkBox, keyPath: .label, to: contentKeyPath)
    }

    /// Binds the state to a content property.
    ///
    /// - Parameters:
    ///     - contentKeyPath: The key path of the content’s property.
    public func bindState(contentKeyPath: String) {
        bind(subview: checkBox, keyPath: .value, to: contentKeyPath)
    }
}
