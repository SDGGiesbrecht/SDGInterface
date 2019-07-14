/*
 TextField.swift

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

import SDGControlFlow
import SDGLogic
import SDGText

import SDGInterfaceBasics
import SDGViews

/// A text field.
public final class TextField : SpecificView {

    // MARK: - Static Set‐Up

    #if canImport(AppKit)
    private static let setUpFieldEditor: Void = {
        _getFieldEditor = {
            return FieldEditor()
        }
        _resetFieldEditors()
    }()
    #endif

    // MARK: - Initialization

    /// Creates a text field.
    public init() {
        #if canImport(AppKit)
        TextField.setUpFieldEditor
        #endif

        #if canImport(AppKit)
        specificNative = NSTextField()
        #else
        specificNative = CocoaTextField()
        #endif

        specificNative.action = #selector(TextFieldBindingObserver.actionOccurred)
        specificNative.target = bindingObserver

        #if canImport(AppKit)
        let cell = NormalizingCell()
        specificNative.cell = cell
        #endif

        #if canImport(AppKit)
        specificNative.isBordered = true
        specificNative.isBezeled = true
        specificNative.bezelStyle = .squareBezel
        specificNative.drawsBackground = true
        specificNative.lineBreakMode = .byClipping
        cell.isScrollable = true
        cell.usesSingleLineMode = true
        cell.sendsActionOnEndEditing = true
        specificNative.isSelectable = true
        specificNative.isEditable = true
        #endif
        specificNative.allowsEditingTextAttributes = false

        specificNative.font = Font.forLabels.native
    }

    // MARK: - Properties

    private let bindingObserver = TextFieldBindingObserver()

    /// The value of the text field.
    public var value: Shared<StrictString> = Shared("") {
        willSet {
            value.cancel(observer: bindingObserver)
        }
        didSet {
            value.register(observer: bindingObserver)
        }
    }

    // MARK: - Refreshing

    internal func refreshBindings() {
        let resolved = String(value.value)
        #if canImport(AppKit)
        specificNative.stringValue = resolved
        #elseif canImport(UIKit)
        specificNative.text = resolved
        #endif
    }

    internal func actionOccurred() {
        let new = StrictString(specificNative.stringValue)
        if new ≠ value.value {
            value.value = StrictString(specificNative.stringValue)
        }
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
    public let specificNative: NSTextField
    #elseif canImport(UIKit)
    public let specificNative: UITextField
    #endif
}
#endif
