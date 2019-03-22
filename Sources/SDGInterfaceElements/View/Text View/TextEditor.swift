/*
 TextEditor.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import SDGInterfaceLocalizations

#if canImport(AppKit)
public typealias TextEditorSuperclass = NSScrollView
#else
public typealias TextEditorSuperclass = View
#endif

/// An editor for multiline text.
public class TextEditor : TextEditorSuperclass {

    // MARK: - Properties

    private var textView = TextView()

    /// Whether or not the background is transparent.
    public var drawsTextBackground: Bool {
        get {
            #if canImport(AppKit)
            return textView.drawsBackground
            #else
            return textView.backgroundColor ≠ nil
            #endif
        }
        set {
            #if canImport(AppKit)
            textView.drawsBackground = newValue
            #else
            if drawsTextBackground ≠ newValue {
                if newValue {
                    textView.backgroundColor = Colour(red: 1, green: 1, blue: 1, alpha: 1)
                } else {
                    textView.backgroundColor = nil
                }
            }
            #endif
        }
    }

    /// Whether or not editing is enabled.
    public var isEditable: Bool {
        get {
            return textView.isEditable
        }
        set {
            textView.isEditable = newValue
        }
    }

    // MARK: - Initialization

    /// Creates a multiline text editor.
    public init() {
        super.init(frame: NSRect.zero)

        documentView = textView

        borderType = NSBorderType.bezelBorder

        horizontalScrollElasticity = NSScrollView.Elasticity.automatic
        verticalScrollElasticity = NSScrollView.Elasticity.automatic

        hasVerticalScroller = true
    }

    @available(*, unavailable) internal required init?(coder: NSCoder) {
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "TextEditor"
            }
        }))
        return nil
    }

    // MARK: - Modifying content.

    /// Appends text to the content and scrolls to its position.
    public func append(_ appendix: RichText) {
        textView.textStorage?.append(NSAttributedString(appendix))
        let content = textView.string
        textView.scrollRangeToVisible(NSRange(content.endIndex..., in: content))
    }
}
