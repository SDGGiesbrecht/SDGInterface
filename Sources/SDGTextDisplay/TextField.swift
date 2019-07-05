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

        specificNative.font = Font.forLabels
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
    public var specificNative: NSTextField
    #elseif canImport(UIKit)
    public var specificNative: UITextField
    #endif
}
#endif
