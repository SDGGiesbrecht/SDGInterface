/*
 TextFieldNormalizingCell.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SDGControlFlow

  extension TextField {

    internal class NormalizingCell: NSTextFieldCell {

      // MARK: - Initialization

      internal init() {
        super.init(textCell: "")
      }

      internal required init(coder: NSCoder) {
        super.init(coder: coder)  // @exempt(from: tests)
      }

      // MARK: - Field Editor

      private var fieldEditor: FieldEditor?

      internal override func fieldEditor(for aControlView: NSView) -> NSTextView? {
        if let fromWindow = controlView?.window?.fieldEditor(true, for: self) as? FieldEditor {
          return fromWindow
        } else {
          let fromCell = cached(in: &fieldEditor) {
            return FieldEditor()
          }

          // Solves (or at least mitigates) zombie problem, unknown whether it causes leaks.
          let unmanaged = Unmanaged.passRetained(fromCell)
          return unmanaged.takeUnretainedValue()
        }
      }
    }
  }
#endif
