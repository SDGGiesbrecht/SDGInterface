/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGText
import SDGMathematics
import SDGLocalization

import SDGInterfaceBasics
import SDGViews
import SDGTextDisplay
import SDGWindows
import SDGApplication

import SDGInterfaceLocalizations

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities
import SDGLogicTestUtilities
import SDGLocalizationTestUtilities

import SDGApplicationTestUtilities

final class APITests : ApplicationTestCase {

    func testAttributedString() {
        var mutable = NSMutableAttributedString(string: "...")
        #if canImport(AppKit) || canImport(UIKit)
        mutable.addAttribute(NSAttributedString.Key.font, value: Font.systemFont(ofSize: 24), range: NSRange(0 ..< 3))
        let attributed = mutable.copy() as! NSAttributedString
        mutable = attributed.mutableCopy() as! NSMutableAttributedString
        mutable.superscript(NSRange(0 ..< mutable.length))
        XCTAssert((mutable.attributes(at: 0, effectiveRange: nil)[NSAttributedString.Key.font] as! Font).pointSize < 24, "\((mutable.attributes(at: 0, effectiveRange: nil)[NSAttributedString.Key.font] as! Font).pointSize)")
        mutable = attributed.mutableCopy() as! NSMutableAttributedString
        mutable.subscript(NSRange(0 ..< mutable.length))
        XCTAssert((mutable.attributes(at: 0, effectiveRange: nil)[NSAttributedString.Key.font] as! Font).pointSize < 24, "\((mutable.attributes(at: 0, effectiveRange: nil)[NSAttributedString.Key.font] as! Font).pointSize)")
        #endif

        #if canImport(AppKit)
        var italiano = NSMutableAttributedString("Roma, Italia")
        italiano.makeLatinateSmallCaps(NSRange(0 ..< italiano.length))
        XCTAssert(¬italiano.attributes(at: 1, effectiveRange: nil).isEmpty)
        var türkçe = NSMutableAttributedString("İstanbul, Türkiye")
        türkçe.makeTurkicSmallCaps(NSRange(0 ..< türkçe.length))
        XCTAssert(¬türkçe.attributes(at: 2, effectiveRange: nil).isEmpty)

        italiano.resetCasing(of: NSRange(0 ..< italiano.length))

        italiano = NSMutableAttributedString("Roma, Italia")
        italiano.makeLatinateUpperCase(NSRange(0 ..< italiano.length))
        XCTAssert(¬italiano.attributes(at: 1, effectiveRange: nil).isEmpty)
        türkçe = NSMutableAttributedString("İstanbul, Türkiye")
        türkçe.makeTurkicUpperCase(NSRange(0 ..< türkçe.length))
        XCTAssert(¬türkçe.attributes(at: 2, effectiveRange: nil).isEmpty)
        italiano = NSMutableAttributedString("Roma, Italia")
        italiano.makeLatinateLowerCase(NSRange(0 ..< italiano.length))
        XCTAssert(italiano.attributes(at: 1, effectiveRange: nil).isEmpty)
        türkçe = NSMutableAttributedString("İstanbul, Türkiye")
        türkçe.makeTurkicLowerCase(NSRange(0 ..< türkçe.length))
        XCTAssert(türkçe.attributes(at: 2, effectiveRange: nil).isEmpty)
        #endif

        _ = NSAttributedString(RichText())
    }

    func testCharacterInformation() {
        #if canImport(AppKit) || canImport(UIKit)
        CharacterInformation.display(for: "abc", origin: nil)
        let view = AnyNativeView()
        let window = Window<SDGInterfaceLocalizations.InterfaceLocalization>.primaryWindow(name: .binding(Shared("...")), view: view)
        window.display()
        CharacterInformation.display(for: "abc", origin: (view, nil))
        #endif
    }

    func testFont() {
        #if canImport(AppKit) || canImport(UIKit)
        let font = Font.default
        _ = Font.forLabels
        _ = Font.forTextEditing
        _ = font.bold
        _ = font.italic
        XCTAssertEqual(font.resized(to: 12).pointSize, 12)
        #endif
    }

    func testLabel() {
        #if canImport(AppKit) || canImport(UIKit)
        Application.shared.demonstrateLabel()
        let label: Label<SDGInterfaceSample.InterfaceLocalization> = Label(text: .binding(Shared("...")))
        label.text = .static(UserFacing<StrictString, SDGInterfaceSample.InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Modified"
            }
        }))
        label.textColour = .black
        XCTAssertEqual(label.textColour, .black)
        #endif
    }

    func testRichText() throws {
        let fontNameKey = NSAttributedString.Key(rawValue: "SDGTestFontName")
        func prepareForEqualityCheck(_ string: NSAttributedString, ignoring ignored: [NSAttributedString.Key] = []) -> NSAttributedString {
            #if canImport(AppKit) || canImport(UIKit)
            let processed = NSAttributedString(RichText(string))
            let font = processed.attribute(.font, at: 0, effectiveRange: nil) as! Font
            let mutable = processed.mutableCopy() as! NSMutableAttributedString
            let all = NSRange(0 ..< mutable.length)
            mutable.removeAttribute(.font, range: all)
            mutable.addAttribute(fontNameKey, value: font.fontName, range: all)
            mutable.addAttribute(NSAttributedString.Key(rawValue: "SDGTestFontSize"), value: font.pointSize.rounded(.toNearestOrEven), range: all)
            for attribute in ignored {
                mutable.removeAttribute(attribute, range: all)
            }
            return mutable.copy() as! NSAttributedString
            #else
            return string
            #endif
        }
        for fontSize in sequence(first: 0, next: { $0 + 1 }).prefix(10).map({ 2 ↑ $0 }) {
            #if canImport(CoreGraphics)
            let placeholderText = "..."
            let font = Font.systemFont(ofSize: CGFloat(fontSize))
            let basicString = NSAttributedString(string: placeholderText, attributes: [.font: font])
            let basicHTML = try NSAttributedString.from(html: placeholderText, font: font)
            var ignored: [NSAttributedString.Key] = [.foregroundColor, .kern, .paragraphStyle, .strokeColor, .strokeWidth]
            if fontSize < 20 {
                ignored.append(fontNameKey)
            }
            XCTAssertEqual(prepareForEqualityCheck(basicString, ignoring: ignored), prepareForEqualityCheck(basicHTML, ignoring: ignored))

            let toFixSup = try NSAttributedString.from(html: "\u{B2}", font: font)
            let alreadyCorrectSup = try NSAttributedString.from(html: "<sup>2</sup>", font: font)
            XCTAssertEqual(prepareForEqualityCheck(toFixSup), prepareForEqualityCheck(alreadyCorrectSup))

            let toFixSub = try NSAttributedString.from(html: "\u{2082}", font: font)
            let alreadyCorrectSub = try NSAttributedString.from(html: "<sub>2</sub>", font: font)
            XCTAssertEqual(prepareForEqualityCheck(toFixSub), prepareForEqualityCheck(alreadyCorrectSub))

            let mutable = basicHTML.mutableCopy() as! NSMutableAttributedString
            mutable.superscript(NSRange(0 ..< mutable.length))
            mutable.resetBaseline(for: NSRange(0 ..< mutable.length))
            XCTAssertEqual(prepareForEqualityCheck(mutable), prepareForEqualityCheck(basicHTML))
            #endif
        }

        #if canImport(AppKit) || canImport(UIKit)
        let noAttributes = NSAttributedString(string: "...")
        (noAttributes.mutableCopy() as! NSMutableAttributedString).superscript(NSRange(0 ..< noAttributes.length))
        (noAttributes.mutableCopy() as! NSMutableAttributedString).resetBaseline(for: NSRange(0 ..< noAttributes.length))
        #endif

        var richText = RichText(rawText: "...")
        #if canImport(AppKit) || canImport(UIKit)
        richText.superscript()
        richText.set(colour: Colour(red: 1, green: 1, blue: 1, opacity: 1))
        richText.superscript(range: richText.bounds)
        richText.subscript(range: richText.bounds)
        richText.set(font: Font.systemFont(ofSize: Font.systemSize))
        richText.set(paragraphStyle: NSParagraphStyle())
        XCTAssertEqual(richText.rawText(), StrictString("..."))
        XCTAssert(richText.scalars().elementsEqual("...".scalars))
        XCTAssertEqual(richText.index(before: richText.index(after: richText.startIndex)), richText.startIndex)
        richText.superscript(range: ..<richText.index(after: richText.startIndex))
        XCTAssertEqual(richText.count, 3)
        XCTAssertEqual(richText.index(before: richText.index(after: richText.startIndex)), richText.startIndex)
        XCTAssertNotEqual(richText.index(before: richText.endIndex), richText.startIndex)
        XCTAssertEqual(richText.index(after: richText.index(before: richText.endIndex)), richText.endIndex)
        XCTAssertEqual(richText[richText.startIndex].rawScalar, ".")
        #endif
        _ = richText.playgroundDescription

        testCustomStringConvertibleConformance(of: RichText(rawText: "..."), localizations: APILocalization.self, uniqueTestName: "Rich Text", overwriteSpecificationInsteadOfFailing: false)
        testEquatableConformance(differingInstances: (RichText(rawText: "1"), RichText(rawText: "2")))
        XCTAssertEqual([richText: true][richText], true)

        richText = RichText(rawText: "......")
        #if canImport(AppKit) || canImport(UIKit)
        richText.subscript(range: richText.index(richText.startIndex, offsetBy: 2) ..< richText.index(richText.endIndex, offsetBy: −2))
        #endif
        XCTAssertEqual(RichText(richText[richText.index(after: richText.startIndex) ..< richText.index(before: richText.endIndex)]).count, 4)
        XCTAssert(RichText().isEmpty)
        let array = [RichText.Scalar(".", attributes: [:])]
        XCTAssertEqual(RichText(array).count, 1)
        richText = RichText(rawText: "...")
        richText.append(contentsOf: array)
        richText.insert(contentsOf: array, at: richText.startIndex)
        XCTAssertEqual(richText.count, 5)

        #if canImport(AppKit) || canImport(UIKit)
        let copy = richText
        richText.superscript()
        XCTAssertNotEqual(richText, copy)
        #endif

        richText = "abc\("def")ghi"
        XCTAssertEqual(richText.rawText(), "abcdefghi")

        XCTAssertEqual(("..." as RichText).rawText(), "...")
        _ = RichText(NSAttributedString(string: "..."))
        let attributes = [NSAttributedString.Key(rawValue: "Attribute"): NSNumber(value: 0)]
        let half = RichText(rawText: "...", attributes: attributes)
        let doubled = half + half
        let doubledSeparately = RichText(rawText: half.rawText() + half.rawText(), attributes: attributes)
        #if !os(Linux)
        XCTAssertEqual(doubled, doubledSeparately)
        #endif
        XCTAssert(RichText(rawText: "...").scalars().elementsEqual("...".scalars))
        for _ in (half + RichText(rawText: "...")).reversed() {}
        _ = RichText(NSAttributedString(string: "\u{B2}"))
        _ = RichText(NSAttributedString(string: "\u{2082}"))
        _ = RichText(richText[richText.bounds])
        XCTAssert(RichText(rawText: "").isEmpty)
        let nothingConcatenated = half + RichText(rawText: "")
        #if !os(Linux)
        XCTAssertEqual(nothingConcatenated, half)
        #endif
        richText = RichText(rawText: "......")
        let subrange = richText.index(richText.startIndex, offsetBy: 2) ..< richText.index(richText.endIndex, offsetBy: −2)
        let text = RichText(richText[subrange]).rawText()
        richText.replaceSubrange(subrange, with: RichText(rawText: text, attributes: [NSAttributedString.Key(rawValue: "Key"): NSNumber(value: 0)]))
        XCTAssertEqual(RichText(richText[richText.index(after: richText.startIndex) ..< richText.index(before: richText.endIndex)]).count, 4)
        XCTAssertNotEqual(RichText(rawText: "..."), RichText(rawText: "...", attributes: [NSAttributedString.Key(rawValue: "Key"): NSNumber(value: 0)]))
    }

    func testTextEditor() {
        #if canImport(AppKit) || canImport(UIKit)
        Application.shared.demonstrateTextEditor()
        let textEditor = TextEditor()
        let textView = textEditor.nativeTextView

        let characters = "\u{20}\u{21}\u{22}\u{AA}\u{C0}"
        textEditor.append(RichText(rawText: StrictString(characters)))
        textView.selectAll(nil)
        let window = Window<SDGInterfaceLocalizations.InterfaceLocalization>(name: .binding(Shared("...")), view: textEditor)
        textView.showCharacterInformation(nil)

        #if canImport(AppKit)
        let compatibilityTextView = NSTextView(frame: CGRect.zero)
        compatibilityTextView.string.append(characters)
        #else
        let compatibilityTextView = UITextView(frame: CGRect.zero)
        compatibilityTextView.text.append(characters)
        #endif
        compatibilityTextView.selectAll(nil)
        window.view = compatibilityTextView
        compatibilityTextView.showCharacterInformation(nil)

        textView.selectAll(nil)
        textView.normalizeText(nil)
        textView.selectAll(nil)
        textView.makeSuperscript(nil)
        textView.selectAll(nil)
        textView.makeSubscript(nil)
        textView.selectAll(nil)
        textView.resetBaseline(nil)
        textView.selectAll(nil)
        #if canImport(AppKit)
        textView.resetCasing(nil)
        textView.selectAll(nil)
        textView.makeLatinateUpperCase(nil)
        textView.selectAll(nil)
        textView.makeTurkicUpperCase(nil)
        textView.selectAll(nil)
        textView.makeLatinateSmallCaps(nil)
        textView.selectAll(nil)
        textView.makeTurkicSmallCaps(nil)
        textView.selectAll(nil)
        textView.makeLatinateLowerCase(nil)
        textView.selectAll(nil)
        textView.makeTurkicLowerCase(nil)
        #endif

        #if !os(tvOS)
        textEditor.isEditable = true
        XCTAssertTrue(textEditor.isEditable)
        #endif

        #if canImport(AppKit)
        textView.insertText("...", replacementRange: NSRange(0 ..< 0))
        textView.insertText(NSAttributedString(string: "..."), replacementRange: NSRange(0 ..< 0))
        textView.insertText("...", replacementRange: NSRange(textView.textStorage!.length ..< textView.textStorage!.length))
        #else
        textView.textStorage.replaceCharacters(in: NSRange(0 ..< 0), with: "...")
        textView.textStorage.replaceCharacters(in: NSRange(0 ..< 0), with: NSAttributedString(string: "..."))
        textView.textStorage.replaceCharacters(in: NSRange(textView.textStorage.length ..< textView.textStorage.length), with: "...")
        #endif

        textView.paste(nil)
        #if canImport(AppKit)
        NSPasteboard.general.clearContents()
        #elseif !os(tvOS)
        UIPasteboard.general.items = []
        #endif
        textView.paste(nil)
        textView.selectAll(nil)
        textView.copy(nil)
        textView.paste(nil)
        #if canImport(AppKit)
        textView.selectedRange = NSRange(textView.textStorage!.length ..< textView.textStorage!.length)
        #else
        textView.selectedRange = NSRange(textView.textStorage.length ..< textView.textStorage.length)
        #endif
        textView.paste(nil)

        #if canImport(AppKit)
        func validate(_ selector: Selector) -> Bool {
            let menuItem = NSMenuItem(title: "", action: selector, keyEquivalent: "")
            return textView.validateMenuItem(menuItem)
        }
        textView.selectAll(nil)
        XCTAssert(validate(#selector(NSTextView.normalizeText(_:))))
        XCTAssert(validate(#selector(NSTextView.makeSuperscript(_:))))
        XCTAssert(validate(#selector(NSTextView.underline(_:))))
        textView.setSelectedRange(NSRange(location: NSNotFound, length: 0))
        XCTAssertFalse(validate(#selector(NSTextView.normalizeText(_:))))
        textView.selectAll(nil)
        textEditor.isEditable = false
        XCTAssertFalse(textEditor.nativeTextView.isEditable)
        XCTAssertFalse(validate(#selector(NSTextView.normalizeText(_:))))
        #endif

        #if canImport(UIKit)
        textView.insertText("...")
        #endif

        #if canImport(UIKit)
        textView.insertText("...")
        textView.selectAll(nil)
        XCTAssert(textView.canPerformAction(
            #selector(TextDisplayResponder.showCharacterInformation(_:)),
            withSender: nil))
        #if os(tvOS)
        XCTAssertFalse(textView.canPerformAction(
            #selector(TextEditingResponder.normalizeText(_:)),
            withSender: nil))
        XCTAssertFalse(textView.canPerformAction(
            #selector(RichTextEditingResponder.makeSuperscript(_:)),
            withSender: nil))
        #else
        XCTAssert(textView.canPerformAction(
            #selector(TextEditingResponder.normalizeText(_:)),
            withSender: nil))
        XCTAssert(textView.canPerformAction(
            #selector(RichTextEditingResponder.makeSuperscript(_:)),
            withSender: nil))
        #endif
        #if !os(tvOS)
        textView.isEditable = false
        #endif
        XCTAssertFalse(textView.canPerformAction(
            #selector(TextEditingResponder.normalizeText(_:)),
            withSender: nil))
        textView.text = ""
        XCTAssertFalse(textView.canPerformAction(
            #selector(TextDisplayResponder.showCharacterInformation(_:)),
            withSender: nil))
        #endif
        #if canImport(AppKit)
        _ = textView.menu
        #endif
        #if canImport(AppKit)
        _ = TextContextMenu.contextMenu
        #endif

        textEditor.drawsBackground = true
        XCTAssert(textEditor.drawsBackground)
        #endif
    }

    func testTextField() {
        #if canImport(AppKit) || canImport(UIKit)
        Application.shared.demonstrateTextField()
        forEachWindow { window in
            #if canImport(AppKit)
            let fieldEditor = window.native.fieldEditor(true, for: window.view.native.subviews[0]) as! NSTextView
            fieldEditor.insertText("...", replacementRange: NSRange(0 ..< 0))
            fieldEditor.insertText(NSAttributedString(string: "..."), replacementRange: NSRange(0 ..< 0))
            fieldEditor.insertText("...", replacementRange: NSRange(0 ..< 0))
            fieldEditor.selectAll(nil)
            XCTAssertFalse(fieldEditor.validateMenuItem(NSMenuItem(title: "", action: #selector(NSTextView.makeSuperscript(_:)), keyEquivalent: "")))
            #endif

            let textField = TextField()
            #if canImport(UIKit)
            textField.specificNative.insertText("...")
            #endif
        }
        Application.shared.demonstrateLabelledTextField()
        _ = LabelledTextField(label: Label(
            text: .static(UserFacing<StrictString, SDGInterfaceLocalizations.InterfaceLocalization>({ _ in "" }))))
        #if canImport(AppKit)
        let textField = TextField()
        _ = textField.specificNative.cell?.fieldEditor(for: textField.specificNative)
        #endif
        #endif
    }
}
