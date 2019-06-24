/*
 TextView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

import Foundation
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGText
import SDGLocalization

import SDGInterfaceBasics
import SDGContextMenu

import SDGInterfaceLocalizations

internal class TextView : NSTextView, TextEditingResponder {

    // MARK: - Class properties.

    public override class var defaultMenu: NSMenu? {
        return ContextMenu.contextMenu.menu.native
    }

    // MARK: - Initialization

    internal init() {
        let prototype = NSTextView()
        super.init(frame: CGRect.zero, textContainer: prototype.textContainer)

        #if canImport(AppKit)
        maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        isVerticallyResizable = true
        autoresizingMask = View.AutoresizingMask.width

        allowsUndo = true
        usesFindPanel = true
        #endif

        #if canImport(AppKit)
        isContinuousSpellCheckingEnabled = true
        isAutomaticSpellingCorrectionEnabled = false
        isGrammarCheckingEnabled = true
        #else
        spellCheckingType = .yes
        autocorrectionType = .no
        autocapitalizationType = .none
        #endif

        #if canImport(AppKit)
        isAutomaticQuoteSubstitutionEnabled = true
        isAutomaticDashSubstitutionEnabled = true
        isAutomaticTextReplacementEnabled = true
        smartInsertDeleteEnabled = true
        #else
        smartQuotesType = .yes
        smartDashesType = .yes
        smartInsertDeleteType = .yes
        #endif

        #if canImport(AppKit)
        isAutomaticLinkDetectionEnabled = false
        isAutomaticDataDetectionEnabled = false
        #elseif !os(tvOS)
        dataDetectorTypes = []
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

    #if !os(tvOS)
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
        // @exempt(from: tests) UIKit only handles produces raw text on copy.

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
    override func insertText(_ text: String) {
        super.insertText(String(StrictString(text)))
    }
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
    #endif

    #if canImport(AppKit)
    // MARK: - NSMenuItemValidation

    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        if let action = menuItem.action,
            let known = canPerform(action: action) {
            return known
        }
        return super.validateMenuItem(menuItem)
    }
    #endif
}
#endif
