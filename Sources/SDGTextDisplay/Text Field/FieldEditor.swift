/*
 FieldEditor.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SDGLogic
  import SDGMathematics
  import SDGText

  import SDGInterfaceLocalizations

  internal class FieldEditor: TextEditor.CocoaDocumentView {

    // MARK: - Initialization

    internal override init() {
      super.init()
      self.isFieldEditor = true
    }
    internal required init?(coder: NSCoder) {  // @exempt(from: tests)
      super.init(coder: coder)
    }

    // MARK: - Normalization

    private func insert(text string: Any, at replacementRange: NSRange) {

      if let raw = string as? String {
        super.insertText(String(StrictString(raw)), replacementRange: replacementRange)
        return
      }

      if let attributed = string as? NSAttributedString {
        super.insertText(
          String(StrictString(attributed.string)),
          replacementRange: replacementRange
        )
        return
      }
      // @exempt(from: tests)

      #if DEBUG
        print("Unidentified text type: (\(type(of: string)))")
      #endif
      super.insertText(string, replacementRange: replacementRange)
    }
    internal override func insertText(_ string: Any, replacementRange: NSRange) {
      insert(text: string, at: replacementRange)
    }

    internal override func paste(_ sender: Any?) {
      let pasteboard = NSPasteboard.general
      let possibleItems: [Any]?
      possibleItems = pasteboard.readObjects(
        forClasses: [NSAttributedString.self, NSString.self],
        options: nil
      )
      if let items = possibleItems, ¬items.isEmpty {
        for item in items {
          let range: NSRange
          range = selectedRange()
          insert(text: item, at: range)
        }
      } else {
        super.paste(sender)  // @exempt(from: tests) Always empty instead of nil.
      }
    }
  }
#endif
