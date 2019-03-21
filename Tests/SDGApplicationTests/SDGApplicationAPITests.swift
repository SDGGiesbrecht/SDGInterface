/*
 SDGApplicationAPITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGLogic
import SDGMathematics
import SDGXCTestUtilities
import SDGLogicTestUtilities
import SDGLocalizationTestUtilities

import SDGInterface
import SDGInterfaceLocalizations
import SDGInterfaceSample

final class SDGApplicationAPITests : ApplicationTestCase {

    override func tearDown() {
        forEachWindow { window in
            window.close()
        }
    }

    func testApplicationName() {
        XCTAssertEqual(ProcessInfo.applicationName(.español(.de)), "del Ejemplar")
        XCTAssertEqual(ProcessInfo.applicationName(.deutsch(.akkusativ)), "Beispiel")
        XCTAssertEqual(ProcessInfo.applicationName(.deutsch(.dativ)), "Beispiel")
        XCTAssertEqual(ProcessInfo.applicationName(.français(.de)), "de l’Exemple")
        XCTAssertEqual(ProcessInfo.applicationName(.ελληνικά(.αιτιατική)), "το Παράδειγμα")
        XCTAssertEqual(ProcessInfo.applicationName(.ελληνικά(.γενική)), "του Παραδείγματος")
    }

    func testAttributedString() {
        let attributed = NSAttributedString(string: "...")
        var mutable = attributed.mutableCopy() as! NSMutableAttributedString
        mutable.addAttribute(NSAttributedString.Key.font, value: Font.systemFont(ofSize: 24), range: NSRange(0 ..< 3))
        mutable.superscript(NSRange(0 ..< mutable.length))
        XCTAssert((mutable.attributes(at: 0, effectiveRange: nil)[NSAttributedString.Key.font] as! Font).pointSize < 24, "\((mutable.attributes(at: 0, effectiveRange: nil)[NSAttributedString.Key.font] as! Font).pointSize)")
        mutable = attributed.mutableCopy() as! NSMutableAttributedString
        mutable.subscript(NSRange(0 ..< mutable.length))
        XCTAssert((mutable.attributes(at: 0, effectiveRange: nil)[NSAttributedString.Key.font] as! Font).pointSize < 24, "\((mutable.attributes(at: 0, effectiveRange: nil)[NSAttributedString.Key.font] as! Font).pointSize)")

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
    }

    func testDelegationInterceptor() {

        #if canImport(AppKit)
        class Delegate : NSObject, NSWindowDelegate {
            var recievedSomething = false
            func windowWillBeginSheet(_ notification: Notification) {
                recievedSomething = true
            }
        }
        #else
        class Delegate : NSObject, UIApplicationDelegate {
            var recievedSomething = false
            func applicationDidBecomeActive(_ application: UIApplication) {
                recievedSomething = true
            }
        }
        #endif
        let delegate = Delegate()
        defer { XCTAssert(delegate.recievedSomething) }

        #if canImport(AppKit)
        class Listener : NSObject, NSWindowDelegate {
            var recievedSomething = false
            func windowDidEndSheet(_ notification: Notification) {
                recievedSomething = true
            }
        }
        #else
        class Listener : NSObject, UIApplicationDelegate {
            var recievedSomething = false
            func applicationDidEnterBackground(_ application: UIApplication) {
                recievedSomething = true
            }
        }
        #endif
        let listener = Listener()
        defer { XCTAssert(listener.recievedSomething) }

        #if canImport(AppKit)
        let selectors: Set<Selector> = [#selector(NSWindowDelegate.windowDidEndSheet(_:))]
        #else
        let selectors: Set<Selector> = [#selector(UIApplicationDelegate.applicationDidEnterBackground(_:))]
        #endif

        let interceptor = DelegationInterceptor(delegate: delegate, listener: listener, selectors: selectors)
        #if canImport(AppKit)
        let windowDelegate = interceptor as NSWindowDelegate
        windowDelegate.windowWillBeginSheet?(Notification(name: NSWindow.willBeginSheetNotification))
        windowDelegate.windowDidEndSheet?(Notification(name: NSWindow.didEndSheetNotification))
        _ = interceptor.forwardingTarget(for: #selector(NSWindowDelegate.windowDidResize(_:)))
        windowDelegate.windowDidResize?(Notification(name: NSWindow.didResizeNotification))
        #else
        let applicationDelegate = interceptor as UIApplicationDelegate
        applicationDelegate.applicationDidBecomeActive?(UIApplication.shared)
        applicationDelegate.applicationDidEnterBackground?(UIApplication.shared)
        _ = interceptor.forwardingTarget(for: #selector(UIApplicationDelegate.applicationWillResignActive(_:)))
        applicationDelegate.applicationWillResignActive?(UIApplication.shared)
        #endif
    }

    func testLabel() {
        SampleApplicationDelegate().demonstrateLabel()
        forEachWindow { window in
            let label = window.contentView!.subviews[0] as! Label<SDGInterfaceSample.InterfaceLocalization>
            label.text = Shared(UserFacing<StrictString, SDGInterfaceSample.InterfaceLocalization>({ localization in
                switch localization {
                case .englishCanada:
                    return "Modified"
                }
            }))
        }
    }

    func testMenu() {
        #if !os(tvOS)

        _ = MenuItem(label: Shared(UserFacing<StrictString, APILocalization>({ _ in "..." })))

        #if canImport(AppKit)
        let menuBar = Application.shared.mainMenu
        XCTAssertNotNil(menuBar)
        let itemWithSubmenu = menuBar?.items.first(where: { $0.submenu ≠ nil })
        let submenu = itemWithSubmenu?.submenu
        XCTAssertNotNil(submenu)
        XCTAssertEqual(submenu?.parentMenuItem, itemWithSubmenu)
        XCTAssertNil(menuBar?.parentMenuItem)
        #elseif canImport(UIKit)
        XCTAssertNil(Menu.shared.parentMenuItem)
        #endif

        let menuLabel = Shared(UserFacing<StrictString, APILocalization>({ _ in "initial" }))
        let menu = Menu(label: menuLabel)
        menuLabel.value = UserFacing<StrictString, APILocalization>({ _ in "changed" })
        XCTAssertEqual(menu.title, String(menuLabel.value.resolved()))
        let separateMenuLabel = Shared(UserFacing<StrictString, APILocalization>({ _ in "separate" }))
        menu.label = separateMenuLabel
        XCTAssertEqual(menu.title, String(separateMenuLabel.value.resolved()))
        menuLabel.value = UserFacing<StrictString, APILocalization>({ _ in "unrelated" })
        XCTAssertEqual(menu.title, String(separateMenuLabel.value.resolved()))

        #endif
    }

    func testMenuBar() {
        let previous = ProcessInfo.applicationName
        func testAllLocalizations() {
            defer {
                ProcessInfo.applicationName = previous
            }
            for localization in MenuBarLocalization.allCases {
                LocalizationSetting(orderOfPrecedence: [localization.code]).do {}
            }
        }

        ProcessInfo.applicationName = { form in
            switch form {
            case .english(.canada):
                return "..."
            default:
                return nil
            }
        }
        testAllLocalizations()
        ProcessInfo.applicationName = { form in
            switch form {
            case .english(.unitedKingdom):
                return "..."
            default:
                return nil
            }
        }
        testAllLocalizations()

        #if canImport(AppKit)
        let preferencesMenuItem = MenuBar.menuBar.items.first!.submenu!.items.first(where: { $0.action == #selector(ApplicationDelegate.openPreferences) })!
        XCTAssert(SampleApplicationDelegate().validateMenuItem(preferencesMenuItem))
        XCTAssertFalse(ApplicationDelegate().validateMenuItem(preferencesMenuItem))

        XCTAssertFalse(SampleApplicationDelegate().validateMenuItem(MenuBar.menuBar.items.first!)) // Application
        XCTAssertFalse(SampleApplicationDelegate().validateMenuItem(NSMenuItem(title: "", action: nil, keyEquivalent: "")))
        #endif
    }

    func testMenuItem() {
        let menuLabel = Shared(UserFacing<StrictString, APILocalization>({ _ in "initial" }))
        let menu = MenuItem(label: menuLabel)
        menuLabel.value = UserFacing<StrictString, APILocalization>({ _ in "changed" })
        XCTAssertEqual(menu.title, String(menuLabel.value.resolved()))
        let separateMenuLabel = Shared(UserFacing<StrictString, APILocalization>({ _ in "separate" }))
        menu.label = separateMenuLabel
        XCTAssertEqual(menu.title, String(separateMenuLabel.value.resolved()))
        menuLabel.value = UserFacing<StrictString, APILocalization>({ _ in "unrelated" })
        XCTAssertEqual(menu.title, String(separateMenuLabel.value.resolved()))
    }

    func testFont() {
        let font = Font.default
        _ = Font.forLabels
        _ = Font.forTextEditing
        XCTAssert(NSFontManager.shared.traits(of: font.bold).contains(.boldFontMask))
        XCTAssert(NSFontManager.shared.traits(of: font.italic).contains(.italicFontMask))
        XCTAssertEqual(font.resized(to: 12).pointSize, 12)
    }

    func testPreferences() {
        ApplicationDelegate().openPreferences(nil)
        SampleApplicationDelegate().openPreferences(nil)
    }

    func testRichText() {
        let fontNameKey = NSAttributedString.Key(rawValue: "SDGTestFontName")
        func prepareForEqualityCheck(_ string: NSAttributedString, ignoring ignored: [NSAttributedString.Key] = []) -> NSAttributedString {
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
        }
        for fontSize in sequence(first: 0, next: { $0 + 1 }).prefix(10).map({ 2 ↑ $0 }) {
            let placeholderText = "..."
            let font = Font.systemFont(ofSize: CGFloat(fontSize))
            let basicString = NSAttributedString(string: placeholderText, attributes: [.font: font])
            let basicHTML = NSAttributedString(html: placeholderText, font: font)!
            var ignored: [NSAttributedString.Key] = [.foregroundColor, .kern, .paragraphStyle, .strokeColor, .strokeWidth]
            if fontSize < 20 {
                ignored.append(fontNameKey)
            }
            XCTAssertEqual(prepareForEqualityCheck(basicString, ignoring: ignored), prepareForEqualityCheck(basicHTML, ignoring: ignored))

            let toFixSup = NSAttributedString(html: "\u{B2}", font: font)!
            let alreadyCorrectSup = NSAttributedString(html: "<sup>2</sup>", font: font)!
            XCTAssertEqual(prepareForEqualityCheck(toFixSup), prepareForEqualityCheck(alreadyCorrectSup))

            let toFixSub = NSAttributedString(html: "\u{2082}", font: font)!
            let alreadyCorrectSub = NSAttributedString(html: "<sub>2</sub>", font: font)!
            XCTAssertEqual(prepareForEqualityCheck(toFixSub), prepareForEqualityCheck(alreadyCorrectSub))

            let mutable = basicHTML.mutableCopy() as! NSMutableAttributedString
            mutable.superscript(NSRange(0 ..< mutable.length))
            mutable.resetBaseline(for: NSRange(0 ..< mutable.length))
            XCTAssertEqual(prepareForEqualityCheck(mutable), prepareForEqualityCheck(basicHTML))
        }

        let noAttributes = NSAttributedString(string: "...")
        (noAttributes.mutableCopy() as! NSMutableAttributedString).superscript(NSRange(0 ..< noAttributes.length))
        (noAttributes.mutableCopy() as! NSMutableAttributedString).resetBaseline(for: NSRange(0 ..< noAttributes.length))

        var richText = RichText(rawText: "...")
        richText.superscript()
        richText.set(colour: NSColor(calibratedRed: 1, green: 1, blue: 1, alpha: 1))
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
        _ = richText.playgroundDescription

        testCustomStringConvertibleConformance(of: RichText(rawText: "..."), localizations: APILocalization.self, uniqueTestName: "Rich Text", overwriteSpecificationInsteadOfFailing: false)
        testEquatableConformance(differingInstances: (RichText(rawText: "1"), RichText(rawText: "2")))
        XCTAssertEqual([richText: true][richText], true)

        richText = RichText(rawText: "......")
        richText.subscript(range: richText.index(richText.startIndex, offsetBy: 2) ..< richText.index(richText.endIndex, offsetBy: −2))
        XCTAssertEqual(RichText(richText[richText.index(after: richText.startIndex) ..< richText.index(before: richText.endIndex)]).count, 4)
        XCTAssert(RichText().isEmpty)
        let array = [RichText.Scalar(".", attributes: [:])]
        XCTAssertEqual(RichText(array).count, 1)
        richText = RichText(rawText: "...")
        richText.append(contentsOf: array)
        richText.insert(contentsOf: array, at: richText.startIndex)
        XCTAssertEqual(richText.count, 5)

        let copy = richText
        richText.superscript()
        XCTAssertNotEqual(richText, copy)
    }

    func testTable() {
        let table = Table(contentController: NSArrayController())
        let delegate = DelegationInterceptor(delegate: nil, listener: nil, selectors: [])
        table.delegate = delegate
        XCTAssertNotNil(table.delegate as? DelegationInterceptor)
        table.action = nil
        XCTAssertNil(table.action)
        table.doubleAction = nil
        XCTAssertNil(table.doubleAction)
        table.target = nil
        XCTAssertNil(table.target)
        table.hasHeader = true
        XCTAssert(table.hasHeader)
        table.allowsSelection = true
        XCTAssert(table.allowsSelection)
        table.sortOrder = []
        XCTAssert(table.sortOrder.isEmpty)
    }

    func testTextEditor() {
        SampleApplicationDelegate().demonstrateTextEditor()
        forEachWindow { window in
            let textEditor = window.contentView!.subviews[0] as! TextEditor
            let textView = textEditor.documentView as! NSTextView

            let characters = "\u{20}\u{21}\u{22}\u{AA}\u{C0}"
            textEditor.append(RichText(rawText: StrictString(characters)))
            textView.selectAll(nil)
            textView.showCharacterInformation(nil)

            let compatibilityTextView = NSTextView(frame: NSRect.zero)
            compatibilityTextView.string.append(characters)
            compatibilityTextView.selectAll(nil)
            compatibilityTextView.showCharacterInformation(nil)

            textView.selectAll(nil)
            textView.normalizeText(nil)
            textView.selectAll(nil)
            textView.makeSuperscript(nil)
            textView.selectAll(nil)
            textView.makeSuperscript(nil)
            textView.selectAll(nil)
            textView.resetBaseline(nil)
            textView.selectAll(nil)
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

            func validate(_ selector: Selector) -> Bool {
                let menuItem = NSMenuItem(title: "", action: selector, keyEquivalent: "")
                return textView.validateMenuItem(menuItem)
            }
        }
    }

    func testTextField() {
        SampleApplicationDelegate().demonstrateTextField()
    }

    func testView() {
        View().fill(with: View())
        View().setMinimumSize(size: 10, axis: .horizontal)
        View().position(subviews: [View(), View()], inSequenceAlong: .vertical)
        View().centre(subview: View())
        View().equalizeSize(amongSubviews: [View(), View()], on: .horizontal)
        View().equalizeSize(amongSubviews: [View(), View()], on: .vertical)
        View().lockSizeRatio(toSubviews: [View(), View()], coefficient: 1, axis: .horizontal)
        View().lockSizeRatio(toSubviews: [View(), View()], coefficient: 1, axis: .vertical)
        View().alignCentres(ofSubviews: [View(), View()], on: .horizontal)
        View().alignCentres(ofSubviews: [View(), View()], on: .vertical)
        View().alignLastBaselines(ofSubviews: [View(), View()])
        View().lockAspectRatio(to: 1)
        View().position(subviews: [View(), View()], inSequenceAlong: .horizontal, padding: .none, leadingMargin: .specific(8), trailingMargin: .unspecified)
    }

    func testWindow() {
        SampleApplicationDelegate().demonstrateWindow()

        let window = Window(title: Shared(UserFacing<StrictString, InterfaceLocalization>({ _ in "Title" })), size: CGSize(width: 700, height: 300))
        #if canImport(AppKit) // UIKit raises an exception during tests.
        window.makeKeyAndOrderFront(nil)
        #endif
        defer { window.close() }

        window.isFullscreen = true
        _ = window.isFullscreen
        let fullscreenWindow = Window(title: Shared(UserFacing<StrictString, InterfaceLocalization>({ _ in "Fullscreen" })), size: CGSize(width: 700, height: 300))
        fullscreenWindow.isFullscreen = true
        #if canImport(AppKit) // UIKit raises an exception during tests.
        fullscreenWindow.makeKeyAndOrderFront(nil)
        #endif
        defer { fullscreenWindow.close() }
        RunLoop.main.run(until: Date() + 3)

        window.title = "Replaced Title"
        XCTAssert(window.title == "Replaced Title")

        #if canImport(AppKit)
        XCTAssert((window as NSWindowDelegate).windowWillReturnFieldEditor?(window, to: nil) is NSTextView)
        #endif

        let neverOnscreen = Window(title: Shared(UserFacing<StrictString, InterfaceLocalization>({ _ in "Never Onscreen" })), size: CGSize.zero)
        neverOnscreen.centreInScreen()

        #if canImport(UIKit)
        _ = Window(title: "Title")
        #endif
    }
}
