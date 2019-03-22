/*
 TextFieldNormalizingCell.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import SDGInterfaceLocalizations

extension TextField {

    internal class NormalizingCell: NSTextFieldCell {

        // MARK: - Initialization

        internal init() {
            super.init(textCell: "")
        }

        @available(*, unavailable) internal required init(coder: NSCoder) {
            codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
                switch localization {
                case .englishCanada:
                    return "TextField.NormalizingCell"
                }
            }))
            preconditionFailure()
        }

        // MARK: - Field Editor

        private let fieldEditor = FieldEditor()

        internal override func fieldEditor(for aControlView: NSView) -> NSTextView? {
            // Solves (or at least mitigates) zombie problem, unknown whether it causes leaks.
            let unmanaged = Unmanaged.passRetained(fieldEditor)
            return unmanaged.takeUnretainedValue()
        }
    }
}
#endif
