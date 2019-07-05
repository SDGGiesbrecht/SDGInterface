
#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

import SDGViews

/// An editor for multiline text.
public final class TextEditor: SpecificView {

    // MARK: - Initialization

    /// Creates a multiline text editor.
    public init() {

        #if canImport(AppKit)
        specificNative = NSScrollView()
        specificNative.documentView = NSTextView()
        #else
        specificNative = UITextView()
        #endif

        #if canImport(AppKit)
        specificNative.borderType = .bezelBorder

        specificNative.horizontalScrollElasticity = .automatic
        specificNative.verticalScrollElasticity = .automatic

        specificNative.hasVerticalScroller = true
        #endif
    }

    // MARK: - Properties

    /// Whether or not the background is transparent.
    public var drawsBackground: Bool {
        get {
            #if canImport(AppKit)
            return nativeTextView.drawsBackground
            #else
            return specificNative.backgroundColor ≠ nil
            #endif
        }
        set {
            #if canImport(AppKit)
            nativeTextView.drawsBackground = newValue
            #else
            if drawsBackground ≠ newValue {
                if newValue {
                    specificNative.backgroundColor = .white
                } else {
                    specificNative.backgroundColor = nil
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
        let possibleStorage: NSTextStorage? = textView.textStorage
        possibleStorage?.append(NSAttributedString(appendix))
        let content: String
        #if canImport(AppKit)
        content = textView.string
        #else
        content = textView.text
        #endif
        textView.scrollRangeToVisible(NSRange(content.endIndex..., in: content))
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
    public var specificNative: NSScrollView
    /// The native text view.
    public var nativeTextView: NSTextView
    #elseif canImport(UIKit)
    public var specificNative: UITextView
    #endif
}
#endif
