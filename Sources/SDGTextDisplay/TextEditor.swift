/*
 TextEditor.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
  public final class TextEditor: CocoaImplementation, SpecificView {

    // MARK: - Initialization

    /// Creates a multiline text editor.
    public init() {

      #if canImport(AppKit)
        specificCocoaView = NSScrollView()
        specificCocoaView.documentView = TextView()
      #else
        specificCocoaView = TextView()
      #endif

      #if canImport(AppKit)
        specificCocoaView.borderType = .bezelBorder

        specificCocoaView.horizontalScrollElasticity = .automatic
        specificCocoaView.verticalScrollElasticity = .automatic

        specificCocoaView.hasVerticalScroller = true
      #endif
    }

    // MARK: - Properties

    /// Whether or not the background is transparent.
    public var drawsBackground: Bool {
      get {
        #if canImport(AppKit)
          return nativeTextView.drawsBackground
        #else
          return nativeTextView.backgroundColor ≠ nil
        #endif
      }
      set {
        #if canImport(AppKit)
          nativeTextView.drawsBackground = newValue
        #else
          if drawsBackground ≠ newValue {
            if newValue {
              nativeTextView.backgroundColor = .white
            } else {
              nativeTextView.backgroundColor = nil
            }
          }
        #endif
      }
    }

    #if !os(tvOS)
      /// Whether or not editing is enabled.
      public var isEditable: Bool {
        get {
          return nativeTextView.isEditable
        }
        set {
          nativeTextView.isEditable = newValue
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
        possibleStorage = nativeTextView.textStorage
      #elseif canImport(UIKit)
        possibleStorage = nativeTextView.textStorage
      #endif

      possibleStorage?.append(NSAttributedString(appendix))

      let content: String
      #if canImport(AppKit)
        content = nativeTextView.string
      #else
        content = nativeTextView.text
      #endif

      let range = NSRange(content.endIndex..., in: content)

      nativeTextView.scrollRangeToVisible(range)
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
      public let specificCocoaView: NSScrollView
    #elseif canImport(UIKit)
      public let specificCocoaView: UITextView
    #endif

    #if canImport(AppKit)
      /// The native text view.
      public var nativeTextView: NSTextView {
        return specificCocoaView.documentView as? NSTextView
          ?? NSTextView()  // @exempt(from: tests) Never nil.
      }
    #elseif canImport(UIKit)
      /// The native text view.
      public var nativeTextView: UITextView {
        return specificCocoaView
      }
    #endif
  }
#endif
