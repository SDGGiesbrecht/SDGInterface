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

import SDGInterfaceBasics
import SDGViews

/// A text field with a label.
public final class LabelledTextField<L> : View where L : Localization {

    // MARK: - Initialization

    /// Creates a text field with label text.
    ///
    /// - Parameters:
    /// 	- labelText: The text for the label.
    public convenience init(labelText: Binding<StrictString, L>) {
        let label = Label(text: labelText)
        self.init(label: label)
    }

    /// Creates a text field with label and a text field instances.
    ///
    /// - Parameters:
    ///     - label: The label.
    ///     - field: Optional. A specific field.
    public init(label: Label<L>, field: TextField? = nil) {
        self.label = label
        let constructedField = field ?? TextField()
        self.field = constructedField
        container = AnyNativeView()
        container.position(
            subviews: [label, constructedField],
            inSequenceAlong: .horizontal,
            padding: .automatic,
            margin: .specific(0))
        container.alignLastBaselines(ofSubviews: [label, constructedField])
        container.fill(with: constructedField, on: .vertical)
    }

    // MARK: - Properties

    private let container: AnyNativeView

    /// The label.
    public let label: Label<L>
    /// The field.
    public let field: TextField

    // MARK: - View

    #if canImport(AppKit)
    public var native: NSView {
        return container.native
    }
    #elseif canImport(UIKit)
    public var native: UIView {
        return container.native
    }
    #endif

}
#endif
