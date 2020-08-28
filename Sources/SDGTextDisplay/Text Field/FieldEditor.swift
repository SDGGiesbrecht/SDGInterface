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

    #if !os(tvOS)
      private func insert(text string: Any, at replacementRange: NSRange) {
        if let raw = string as? String {

          #if canImport(AppKit)
            if isFieldEditor {
              super.insertText(String(StrictString(raw)), replacementRange: replacementRange)
              return
            }
          #endif

          var attributes: [NSAttributedString.Key: Any]?
          let possibleStorage: NSTextStorage? = textStorage
          if replacementRange.location ≠ NSNotFound ∧ replacementRange.location
            ≠ possibleStorage?.length
          {
            attributes = possibleStorage?.attributes(
              at: replacementRange.location,
              effectiveRange: nil
            )
          } else if replacementRange.location ≠ NSNotFound ∧ replacementRange.location ≠ 0 {
            attributes = possibleStorage?.attributes(
              at: replacementRange.location − 1,
              effectiveRange: nil
            )
          }
          let attributed = NSAttributedString(
            RichText(NSAttributedString(string: raw, attributes: attributes))
          )
          #if canImport(AppKit)
            super.insertText(attributed, replacementRange: replacementRange)
          #else
            possibleStorage?.replaceCharacters(in: replacementRange, with: attributed)
          #endif
          return
        }
        // @exempt(from: tests) UIKit only handles produces raw text on copy.

        if let attributed = string as? NSAttributedString {
          #if canImport(AppKit)
            if isFieldEditor {
              super.insertText(
                String(StrictString(attributed.string)),
                replacementRange: replacementRange
              )
              return
            }
          #endif

          let normalized = NSAttributedString(RichText(attributed))
          #if canImport(AppKit)
            super.insertText(normalized, replacementRange: replacementRange)
          #else
            textStorage.replaceCharacters(in: replacementRange, with: normalized)
          #endif
          return
        }
        // @exempt(from: tests)

        #if DEBUG
          print("Unidentified text type: (\(type(of: string)))")
        #endif
        #if canImport(AppKit)
          super.insertText(string, replacementRange: replacementRange)
        #endif
      }
      #if canImport(AppKit)
        internal override func insertText(_ string: Any, replacementRange: NSRange) {
          insert(text: string, at: replacementRange)
        }
      #else
        internal override func insertText(_ text: String) {
          super.insertText(String(StrictString(text)))
        }
      #endif

      internal override func paste(_ sender: Any?) {
        #if canImport(AppKit)
          let pasteboard = NSPasteboard.general
        #elseif canImport(UIKit)
          let pasteboard = UIPasteboard.general
        #endif
        let possibleItems: [Any]?
        #if canImport(AppKit)
          possibleItems = pasteboard.readObjects(
            forClasses: [NSAttributedString.self, NSString.self],
            options: nil
          )
        #else
          possibleItems = pasteboard.strings
        #endif
        if let items = possibleItems, ¬items.isEmpty {
          for item in items {
            let range: NSRange
            #if canImport(AppKit)
              range = selectedRange()
            #else
              range = selectedRange
            #endif
            insert(text: item, at: range)
          }
        } else {
          super.paste(sender)  // @exempt(from: tests) Always empty instead of nil.
        }
      }
    #endif
  }
#endif