/*
 TextEditor.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  extension TextEditor {

    internal class CocoaImplementation: CocoaFrameView, SharedValueObserver {

      // MARK: - Initialization

      internal init(
        contents: Shared<RichText>,
        transparentBackground: Bool,
        logMode: Bool
      ) {
        self.contents = contents
        defer { contents.register(observer: self) }
        defer { textView.delegate = self }

        super.init(
          transparentBackground: transparentBackground,
          logMode: logMode
        )
      }

      internal required init?(coder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let contents: Shared<RichText>

      // MARK: - Changes

      internal func contentsChanged() {
        #if canImport(AppKit)
          let newValue = textView.attributedString()
        #else
          let newValue = textView.attributedText
            ?? NSAttributedString() // @exempt(from: tests) Never nil.
        #endif
        if newValue ≠ contents.value.attributedString() {
          contents.value = RichText(newValue)
        }
      }

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        let newValue = contents.value.attributedString()
        let existingValue: NSAttributedString
        #if canImport(AppKit)
          existingValue = textView.attributedString()
        #else
          existingValue = textView.attributedText
            ?? NSAttributedString() // @exempt(from: tests) Never nil.
        #endif
        if existingValue ≠ newValue {
          updateContents(to: contents.value)
        }
      }
    }
  }

  #if canImport(AppKit)
    extension TextEditor.CocoaImplementation: NSTextViewDelegate {
      internal func textDidChange(_ notification: Notification) {
        contentsChanged()
      }
    }
  #else
    extension TextEditor.CocoaImplementation: UITextViewDelegate {
      internal func textViewDidChange(_ textView: UITextView) {
        contentsChanged()
      }
    }
  #endif
#endif
