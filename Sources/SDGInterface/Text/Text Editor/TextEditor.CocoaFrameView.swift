/*
 TextEditor.CocoaFrameView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGLogic

  extension TextEditor {

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
    internal class CocoaFrameView: Superclass {

      // MARK: - Initialization

      internal init(
        transparentBackground: Bool,
        logMode: Bool
      ) {

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

      #if !os(tvOS)
        internal func setEditability(_ isEditable: Bool) {
          textView.isEditable = isEditable
        }
      #endif

      // MARK: - Properties

      private let logMode: Bool

      internal var textView: ContentView {
        #if canImport(AppKit)
          return documentView as? ContentView
            ?? ContentView()  // @exempt(from: tests) Never nil.
        #elseif canImport(UIKit)
          return self
        #endif
      }

      // MARK: - Changes

      internal func updateContents(to contents: RichText) {
        let textStorage: NSTextStorage?
        #if canImport(AppKit)
          textStorage = textView.textStorage
        #else
          textStorage = textView.textStorage
        #endif
        textStorage?.setAttributedString(contents.attributedString())

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
#endif
