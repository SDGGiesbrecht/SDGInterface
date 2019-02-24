/*
 TextView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

internal class TextView: NSTextView {

    internal init() {
        let prototype = NSTextView()
        super.init(frame: NSZeroRect, textContainer: prototype.textContainer)

        maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        isVerticallyResizable = true
        autoresizingMask = NSView.AutoresizingMask.width

        allowsUndo = true
        usesFindPanel = true

        isContinuousSpellCheckingEnabled = true
        isAutomaticSpellingCorrectionEnabled = false
        isGrammarCheckingEnabled = true

        isAutomaticLinkDetectionEnabled = false
        isAutomaticQuoteSubstitutionEnabled = true
        isAutomaticDashSubstitutionEnabled = true
        isAutomaticDataDetectionEnabled = false
        isAutomaticTextReplacementEnabled = true
        smartInsertDeleteEnabled = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Normalization

    override func insertText(_ string: Any, replacementRange: NSRange) {
        if let raw = string as? String {
            if ¬isFieldEditor {
                var attributes: [NSAttributedString.Key: Any]?
                if replacementRange.location ≠ NSNotFound ∧ replacementRange.location ≠ textStorage?.length {
                    attributes = textStorage?.attributes(at: replacementRange.location, effectiveRange: nil)
                } else if replacementRange.location ≠ NSNotFound ∧ replacementRange.location ≠ 0 {
                    attributes = textStorage?.attributes(at: replacementRange.location - 1, effectiveRange: nil)
                }
                let attributed = RichText(NSAttributedString(string: string, attributes: attributes))
                super.insertText(NSAttributedString(attributed), replacementRange: replacementRange)
            } else {
                super.insertText(String(StrictString(raw)), replacementRange: replacementRange)
            }
        } else if let attributed = string as? NSAttributedString {
            if ¬isFieldEditor {
                super.insertText(NSAttributedString(RichText(string)), replacementRange: replacementRange)
            } else {
                super.insertText(String(StrictString(attributed.string)), replacementRange: replacementRange)
            }
        } else {
            if BuildConfiguration.current == .debug {
                assertionFailure("Unidentified type of text. (\(type(of: string)))")
            }
            super.insertText(string, replacementRange: replacementRange)
        }
    }

    override func paste(_ sender: Any?) {
        let pasteboard = NSPasteboard.general
        if let items = pasteboard.readObjects(forClasses: [NSAttributedString.self, NSString.self], options: nil) {
            for item in items {
                insertText(item, replacementRange: selectedRange())
            }
        } else {
            super.paste(sender)
        }
    }
}
