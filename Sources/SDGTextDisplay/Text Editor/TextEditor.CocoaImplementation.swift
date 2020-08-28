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

    // #warning(No access to editing disabled or log mode yet.)
    #if canImport(AppKit)
      internal typealias Superclass = NSScrollView
    #else
      internal typealias Superclass = CocoaDocumentView
    #endif
    #if canImport(AppKit)
      internal typealias ContentView = NSTextView
    #else
      internal typealias ContentView = UITextView
    #endif
    internal class CocoaImplementation: Superclass, SharedValueObserver {

      // MARK: - Initialization

      internal init(
        contents: Shared<RichText>,
        isEditable: Bool,
        transparentBackground: Bool,
        logMode: Bool
      ) {
        self.contents = contents
        defer { contents.register(observer: self) }

        defer {
          textView.isEditable = isEditable
        }

        defer {
          #if canImport(AppKit)
            textView.drawsBackground = ¬transparentBackground
          #else
            textView.backgroundColor = transparentBackground ? nil : .white
          #endif
        }

        self.logMode = logMode

        #if canImport(AppKit)
          super.init(frame: .zero)
          documentView = CocoaDocumentView()
        #else
          super.init()
        #endif

        textView.delegate = self

        #if canImport(AppKit)
          borderType = .bezelBorder

          horizontalScrollElasticity = .automatic
          verticalScrollElasticity = .automatic

          hasVerticalScroller = true
        #endif
      }

      internal required init?(coder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let contents: Shared<RichText>
      private let logMode: Bool

      private var textView: ContentView {
        #if canImport(AppKit)
          return documentView as? ContentView
            ?? ContentView()  // @exempt(from: tests) Never nil.
        #elseif canImport(UIKit)
          return self
        #endif
      }

      // MARK: - Changes

      internal func contentsChanged() {
        #if canImport(AppKit)
          let newValue = textView.attributedString()
        #else
          let newValue = textView.attributedText ?? NSAttributedString()
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
          existingValue = textView.attributedText ?? NSAttributedString()
        #endif
        let textStorage: NSTextStorage?
        #if canImport(AppKit)
          textStorage = textView.textStorage
        #else
          textStorage = textView.textStorage
        #endif
        if existingValue ≠ newValue {
          textStorage?.setAttributedString(contents.value.attributedString())

          if logMode {
            let content: String
            #if canImport(AppKit)
              content = textView.string
            #else
              content = textView.text
            #endif
            let range = NSRange(content.endIndex..., in: content)
            textView.scrollRangeToVisible(range)
          }
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
