/*
 LabelledTextField.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

import SDGText
import SDGLocalization

import SDGViews

/// A text field with a label.
open class LabelledTextField<L> : SpecificView where L : Localization {

    // MARK: - Initialization

    /// Creates a text field with label text.
    ///
    /// - Parameters:
    /// 	- labelText: The text for the label.
    public init(labelText: Binding<StrictString, L>) {
        label = Label(text: Shared(labelText))
        field = TextField()
        super.init(frame: CGRect.zero)
        finishInitialization()
    }

    /// Creates a text field with label and a text field instances.
    ///
    /// - Parameters:
    ///     - label: The label.
    ///     - field: Optional. A specific field.
    public init(label: Label<L>, field: TextField? = nil) {
        self.label = label
        self.field = field ?? TextField()
        super.init(frame: CGRect.zero)
        finishInitialization()
    }

    private func finishInitialization() {
        position(subviews: [label, field], inSequenceAlong: .horizontal, padding: .system, margin: .none)
        fill(with: field, on: .vertical, margin: .none)
        alignLastBaselines(ofSubviews: [label, field])
    }

    // MARK: - Properties

    private let container: ContainerView

    /// The label.
    public let label: Label<L>
    /// The field.
    public let field: TextField

    // MARK: - SpecificView
}
#endif
