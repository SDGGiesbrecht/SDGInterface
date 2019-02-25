/*
 Label.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterfaceLocalizations

#warning("Rethink binding.")

/// A text label.
open class Label: NSTextField {

    // MARK: - Initialization

    /// Creates a text label.
    public init(text: StrictString) {
        super.init(frame: NSZeroRect)

        isBordered = false
        isBezeled = false
        drawsBackground = false
        lineBreakMode = .byTruncatingTail

        if let theCell = self.cell as? NSTextFieldCell {
            theCell.isScrollable = false
            theCell.usesSingleLineMode = true
        }

        isSelectable = false
        isEditable = false

        font = Font.forLabels

        stringValue = String(text)
    }

    public required init?(coder: NSCoder) {
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Label"
            }
        }))
        return nil
    }
}
