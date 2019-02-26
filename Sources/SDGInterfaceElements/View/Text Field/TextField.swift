/*
 TextField.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterfaceLocalizations

/// A text field.
open class TextField: NSTextField {

    // MARK: - Initialization

    /// Creates a text field.
    public init() {
        super.init(frame: NSZeroRect)
        let cell = NormalizingCell()
        self.cell = cell

        isBordered = true
        isBezeled = true
        bezelStyle = .squareBezel
        drawsBackground = true
        lineBreakMode = .byClipping
        cell.isScrollable = true
        cell.usesSingleLineMode = true
        cell.sendsActionOnEndEditing = true
        isSelectable = true
        isEditable = true
        allowsEditingTextAttributes = false

        font = Font.forLabels
    }

    @available(*, unavailable) required public init?(coder: NSCoder) {
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "TextField"
            }
        }))
        return nil
    }
}
