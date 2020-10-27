/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
import SDGViewsTestUtilities

final class APITests: ApplicationTestCase {

  func testAttributedString() {
    #if canImport(AppKit)
      typealias NativeFont = NSFont
    #elseif canImport(UIKit)
      typealias NativeFont = UIFont
    #endif
    var mutable = NSMutableAttributedString(string: "...")
    #if canImport(AppKit) || canImport(UIKit)
      mutable.addAttribute(
        NSAttributedString.Key.font,
        value: NativeFont.from(Font.system.resized(to: 24))!,
        range: NSRange(0..<3)
      )
      let attributed = mutable.copy() as! NSAttributedString
      mutable = attributed.mutableCopy() as! NSMutableAttributedString
      mutable.superscript(NSRange(0..<mutable.length))
      XCTAssert(
        (NativeFont.from(mutable.attributes(at: 0, effectiveRange: nil).font!)!).pointSize < 24,
        "\((NativeFont.from(mutable.attributes(at: 0, effectiveRange: nil).font!)!).pointSize)"
      )
      mutable = attributed.mutableCopy() as! NSMutableAttributedString
      mutable.subscript(NSRange(0..<mutable.length))
      XCTAssert(
        (NativeFont.from(mutable.attributes(at: 0, effectiveRange: nil).font!)!).pointSize < 24,
        "\((NativeFont.from(mutable.attributes(at: 0, effectiveRange: nil).font!)!).pointSize)"
      )
    #endif

    #if canImport(AppKit)
      var italiano = NSMutableAttributedString("Roma, Italia")
      italiano.makeLatinateSmallCaps(NSRange(0..<italiano.length))
      XCTAssert(¬italiano.attributes(at: 1, effectiveRange: nil).isEmpty)
      var türkçe = NSMutableAttributedString("İstanbul, Türkiye")
      türkçe.makeTurkicSmallCaps(NSRange(0..<türkçe.length))
      XCTAssert(¬türkçe.attributes(at: 2, effectiveRange: nil).isEmpty)

      italiano.resetCasing(of: NSRange(0..<italiano.length))

      italiano = NSMutableAttributedString("Roma, Italia")
      italiano.makeLatinateUpperCase(NSRange(0..<italiano.length))
      XCTAssert(¬italiano.attributes(at: 1, effectiveRange: nil).isEmpty)
      türkçe = NSMutableAttributedString("İstanbul, Türkiye")
      türkçe.makeTurkicUpperCase(NSRange(0..<türkçe.length))
      XCTAssert(¬türkçe.attributes(at: 2, effectiveRange: nil).isEmpty)
      italiano = NSMutableAttributedString("Roma, Italia")
      italiano.makeLatinateLowerCase(NSRange(0..<italiano.length))
      XCTAssert(italiano.attributes(at: 1, effectiveRange: nil).isEmpty)
      türkçe = NSMutableAttributedString("İstanbul, Türkiye")
      türkçe.makeTurkicLowerCase(NSRange(0..<türkçe.length))
      XCTAssert(türkçe.attributes(at: 2, effectiveRange: nil).isEmpty)
    #endif

    _ = NSAttributedString(RichText())
  }

  func testCharacterInformation() {
    #if canImport(AppKit) || canImport(UIKit)
      if #available(iOS 9, *) {  // @exempt(from: unicode)
        CharacterInformation.display(for: "abc", origin: nil)
        let view = CocoaView()
        let window = Window(
          type: .primary(nil),
          name: UserFacing<StrictString, AnyLocalization>({ _ in "..." }),
          content: view.cocoa()
        )
        window.display()
        CharacterInformation.display(for: "abc", origin: (view, nil))
        CharacterInformation.display(
          for: "\u{22}\u{AA}b\u{E7}\u{22}",
          origin: (view, Rectangle(origin: Point(0, 0), size: Size(width: 0, height: 0)))
        )
      }
    #endif
  }

  func testFont() {
    let font = Font.default
    _ = Font.forLabels
    _ = Font.forTextEditing
    #if canImport(AppKit) || canImport(UIKit)
      _ = font.bold
      _ = font.italic
      XCTAssertEqual(font.resized(to: 12).size, 12)
    #endif
  }

  func testLabel() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      Application.shared.demonstrateLabel()
      let label = Label<SDGInterfaceSample.InterfaceLocalization>(
        UserFacing({ _ in "..." }),
        colour: .black
      )
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        let testBody: Bool
        // #workaround(Swift 5.2.4, Would be a step backward on other platforms without the ability to interact properly with menus.)
        #if os(watchOS)
          testBody = true
        #else
          testBody = false
        #endif
        testViewConformance(of: label, testBody: testBody)
      }
    #endif
  }

  func testLog() {
    #if canImport(AppKit) || canImport(UIKit)
      Application.shared.demonstrateLog()
      if #available(macOS 10.12, tvOS 10, iOS 10, *) {
        let waited = expectation(description: "Waited for log to scroll.")
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in waited.fulfill() }
        waitForExpectations(timeout: 5, handler: nil)
      }
    #endif
  }

  func testRichText() throws {
    let fontNameKey = NSAttributedString.Key(rawValue: "SDGTestFontName")
    func prepareForEqualityCheck(
      _ string: NSAttributedString,
      ignoring ignored: [NSAttributedString.Key] = []
    ) -> NSAttributedString {
      #if canImport(AppKit) || canImport(UIKit)
        let processed = NSAttributedString(RichText(string))
        var font = processed.attributes(at: 0, effectiveRange: nil).font!
        if font.fontName == ".SFNSDisplay" ∨ font.fontName == ".SFNSText" {
          font.fontName = ".AppleSystemUIFont"
        }
        let mutable = processed.mutableCopy() as! NSMutableAttributedString
        let all = NSRange(0..<mutable.length)
        mutable.removeAttribute(.font, range: all)
        mutable.addAttribute(fontNameKey, value: font.fontName, range: all)
        mutable.addAttribute(
          NSAttributedString.Key(rawValue: "SDGTestFontSize"),
          value: CGFloat(font.size.rounded(.toNearestOrEven)),
          range: all
        )
        for attribute in ignored {
          mutable.removeAttribute(attribute, range: all)
        }
        return mutable.copy() as! NSAttributedString
      #else
        _ = fontNameKey
        return string
      #endif
    }
    for fontSize in sequence(first: 0 as Double, next: { $0 + 1 }).prefix(10).map({ 2 ↑ $0 }) {
      #if canImport(CoreGraphics)
        #if canImport(AppKit)
          typealias NativeFont = NSFont
        #elseif canImport(UIKit)
          typealias NativeFont = UIFont
        #endif
        let placeholderText = "..."
        let font = Font.system.resized(to: Double(fontSize))
        let nativeFont = NativeFont.from(font)!
        let basicString = NSAttributedString(
          string: placeholderText,
          attributes: [.font: nativeFont]
        )
        let basicHTML = try NSAttributedString.from(html: placeholderText, font: font)
        let ignored: [NSAttributedString.Key] = [
          .foregroundColor, .kern, .paragraphStyle, .strokeColor, .strokeWidth,
        ]
        XCTAssertEqual(
          prepareForEqualityCheck(basicString, ignoring: ignored),
          prepareForEqualityCheck(basicHTML, ignoring: ignored)
        )

        let toFixSup = try NSAttributedString.from(html: "\u{B2}", font: font)
        let alreadyCorrectSup = try NSAttributedString.from(html: "<sup>2</sup>", font: font)
        XCTAssertEqual(
          prepareForEqualityCheck(toFixSup),
          prepareForEqualityCheck(alreadyCorrectSup)
        )

        let toFixSub = try NSAttributedString.from(html: "\u{2082}", font: font)
        let alreadyCorrectSub = try NSAttributedString.from(html: "<sub>2</sub>", font: font)
        XCTAssertEqual(
          prepareForEqualityCheck(toFixSub),
          prepareForEqualityCheck(alreadyCorrectSub)
        )

        let mutable = basicHTML.mutableCopy() as! NSMutableAttributedString
        mutable.superscript(NSRange(0..<mutable.length))
        mutable.resetBaseline(for: NSRange(0..<mutable.length))
        XCTAssertEqual(prepareForEqualityCheck(mutable), prepareForEqualityCheck(basicHTML))
      #endif
    }

    #if canImport(AppKit) || canImport(UIKit)
      let noAttributes = NSAttributedString(string: "...")
      (noAttributes.mutableCopy() as! NSMutableAttributedString).superscript(
        NSRange(0..<noAttributes.length)
      )
      (noAttributes.mutableCopy() as! NSMutableAttributedString).resetBaseline(
        for: NSRange(0..<noAttributes.length)
      )
    #endif

    var richText = RichText(rawText: "...")
    #if canImport(AppKit) || canImport(UIKit)
      richText.superscript()
      richText.set(colour: Colour(red: 1, green: 1, blue: 1, opacity: 1))
      richText.superscript(range: richText.bounds)
      richText.subscript(range: richText.bounds)
      richText.set(font: Font.system)
      richText.set(paragraphStyle: NSParagraphStyle())
      XCTAssertEqual(richText.rawText(), StrictString("..."))
      XCTAssert(richText.scalars().elementsEqual("...".scalars))
      XCTAssertEqual(
        richText.index(before: richText.index(after: richText.startIndex)),
        richText.startIndex
      )
      richText.superscript(range: ..<richText.index(after: richText.startIndex))
      XCTAssertEqual(richText.count, 3)
      XCTAssertEqual(
        richText.index(before: richText.index(after: richText.startIndex)),
        richText.startIndex
      )
      XCTAssertNotEqual(richText.index(before: richText.endIndex), richText.startIndex)
      XCTAssertEqual(
        richText.index(after: richText.index(before: richText.endIndex)),
        richText.endIndex
      )
      XCTAssertEqual(richText[richText.startIndex].rawScalar, ".")
    #endif
    _ = richText.playgroundDescription

    testCustomStringConvertibleConformance(
      of: RichText(rawText: "..."),
      localizations: APILocalization.self,
      uniqueTestName: "Rich Text",
      overwriteSpecificationInsteadOfFailing: false
    )
    testEquatableConformance(differingInstances: (RichText(rawText: "1"), RichText(rawText: "2")))
    #if !os(Windows)  // #warning(Swift 5.3, Hashing appears broken on Windows.)
      XCTAssertEqual([richText: true][richText], true)
    #endif

    richText = RichText(rawText: "......")
    #if canImport(AppKit) || canImport(UIKit)
      richText.subscript(
        range: richText.index(
          richText.startIndex,
          offsetBy: 2
        )..<richText.index(richText.endIndex, offsetBy: −2)
      )
    #endif
    XCTAssertEqual(
      RichText(
        richText[
          richText.index(after: richText.startIndex)..<richText.index(before: richText.endIndex)
        ]
      ).count,
      4
    )
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
    let doubledSeparately = RichText(
      rawText: half.rawText() + half.rawText(),
      attributes: attributes
    )
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
    let subrange =
      richText.index(
        richText.startIndex,
        offsetBy: 2
      )..<richText.index(richText.endIndex, offsetBy: −2)
    let text = RichText(richText[subrange]).rawText()
    richText.replaceSubrange(
      subrange,
      with: RichText(
        rawText: text,
        attributes: [NSAttributedString.Key(rawValue: "Key"): NSNumber(value: 0)]
      )
    )
    XCTAssertEqual(
      RichText(
        richText[
          richText.index(after: richText.startIndex)..<richText.index(before: richText.endIndex)
        ]
      ).count,
      4
    )
    XCTAssertNotEqual(
      RichText(rawText: "..."),
      RichText(
        rawText: "...",
        attributes: [NSAttributedString.Key(rawValue: "Key"): NSNumber(value: 0)]
      )
    )

    richText = RichText("...")
    #if canImport(AppKit) || canImport(UIkit)
      richText.italicize(range: richText.bounds)
      richText.embolden(range: richText.bounds)
    #endif
  }

  func testTextEditor() {
    #if (canImport(AppKit) || canImport(UIKit)) && !os(tvOS)
      Application.shared.demonstrateTextEditor()
      let text = Shared(RichText())
      let textEditor = TextEditor(contents: text)
      let cocoaTextEditor = textEditor.cocoa()
      #if canImport(AppKit)
        let textView = (cocoaTextEditor.native as! NSScrollView).documentView as! NSTextView
      #else
        let textView = cocoaTextEditor.native as! UITextView
      #endif

      let characters = "\u{20}\u{21}\u{22}\u{AA}\u{C0}"
      text.value.append(contentsOf: RichText(rawText: StrictString(characters)))
      textView.selectAll(nil)
      _ = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "..." }),
        content: CocoaView(textView)
      ).cocoa()
      if #available(iOS 9, *) {  // @exempt(from: unicode)
        textView.showCharacterInformation(nil)
      }

      #if canImport(AppKit)
        let compatibilityTextView = NSTextView(frame: CGRect.zero)
        compatibilityTextView.string.append(characters)
      #else
        let compatibilityTextView = UITextView(frame: CGRect.zero)
        compatibilityTextView.text.append(characters)
      #endif
      compatibilityTextView.selectAll(nil)
      _ = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "..." }),
        content: CocoaView(compatibilityTextView)
      ).cocoa()
      if #available(iOS 9, *) {  // @exempt(from: unicode)
        compatibilityTextView.showCharacterInformation(nil)
      }

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

      #if canImport(AppKit)
        textView.insertText("...", replacementRange: NSRange(0..<0))
        textView.insertText(NSAttributedString(string: "..."), replacementRange: NSRange(0..<0))
        textView.insertText(
          "...",
          replacementRange: NSRange(textView.textStorage!.length..<textView.textStorage!.length)
        )
      #else
        textView.textStorage.replaceCharacters(in: NSRange(0..<0), with: "...")
        textView.textStorage.replaceCharacters(
          in: NSRange(0..<0),
          with: NSAttributedString(string: "...")
        )
        textView.textStorage.replaceCharacters(
          in: NSRange(textView.textStorage.length..<textView.textStorage.length),
          with: "..."
        )
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
        textView.selectedRange = NSRange(
          textView.textStorage!.length..<textView.textStorage!.length
        )
      #else
        textView.selectedRange = NSRange(textView.textStorage.length..<textView.textStorage.length)
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
        textView.isEditable = false
        XCTAssertFalse(textView.isEditable)
        XCTAssertFalse(validate(#selector(NSTextView.normalizeText(_:))))
      #endif

      #if canImport(UIKit)
        textView.insertText("...")
      #endif

      #if canImport(UIKit)
        textView.insertText("...")
        textView.selectAll(nil)
        if #available(iOS 9, *) {  // @exempt(from: unicode)
          XCTAssert(
            textView.canPerformAction(
              #selector(TextDisplayResponder.showCharacterInformation(_:)),
              withSender: nil
            )
          )
        }
        #if os(tvOS)
          XCTAssertFalse(
            textView.canPerformAction(
              #selector(TextEditingResponder.normalizeText(_:)),
              withSender: nil
            )
          )
          XCTAssertFalse(
            textView.canPerformAction(
              #selector(RichTextEditingResponder.makeSuperscript(_:)),
              withSender: nil
            )
          )
        #else
          XCTAssert(
            textView.canPerformAction(
              #selector(TextEditingResponder.normalizeText(_:)),
              withSender: nil
            )
          )
          XCTAssert(
            textView.canPerformAction(
              #selector(RichTextEditingResponder.makeSuperscript(_:)),
              withSender: nil
            )
          )
        #endif
        #if !os(tvOS)
          textView.isEditable = false
        #endif
        XCTAssertFalse(
          textView.canPerformAction(
            #selector(TextEditingResponder.normalizeText(_:)),
            withSender: nil
          )
        )
        textView.text = ""
        if #available(iOS 9, *) {  // @exempt(from: unicode)
          XCTAssertFalse(
            textView.canPerformAction(
              #selector(TextDisplayResponder.showCharacterInformation(_:)),
              withSender: nil
            )
          )
        }
      #endif
      #if canImport(AppKit)
        _ = textView.menu
      #endif
      #if canImport(AppKit)
        _ = TextContextMenu.contextMenu
      #endif
    #endif
    #if canImport(UIKit)
      let log = Log(contents: Shared("")).cocoa().native
      (log as! UITextViewDelegate).textViewDidChange!(log as! UITextView)
      (log as! UITextView).attributedText = NSAttributedString(string: "x, y, z")
      (log as! UITextViewDelegate).textViewDidChange!(log as! UITextView)
    #endif
  }

  func testTextField() {
    #if canImport(AppKit) || canImport(UIKit)
      Application.shared.demonstrateTextField()
      forEachWindow { window in
        _ = TextField(contents: Shared(StrictString()))
      }
      Application.shared.demonstrateLabelledTextField()
      let labelled = LabelledTextField(
        label: Label(
          UserFacing<StrictString, SDGInterfaceLocalizations.InterfaceLocalization>({ _ in "" })
        ),
        field: TextField(contents: Shared(StrictString()))
      )
      _ = labelled.cocoa()
      let shared = Shared<StrictString>("Before")
      _ = TextField(contents: shared)
      shared.value = "After"
      withLegacyMode {
        #if canImport(AppKit)
          let field = TextField(contents: Shared("")).cocoa().native as! NSTextField
          let fieldEditor = field.cell!.fieldEditor(for: NSView())!
          fieldEditor.string = "..."
          fieldEditor.selectAll(nil)
          XCTAssertFalse(
            fieldEditor.validateMenuItem(
              NSMenuItem(
                title: "...",
                action: #selector(RichTextEditingResponder.makeSuperscript(_:)),
                keyEquivalent: ""
              )
            )
          )
        #endif
      }
      withLegacyMode {
        let shared = Shared(StrictString("abc"))
        #if canImport(AppKit)
          let field = TextField(contents: shared).cocoa().native as! NSTextField
          field.stringValue = "xyz"
          field.textDidChange(
            Notification(
              name: NSControl.textDidChangeNotification,
              object: field.cell?.fieldEditor(for: NSView()),
              userInfo: [:]
            )
          )
          XCTAssertEqual(shared.value, "xyz")
        #else
          let field = TextField(contents: shared).cocoa().native as! UITextField
          field.insertText("...")
        #endif
      }
    #endif
    if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
      #if canImport(SwiftUI)
        let testBody: Bool
        // #workaround(Swift 5.2.4, Would be a step backward on other platforms without the ability to interact properly with menus.)
        #if os(watchOS)
          testBody = true
        #else
          testBody = false
        #endif
        testViewConformance(of: TextField(contents: Shared("")), testBody: testBody)
      #endif
    }
  }

  func testTextView() {
    #if canImport(AppKit) || canImport(UIKit)
      let textView = TextView(
        contents: UserFacing<RichText, SDGInterfaceLocalizations.InterfaceLocalization>({ _ in "abc"
        }
        )
      )
      let cocoa = textView.cocoa()
      #if canImport(AppKit)
        let cocoaTextView = (cocoa.native as! NSScrollView).documentView as! NSTextView
      #else
        let cocoaTextView = cocoa.native as! UITextView
      #endif
      cocoaTextView.selectAll(nil)
      _ = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "..." }),
        content: CocoaView(cocoaTextView)
      ).cocoa()
      if #available(iOS 9, *) {  // @exempt(from: unicode)
        cocoaTextView.showCharacterInformation(nil)
      }
      cocoaTextView.makeSuperscript(nil)
      cocoaTextView.makeSubscript(nil)
      cocoaTextView.resetBaseline(nil)
      cocoaTextView.normalizeText(nil)
      #if canImport(UIKit)
        XCTAssertFalse(
          cocoaTextView.canPerformAction(
            #selector(RichTextEditingResponder.makeSubscript),
            withSender: nil
          )
        )
        cocoaTextView.selectedRange = NSRange(location: NSNotFound, length: NSNotFound)
        if #available(iOS 9, *) {
          XCTAssertFalse(
            cocoaTextView.canPerformAction(
              #selector(TextDisplayResponder.showCharacterInformation),
              withSender: nil
            )
          )
        }
        XCTAssertTrue(
          cocoaTextView.canPerformAction(#selector(UITextView.selectAll(_:)), withSender: nil)
        )
      #endif
    #endif
  }
}
