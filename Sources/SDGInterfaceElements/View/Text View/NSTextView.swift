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

extension NSTextView {

    private func attemptToModifySelection(_ modify: (_ previousValue: NSAttributedString) -> NSAttributedString) {
        guard let storage = textStorage else {
            return
        }

        let originalRange = selectedRange()
        var adjustedRange = NSRange(location: NSNotFound, length: NSNotFound)

        if let original = attributedSubstring(forProposedRange: originalRange, actualRange: &adjustedRange) {

            if adjustedRange.location == NSNotFound {
                adjustedRange = originalRange
            }

            let result = modify(original)
            let rawResult = result.string
            if shouldChangeText(in: adjustedRange, replacementString: rawResult) {
                storage.replaceCharacters(in: adjustedRange, with: result)
                didChangeText()
            }
        }
    }
    private func attemptToMutateSelection(_ mutate: (NSMutableAttributedString) -> Void) {
        attemptToModifySelection() {
            let selection = $0.mutableCopy() as! NSMutableAttributedString
            mutate(selection)
            return selection.copy() as! NSAttributedString
        }
    }

    // MARK: - Manual Normalization

    @objc internal func normalizeText(_ sender: Any?) {
        attemptToModifySelection() { NSAttributedString(RichText($0)) }
    }

    // MARK: - Displaying Character Information

    @objc internal func showCharacterInformation(_ sender: Any?) {
        if let string = attributedSubstring(forProposedRange: selectedRange(), actualRange: nil) {
            CharacterInformation.display(for: string.string)
        }
    }

    // MARK: - Superscripts & Subscripts

    @objc public func makeSuperscript(_ sender: Any?) {
        attemptToMutateSelection() {
            $0.superscript(NSRange(0 ..< $0.length))
        }
    }

    @objc public func makeSubscript(_ sender: Any?) {
        attemptToMutateSelection() {
            $0.`subscript`(NSRange(0 ..< $0.length))
        }
    }

    @objc public func resetBaseline(_ sender: Any?) {
        attemptToMutateSelection() {
            $0.resetBaseline(for: NSRange(0 ..< $0.length))
        }
    }

    // MARK: - Case

    @objc public func resetCasing(_ sender: Any?) {
        attemptToMutateSelection() {
            $0.resetCasing(of: NSRange(0 ..< $0.length))
        }
    }

    @objc public func makeLatinateUpperCase(_ sender: Any?) {
        attemptToMutateSelection() {
            $0.makeLatinateUpperCase(NSRange(0 ..< $0.length))
        }
    }
    @objc public func makeTurkicUpperCase(_ sender: Any?) {
        attemptToMutateSelection() {
            $0.makeTurkicUpperCase(NSRange(0 ..< $0.length))
        }
    }

    @objc public func makeLatinateSmallCaps(_ sender: Any?) {
        attemptToMutateSelection() {
            $0.makeLatinateSmallCaps(NSRange(0 ..< $0.length))
        }
    }
    @objc public func makeTurkicSmallCaps(_ sender: Any?) {
        attemptToMutateSelection() {
            $0.makeTurkicSmallCaps(NSRange(0 ..< $0.length))
        }
    }

    @objc public func makeLatinateLowerCase(_ sender: Any?) {
        attemptToMutateSelection() {
            $0.makeLatinateLowerCase(NSRange(0 ..< $0.length))
        }
    }
    @objc public func makeTurkicLowerCase(_ sender: Any?) {
        attemptToMutateSelection() {
            $0.makeTurkicLowerCase(NSRange(0 ..< $0.length))
        }
    }

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

    open func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {

        if let action = menuItem.action {
            if actionRequiresSelection(action) {
                if let selection = Range<Int>(selectedRange()) {
                    if selection.isEmpty {
                        // Next test.
                    } else {
                        return false // Empty selection.
                    }
                } else {
                    return false // No selection available.
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

        return validateUserInterfaceItem(menuItem)
    }
}
