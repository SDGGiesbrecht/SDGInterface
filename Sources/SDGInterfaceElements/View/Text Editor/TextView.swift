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
import SDGMathematics

import SDGInterfaceLocalizations

internal class TextView : NSTextView {

    internal init() {
        let prototype = NSTextView()
        super.init(frame: CGRect.zero, textContainer: prototype.textContainer)

        #if canImport(AppKit)
        maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
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
        #else
        // #workaround(iOS?)
        #endif
    }

    @available(*, unavailable) internal required init?(coder: NSCoder) { // @exempt(from: unicode)
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "TextView"
            }
        }))
        return nil
    }

    // MARK: - Normalization

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
            if replacementRange.location ≠ NSNotFound ∧ replacementRange.location ≠ possibleStorage?.length {
                attributes = possibleStorage?.attributes(at: replacementRange.location, effectiveRange: nil)
            } else if replacementRange.location ≠ NSNotFound ∧ replacementRange.location ≠ 0 {
                attributes = possibleStorage?.attributes(at: replacementRange.location − 1, effectiveRange: nil)
            }
            let attributed = NSAttributedString(RichText(NSAttributedString(string: raw, attributes: attributes)))
            #if canImport(AppKit)
            super.insertText(attributed, replacementRange: replacementRange)
            #else
            possibleStorage?.replaceCharacters(in: replacementRange, with: attributed)
            #endif
            return
        }
        // @exempt(from: tests) UIKit only handles raw text.

        if let attributed = string as? NSAttributedString {
            #if canImport(AppKit)
            if isFieldEditor {
                super.insertText(String(StrictString(attributed.string)), replacementRange: replacementRange)
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

        #if UNIDENTIFIED_PASTEBOARD_WARNINGS
        print("Unidentified text type: (\(type(of: string)))")
        #endif
        #if canImport(AppKit)
        super.insertText(string, replacementRange: replacementRange)
        #endif
    }
    #if canImport(AppKit)
    override func insertText(_ string: Any, replacementRange: NSRange) {
        insert(text: string, at: replacementRange)
    }
    #else
    // #workaround(iOS?)
    #endif

    override func paste(_ sender: Any?) {
        let pasteboard = Pasteboard.general
        let possibleItems: [Any]?
        #if canImport(AppKit)
        possibleItems = pasteboard.readObjects(forClasses: [NSAttributedString.self, NSString.self], options: nil)
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
            super.paste(sender) // @exempt(from: tests) Always empty instead of nil.
        }
    }

    #if canImport(AppKit)
    // MARK: - NSMenuItemValidation

    private func actionRequiresSelection(_ action: Selector) -> Bool {
        switch action {
        case #selector(NSTextView.normalizeText(_:)),
             #selector(NSTextView.showCharacterInformation(_:)),
             #selector(NSTextView.makeSuperscript(_:)),
             #selector(NSTextView.makeSubscript(_:)),
             #selector(NSTextView.resetBaseline(_:)),
             #selector(NSTextView.resetCasing(_:)),
             #selector(NSTextView.makeLatinateUpperCase(_:)),
             #selector(NSTextView.makeTurkicUpperCase(_:)),
             #selector(NSTextView.makeLatinateSmallCaps(_:)),
             #selector(NSTextView.makeTurkicSmallCaps(_:)),
             #selector(NSTextView.makeLatinateLowerCase(_:)),
             #selector(NSTextView.makeTurkicLowerCase(_:)):
            return true
        default:
            return false
        }
    }

    private func actionRequiresEditability(_ action: Selector) -> Bool {
        switch action {
        case #selector(NSTextView.normalizeText(_:)),
             #selector(NSTextView.makeSuperscript(_:)),
             #selector(NSTextView.makeSubscript(_:)),
             #selector(NSTextView.resetBaseline(_:)),
             #selector(NSTextView.resetCasing(_:)),
             #selector(NSTextView.makeLatinateUpperCase(_:)),
             #selector(NSTextView.makeTurkicUpperCase(_:)),
             #selector(NSTextView.makeLatinateSmallCaps(_:)),
             #selector(NSTextView.makeTurkicSmallCaps(_:)),
             #selector(NSTextView.makeLatinateLowerCase(_:)),
             #selector(NSTextView.makeTurkicLowerCase(_:)):
            return true
        default:
            return false
        }
    }

    private func actionRequiresRichEditability(_ action: Selector) -> Bool {
        switch action {
        case #selector(NSTextView.makeSuperscript(_:)),
             #selector(NSTextView.makeSubscript(_:)),
             #selector(NSTextView.resetBaseline(_:)),
             #selector(NSTextView.resetCasing(_:)),
             #selector(NSTextView.makeLatinateUpperCase(_:)),
             #selector(NSTextView.makeTurkicUpperCase(_:)),
             #selector(NSTextView.makeLatinateSmallCaps(_:)),
             #selector(NSTextView.makeTurkicSmallCaps(_:)),
             #selector(NSTextView.makeLatinateLowerCase(_:)),
             #selector(NSTextView.makeTurkicLowerCase(_:)):
            return true
        default:
            return false
        }
    }

    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {

        if let action = menuItem.action {
            if actionRequiresSelection(action) {
                if let selection = Range<Int>(selectedRange()) {
                    if ¬selection.isEmpty {
                        // Next test.
                    } else {
                        return false // Empty selection.
                    }
                } else {
                    return false // No selection available. // @exempt(from: tests) Always empty instead.
                }
            }
            if actionRequiresEditability(action) {
                if ¬isEditable {
                    return false // Not editable
                }
            }
            if actionRequiresRichEditability(action) {
                if isFieldEditor {
                    return false // Attributes locked.
                }
            }
        }

        return super.validateMenuItem(menuItem)
    }
    #endif
}
