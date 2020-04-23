/*
 TextEditor.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGViews

  /// An editor for multiline text.
  public final class TextEditor: CocoaViewImplementation, View {

    // MARK: - Initialization

    /// Creates a multiline text editor.
    public init() {

      #if canImport(AppKit)
        frameView = NSScrollView()
        frameView.documentView = TextView()
      #else
        frameView = TextView()
      #endif

      #if canImport(AppKit)
        frameView.borderType = .bezelBorder

        frameView.horizontalScrollElasticity = .automatic
        frameView.verticalScrollElasticity = .automatic

        frameView.hasVerticalScroller = true
      #endif
    }

    // MARK: - Properties

    #if canImport(AppKit)
      private let frameView: NSScrollView
    #elseif canImport(UIKit)
      private let frameView: UITextView
    #endif

    /// Whether or not the background is transparent.
    public var drawsBackground: Bool {
      get {
        #if canImport(AppKit)
          return cocoaTextView.drawsBackground
        #else
          return cocoaTextView.backgroundColor ≠ nil
        #endif
      }
      set {
        #if canImport(AppKit)
          cocoaTextView.drawsBackground = newValue
        #else
          if drawsBackground ≠ newValue {
            if newValue {
              cocoaTextView.backgroundColor = .white
            } else {
              cocoaTextView.backgroundColor = nil
            }
          }
        #endif
      }
    }

    #if !os(tvOS)
      /// Whether or not editing is enabled.
      public var isEditable: Bool {
        get {
          return cocoaTextView.isEditable
        }
        set {
          cocoaTextView.isEditable = newValue
        }
      }
    #endif

    // MARK: - Modifying content.

    /// Appends text to the content and scrolls to its position.
    ///
    /// - Parameters:
    ///     - appendix: The text to append.
    public func append(_ appendix: RichText) {

      let possibleStorage: NSTextStorage?
      #if canImport(AppKit)
        possibleStorage = cocoaTextView.textStorage
      #elseif canImport(UIKit)
        possibleStorage = cocoaTextView.textStorage
      #endif

      possibleStorage?.append(NSAttributedString(appendix))

      let content: String
      #if canImport(AppKit)
        content = cocoaTextView.string
      #else
        content = cocoaTextView.text
      #endif

      let range = NSRange(content.endIndex..., in: content)

      cocoaTextView.scrollRangeToVisible(range)
    }

    // MARK: - LegacyView

    public func cocoa() -> CocoaView {
      return CocoaView(frameView)
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
      /// The Cocoa text view.
      public var cocoaTextView: NSTextView {
        return frameView.documentView as? NSTextView
          ?? NSTextView()  // @exempt(from: tests) Never nil.
      }
    #elseif canImport(UIKit)
      /// The Cocoa text view.
      public var cocoaTextView: UITextView {
        return frameView
      }
    #endif
  }
#endif
