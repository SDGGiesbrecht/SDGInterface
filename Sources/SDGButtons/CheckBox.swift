/*
 CheckBox.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit

import SDGText
import SDGLocalization

import SDGInterfaceBasics
import SDGViews

/// A check box.
public final class CheckBox<L> : AnyCheckBox, SpecificView where L : Localization {

    // MARK: - Initialization

    /// Creates a button.
    ///
    /// - Parameters:
    ///     - label: The label on the button.
    public init(label: Binding<StrictString, L>) {
        self.label = label
        defer {
            labelDidSet()
            LocalizationSetting.current.register(observer: bindingObserver)
        }

        specificNative = NSButton()
        defer {
            bindingObserver.checkBox = self
        }

        specificNative.bezelStyle = .rounded
        specificNative.setButtonType(.switch)

        specificNative.lineBreakMode = .byTruncatingTail

        specificNative.font = Font.forLabels.native
    }

    // MARK: - Properties

    private let bindingObserver = CheckBoxBindingObserver()

    /// The label.
    public var label: Binding<StrictString, L> {
        willSet {
            label.shared?.cancel(observer: bindingObserver)
        }
        didSet {
            labelDidSet()
        }
    }
    private func labelDidSet() {
        label.shared?.register(observer: bindingObserver)
    }

    // MARK: - Refreshing

    public func _refreshBindings() {
        let resolved = String(label.resolved())
        specificNative.title = resolved
    }

    // MARK: - SpecificView

    public let specificNative: NSButton
}
#endif
