/*
 Label.swift

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

/// A text label.
public final class Label<L> : AnyLabel, SpecificView where L : Localization {

    // MARK: - Initialization

    /// Creates a text label.
    ///
    /// - Parameters:
    ///     - text: The text of the label.
    public init(text: Binding<StrictString, L>) {
        self.text = text
        defer {
            textDidSet()
            LocalizationSetting.current.register(observer: bindingObserver)
        }

        #if canImport(AppKit)
        specificNative = NSTextField(labelWithString: "")
        #elseif canImport(UIKit)

        #endif

        #if canImport(AppKit)
        specificNative.isBordered = false
        specificNative.isBezeled = false
        specificNative.drawsBackground = false
        #endif
        specificNative.lineBreakMode = .byTruncatingTail

        #if canImport(AppKit)
        if let cell = specificNative.cell as? NSTextFieldCell {
            cell.isScrollable = false
            cell.usesSingleLineMode = true
        }

        specificNative.isSelectable = false
        specificNative.isEditable = false
        #endif

        font = Font.forLabels
    }

    // MARK: - Properties

    private let bindingObserver = BindingObserver()

    /// The text.
    public var text: Binding<StrictString, L> {
        willSet {
            text.shared?.cancel(observer: bindingObserver)
        }
        didSet {
            textDidSet()
        }
    }
    private func textDidSet() {
        text.shared?.register(observer: bindingObserver)
    }

    // MARK: - Refreshing

    public func _refreshBindings() {
        let resolved = String.name.resolved()
        #if canImport(AppKit)
        specificNative.stringValue = resolved
        #elseif canImport(UIKit)
        specificNative.text = resolved
        #endif
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
    public var specificNative: NSTextField
    #elseif canImport(UIKit)
    public var specificNative: UILabel
    #endif
}
#endif
