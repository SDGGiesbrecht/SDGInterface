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

    #if canImport(AppKit)
      internal typealias Superclass = NSScrollView
    #else
      internal typealias Superclass = TextView
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
          documentView = TextView()
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

      // MARK: - SharedValueObserver
      
      internal func valueChanged(for identifier: String) {
        textView.textStorage?.setAttributedString(contents.value.attributedString())

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
