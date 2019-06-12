/*
 NSTextView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import SDGLogic
import SDGCollections

#if canImport(UIKit)
/// An `AppKit.NSTextView` or a `UITextView`.
public typealias NSTextView = UITextView
#endif

extension NSTextView {

    // MARK: - Selection

    /// The rectangle of the current selection.
    public func selectionRectangle() -> CGRect? {
        #if canImport(AppKit)
        guard let layout = layoutManager,
            let text = textContainer else {
                return nil // @exempt(from: tests)
        }
        let range = layout.glyphRange(forCharacterRange: selectedRange(), actualCharacterRange: nil)
        return layout.boundingRect(forGlyphRange: range, in: text)
        #else
        guard let range = selectedTextRange else {
            return nil // @exempt(from: tests)
        }
        return selectionRects(for: range).first?.rect
        #endif
    }

    // MARK: - Editing

    private func attemptToModifySelection(_ modify: (_ previousValue: NSAttributedString) -> NSAttributedString) {
        let possibleStorage: NSTextStorage? = textStorage
        guard let storage = possibleStorage else {
            return // @exempt(from: tests)
        }

        let originalRange: NSRange
        #if canImport(AppKit)
        originalRange = selectedRange()
        #else
        originalRange = selectedRange
        #endif
        var adjustedRange = NSRange(location: NSNotFound, length: NSNotFound)

        let possibleOriginal: NSAttributedString?
        #if canImport(AppKit)
        possibleOriginal = attributedSubstring(forProposedRange: originalRange, actualRange: &adjustedRange)
        #else
        possibleOriginal = textStorage.attributedSubstring(from: originalRange)
        #endif
        if let original = possibleOriginal {

            if adjustedRange.location == NSNotFound {
                adjustedRange = originalRange // @exempt(from: tests)
            }

            let result = modify(original)
            let rawResult = result.string
            let shouldChange: Bool
            #if canImport(AppKit)
            shouldChange = shouldChangeText(in: adjustedRange, replacementString: rawResult)
            #else
            if ¬responds(to: #selector(TextView.shouldChangeText)) {
                shouldChange = true
            } else {
                guard let textRange = selectedTextRange else { // @exempt(from: tests)
                return
                }
                shouldChange = shouldChangeText(in: textRange, replacementText: rawResult)
            }
            #endif
            if shouldChange {
                storage.replaceCharacters(in: adjustedRange, with: result)
                #if canImport(AppKit)
                didChangeText()
                #endif
            }
        }
    }
    private func attemptToMutateSelection(_ mutate: (NSMutableAttributedString) -> Void) {
        attemptToModifySelection {
            let selection = $0.mutableCopy() as! NSMutableAttributedString
            mutate(selection)
            return selection.copy() as! NSAttributedString
        }
    }

    // MARK: - Manual Normalization

    /// Normalizes the selection to NFKD.
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc public func normalizeText(_ sender: Any?) {
        attemptToModifySelection { NSAttributedString(RichText($0)) }
    }

    // MARK: - Displaying Character Information

    /// Displays a window with information about the Unicode code points present in the selection.
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc public func showCharacterInformation(_ sender: Any?) {
        let possibleString: NSAttributedString?
        #if canImport(AppKit)
        possibleString = attributedSubstring(forProposedRange: selectedRange(), actualRange: nil)
        #else
        possibleString = textStorage.attributedSubstring(from: selectedRange)
        #endif
        if let string = possibleString {
            CharacterInformation.display(
                for: string.string,
                origin: (view: self, selection: selectionRectangle()))
        }
    }

    // MARK: - Superscripts & Subscripts

    /// Superscripts the selection.
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc public func makeSuperscript(_ sender: Any?) {
        attemptToMutateSelection {
            $0.superscript(NSRange(0 ..< $0.length))
        }
    }

    /// Subscripts the selection.
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc public func makeSubscript(_ sender: Any?) {
        attemptToMutateSelection {
            $0.`subscript`(NSRange(0 ..< $0.length))
        }
    }

    /// Resets the baseline of the selection.
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc public func resetBaseline(_ sender: Any?) {
        attemptToMutateSelection {
            $0.resetBaseline(for: NSRange(0 ..< $0.length))
        }
    }

    #if canImport(AppKit)
    // MARK: - Case

    /// Resets the casing of the selection.
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc public func resetCasing(_ sender: Any?) {
        attemptToMutateSelection {
            $0.resetCasing(of: NSRange(0 ..< $0.length))
        }
    }

    /// Converts the selection to a Latinate upper case font (where “i” becomes “I”).
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc public func makeLatinateUpperCase(_ sender: Any?) {
        attemptToMutateSelection {
            $0.makeLatinateUpperCase(NSRange(0 ..< $0.length))
        }
    }
    /// Converts the selection to a Turkic upper case font (where “i” becomes “İ”).
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc public func makeTurkicUpperCase(_ sender: Any?) {
        attemptToMutateSelection {
            $0.makeTurkicUpperCase(NSRange(0 ..< $0.length))
        }
    }

    /// Converts the selection to a Latinate small caps font (where “i” becomes “I”).
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc public func makeLatinateSmallCaps(_ sender: Any?) {
        attemptToMutateSelection {
            $0.makeLatinateSmallCaps(NSRange(0 ..< $0.length))
        }
    }
    /// Converts the selection to a Turkic small caps font (where “i” becomes “İ”).
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc public func makeTurkicSmallCaps(_ sender: Any?) {
        attemptToMutateSelection {
            $0.makeTurkicSmallCaps(NSRange(0 ..< $0.length))
        }
    }

    /// Converts the selection to a Latinate lower case font (where “I” becomes “i”).
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc public func makeLatinateLowerCase(_ sender: Any?) {
        attemptToMutateSelection {
            $0.makeLatinateLowerCase(NSRange(0 ..< $0.length))
        }
    }
    /// Converts the selection to a Turkic lower case font (where “I” becomes “ı”).
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc public func makeTurkicLowerCase(_ sender: Any?) {
        attemptToMutateSelection {
            $0.makeTurkicLowerCase(NSRange(0 ..< $0.length))
        }
    }
    #endif

    // MARK: - Menu Validation

    private static let actionsRequiringSelection: Set<Selector> = {
        var result: Set<Selector> = [
            #selector(NSTextView.normalizeText(_:)),
            #selector(NSTextView.showCharacterInformation(_:)),
            #selector(NSTextView.makeSuperscript(_:)),
            #selector(NSTextView.makeSubscript(_:)),
            #selector(NSTextView.resetBaseline(_:))
            ]
        #if canImport(AppKit)
        result ∪= [
            #selector(NSTextView.resetCasing(_:)),
            #selector(NSTextView.makeLatinateUpperCase(_:)),
            #selector(NSTextView.makeTurkicUpperCase(_:)),
            #selector(NSTextView.makeLatinateSmallCaps(_:)),
            #selector(NSTextView.makeTurkicSmallCaps(_:)),
            #selector(NSTextView.makeLatinateLowerCase(_:)),
            #selector(NSTextView.makeTurkicLowerCase(_:))
        ]
        #endif
        return result
    }()

    private static let actionsRequiringEditability: Set<Selector> = {
        var result: Set<Selector> = [
            #selector(NSTextView.normalizeText(_:)),
            #selector(NSTextView.makeSuperscript(_:)),
            #selector(NSTextView.makeSubscript(_:)),
            #selector(NSTextView.resetBaseline(_:))
        ]
        #if canImport(AppKit)
        result ∪= [
            #selector(NSTextView.resetCasing(_:)),
            #selector(NSTextView.makeLatinateUpperCase(_:)),
            #selector(NSTextView.makeTurkicUpperCase(_:)),
            #selector(NSTextView.makeLatinateSmallCaps(_:)),
            #selector(NSTextView.makeTurkicSmallCaps(_:)),
            #selector(NSTextView.makeLatinateLowerCase(_:)),
            #selector(NSTextView.makeTurkicLowerCase(_:))
        ]
        #endif
        return result
    }()

    private static let actionsRequiringRichEditability: Set<Selector> = {
        var result: Set<Selector> = [
            #selector(NSTextView.makeSuperscript(_:)),
            #selector(NSTextView.makeSubscript(_:)),
            #selector(NSTextView.resetBaseline(_:))
        ]
        #if canImport(AppKit)
        result ∪= [
            #selector(NSTextView.resetCasing(_:)),
            #selector(NSTextView.makeLatinateUpperCase(_:)),
            #selector(NSTextView.makeTurkicUpperCase(_:)),
            #selector(NSTextView.makeLatinateSmallCaps(_:)),
            #selector(NSTextView.makeTurkicSmallCaps(_:)),
            #selector(NSTextView.makeLatinateLowerCase(_:)),
            #selector(NSTextView.makeTurkicLowerCase(_:))
        ]
        #endif
        return result
    }()

    /// Returns `nil` if the action is not recognized and should be delegated to the operating system.
    internal func canPerform(action: Selector) -> Bool? {
        if action ∈ NSTextView.actionsRequiringSelection {
            #if canImport(AppKit)
            let selectionRange = Range<Int>(selectedRange())
            #else
            let selectionRange = selectedTextRange
            #endif
            if let selection = selectionRange {
                if ¬selection.isEmpty {
                    // Next test.
                } else {
                    return false // Empty selection.
                }
            } else {
                return false // No selection available. // @exempt(from: tests) Always empty instead.
            }
        }
        if action ∈ NSTextView.actionsRequiringEditability {
            let isEditable: Bool
            #if os(tvOS)
            isEditable = false
            #else
            isEditable = self.isEditable
            #endif
            if ¬isEditable {
                return false // Not editable
            }
        }
        if action ∈ NSTextView.actionsRequiringRichEditability {
            // @exempt(from: tests) Unreachable on tvOS.
            #if canImport(AppKit)
            if isFieldEditor {
                return false // Attributes locked.
            }
            #endif
        }
        return nil
    }

    #if canImport(UIKit)
    // MARK: - UIResponder

    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if let known = canPerform(action: action) {
            return known
        }
        return super.canPerformAction(action, withSender: sender)
    }
    #endif
}
#endif
