/*
 LabelledTextField.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterfaceLocalizations

/// A text field with a label.
open class LabelledTextField<L> : View where L : Localization {

    // MARK: - Components

    /// The label.
    public let label: Label<L>
    /// The field.
    public let field: TextField

    // MARK: - Initialization

    /// Creates a text field with a `Label` and a `TextField`.
    ///
    /// - Parameters:
    ///     - label: The label.
    ///     - field: Optional. A specific field.
    public init(label: Label<L>, field: TextField? = nil) {
        let resolvedField = field ?? TextField()
        self.label = label
        self.field = field ?? TextField()
        super.init(frame: CGRect.zero)
        position(subviews: [label, resolvedField], inSequenceAlong: .horizontal, padding: .system, margin: .none)
        fill(with: resolvedField, on: .vertical, margin: .none)
        alignLastBaselines(ofSubviews: [label, resolvedField])
    }

    @available(*, unavailable) public required init?(coder: NSCoder) { // @exempt(from: unicode)
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "LabelledTextField"
            }
        }))
        return nil
    }
}
