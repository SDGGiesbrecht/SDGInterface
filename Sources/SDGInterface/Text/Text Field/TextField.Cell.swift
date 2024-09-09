/*
 TextField.Cell.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  extension TextField {

    internal class Cell: NSTextFieldCell {

      // MARK: - Properties

      private let fieldEditor: TextEditor.CocoaDocumentView = {
        let editor = TextEditor.CocoaDocumentView()
        editor.isFieldEditor = true
        return editor
      }()

      // MARK: - NSTextFieldCell

      internal override func fieldEditor(for aControlView: NSView) -> NSTextView? {
        return fieldEditor
      }
    }
  }
#endif
