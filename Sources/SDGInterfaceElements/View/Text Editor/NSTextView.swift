/*
 NSTextView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

#if canImport(UIKit)
/// An `AppKit.NSTextView` or a `UITextView`.
public typealias NSTextView = UITextView
#endif

extension NSTextView {

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
            guard let textRange = selectedTextRange else { // @exempt(from: tests)
                return
            }
            shouldChange = shouldChangeText(in: textRange, replacementText: rawResult)
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

    #if canImport(AppKit) // #workaround(Temporary.)
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
            CharacterInformation.display(for: string.string)
        }
    }
    #endif

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
}
