/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(SwiftUI)
  import SwiftUI
#endif
#if canImport(AppKit)
  import AppKit
#endif

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGText
import SDGLocalization

import SDGInterface

import SDGInterfaceLocalizations

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities
import SDGLogicTestUtilities
import SDGLocalizationTestUtilities

import SDGInterfaceTestUtilities
import SDGInterfaceInternalTestUtilities

final class APITests: ApplicationTestCase {

  func testAlert() {
    let alert = SDGInterface.Alert(
      style: .informational,
      title: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
      message: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
      dismissalButton: AlertButton(
        style: .default,
        label: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
        action: {}
      )
    )
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      _ = alert.swiftUI()
    #endif

    let withAlert = SDGInterface.EmptyView()
      .alert(
        isPresented: Shared(false),
        alert: alert
      )
    testViewConformance(of: withAlert)
  }

  func testAlertButton() {
    for buttonStyle in [.default, .cancellation, .destructive] as [AlertButtonStyle] {
      let button = AlertButton(
        style: buttonStyle,
        label: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
        action: {}
      )
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        _ = button.swiftUI()
      #endif
    }
  }

  func testAlertStyle() {
    for alertStyle in [.informational, .warning, .critical] as [AlertStyle] {
      #if canImport(AppKit)
        _ = alertStyle.cocoa()
      #endif
    }
  }

  func testAlignment() {
    XCTAssertEqual(SDGInterface.Alignment(horizontal: .centre, vertical: .centre), .centre)
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        var swiftUI: SwiftUI.Alignment = .center
        var sdgInterface = SDGInterface.Alignment(swiftUI)!
        XCTAssertEqual(sdgInterface, .centre)
        XCTAssertEqual(SwiftUI.Alignment(sdgInterface), .center)
        swiftUI = .topLeading
        sdgInterface = SDGInterface.Alignment(swiftUI)!
        XCTAssertEqual(sdgInterface, .topLeading)
        XCTAssertEqual(SwiftUI.Alignment(sdgInterface), .topLeading)
        swiftUI = .bottomTrailing
        sdgInterface = SDGInterface.Alignment(swiftUI)!
        XCTAssertEqual(sdgInterface, .bottomTrailing)
        XCTAssertEqual(SwiftUI.Alignment(sdgInterface), .bottomTrailing)
      }
    #endif
  }

  func testAnchorSource() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        var shimmed = RectangularAttachmentAnchor.rectangle(SDGInterface.Rectangle())
        _ = Anchor<CGRect>.Source(shimmed)
        shimmed = .bounds
        _ = Anchor<CGRect>.Source(shimmed)
      }
    #endif
  }

  func testAnyView() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        _ = AnyView(EmptyView()).swiftUI()
      }
    #endif
  }

  func testApplication() {
    struct ExampleApplication: LegacyApplication {
      #if !PLATFORM_LACKS_FOUNDATION_PROCESS_INFO
        var applicationName: ProcessInfo.ApplicationNameResolver {
          return { _ in "..." }
        }
        var applicationIdentifier: String {
          return "com.example.identifier"
        }
      #endif
      var mainWindow: Window<SDGInterface.EmptyView, AnyLocalization> {
        return Window(
          type: .primary(nil),
          name: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
          content: EmptyView()
        )
      }
      #if PLATFORM_LACKS_FOUNDATION_RUN_LOOP
        static func main() {}
      #endif
    }
    let preferences: Any = ExampleApplication().preferences
    XCTAssert(preferences is SDGInterface.EmptyView)
    #if !PLATFORM_LACKS_FOUNDATION_RUN_LOOP
      _ = SampleApplication().preferences
    #endif
  }

  func testApplicationName() {
    #if !PLATFORM_LACKS_FOUNDATION_PROCESS_INFO
      XCTAssertEqual(ProcessInfo.applicationName(.español(.de)), "del Ejemplar")
      XCTAssertEqual(ProcessInfo.applicationName(.deutsch(.akkusativ)), "Beispiel")
      XCTAssertEqual(ProcessInfo.applicationName(.deutsch(.dativ)), "Beispiel")
      XCTAssertEqual(ProcessInfo.applicationName(.français(.de)), "de l’Exemple")
      XCTAssertEqual(ProcessInfo.applicationName(.ελληνικά(.αιτιατική)), "το Παράδειγμα")
      XCTAssertEqual(ProcessInfo.applicationName(.ελληνικά(.γενική)), "του Παραδείγματος")
    #endif
  }

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
      italiano.makeSmallCaps(NSRange(0..<italiano.length))
      var türkçe = NSMutableAttributedString("İstanbul, Türkiye")
      türkçe.makeSmallCaps(NSRange(0..<türkçe.length))

      italiano.resetCasing(of: NSRange(0..<italiano.length))

      italiano = NSMutableAttributedString("Roma, Italia")
      italiano.makeUpperCase(NSRange(0..<italiano.length))
      türkçe = NSMutableAttributedString("İstanbul, Türkiye")
      türkçe.makeUpperCase(NSRange(0..<türkçe.length))
      italiano = NSMutableAttributedString("Roma, Italia")
      italiano.makeLowerCase(NSRange(0..<italiano.length))
      türkçe = NSMutableAttributedString("İstanbul, Türkiye")
      türkçe.makeLowerCase(NSRange(0..<türkçe.length))
    #endif

    _ = NSAttributedString(RichText())
  }

  func testBackground() {
    #if canImport(AppKit) || canImport(UIKit)
      forAllLegacyModes {
        _ = Colour.red.background(Colour.blue).cocoa()
      }
    #endif
  }

  func testButton() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      MenuBarTarget.shared.demonstrateButton()
      let label = UserFacing<StrictString, SDGInterfaceLocalizations.InterfaceLocalization>(
        { localization in
          return "Button"
        }
      )
      let button = Button(label: label, action: {})
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        testViewConformance(of: button)
      }
    #endif
  }

  func testCharacterInformation() {
    #if canImport(AppKit) || canImport(UIKit)
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
    #endif
  }

  func testCheckBox() {
    #if canImport(AppKit) || canImport(UIKit)
      MenuBarTarget.shared.demonstrateCheckBox()
      #if canImport(AppKit)
        let label = UserFacing<StrictString, SDGInterfaceLocalizations.InterfaceLocalization>(
          { _ in
            "Check Box"
          })
        let checkBox = CheckBox(label: label, isChecked: Shared(false))
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          testViewConformance(of: checkBox)
        }
      #endif
    #endif
  }

  func testCocoaImage() {
    #if canImport(AppKit) || canImport(UIKit)
      var image = CocoaImage()
      let native = CocoaImage.NativeType()
      image.native = native
      _ = image.native
    #endif
  }

  func testCocoaView() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      let anchor = CocoaView()
      let window = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
        content: anchor
      )
      let cocoaWindow = window.cocoa()
      defer { cocoaWindow.close() }
      let popOver = CocoaView()
      anchor.displayPopOver(popOver, attachmentAnchor: .point(Point(0, 0)))
      anchor.displayPopOver(
        popOver,
        attachmentAnchor: .rectangle(
          .rectangle(Rectangle(origin: Point(10, 20), size: Size(width: 30, height: 40)))
        )
      )
    #endif
  }

  func testCocoaViewImplementation() {
    #if canImport(AppKit) || canImport(UIKit)
      let view = CocoaViewExample()
      _ = view.cocoa()
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          _ = view.swiftUI()
        }
      #endif
    #endif
  }

  func testCocoaWindow() {
    #if canImport(AppKit) || canImport(UIKit)
      let window = CocoaWindow(CocoaWindow.NativeType()).cocoa()
      window.size = Size(width: 100, height: 100)
    #endif
  }

  func testCocoaWindowImplementation() {
    #if canImport(AppKit) || canImport(UIKit)
      _ = CocoaWindowExample().cocoa()
    #endif
  }

  func testColour() {
    XCTAssertEqual(Colour.white.red, 1)
    XCTAssertEqual(Colour.black.green, 0)
    XCTAssertEqual(Colour.blue.blue, 1)
    XCTAssertEqual(Colour.green.opacity, 1)
    XCTAssertEqual(Colour.cyan.red, 0)
    XCTAssertEqual(Colour.red.green, 0)
    XCTAssertEqual(Colour.magenta.blue, 1)
    XCTAssertEqual(Colour.yellow.opacity, 1)
    #if canImport(AppKit)
      XCTAssertEqual(Colour.yellow.green, Colour(NSColor(Colour.yellow))?.green)
    #endif
    #if canImport(UIKit)
      XCTAssertEqual(Colour.cyan.blue, Colour(UIColor(Colour.cyan)).blue)
    #endif

    #if canImport(SwiftUI) || canImport(AppKit) || (canImport(UIKit) && !(os(iOS) && arch(arm)))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        testViewConformance(of: Colour.red, testBody: false)
      }
    #endif
  }

  func testCommandsBuilder() {
    _ = CommandsBuilder.buildBlock()
    _ = CommandsBuilder.buildBlock(EmptyCommands())
  }

  func testCommandsConcatenation() {
    let commands = CommandsBuilder.buildBlock(
      EmptyCommands(),
      EmptyCommands()
    )
    _ = commands.menuComponents()
    #if canImport(SwiftUI) && !os(tvOS) && !(os(iOS) && arch(arm))
      if #available(macOS 11, iOS 14, *) {
        _ = commands.swiftUICommands()
      }
    #endif
  }

  func testCompatibilityLabel() {
    #if canImport(SwiftUI)
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        let label = CompatibilityLabel(UserFacing<String, AnyLocalization>({ _ in "..." }))
        testViewConformance(of: label, testBody: false)
      }
    #endif
  }

  func testCompositeViewImplementation() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      struct TestView: CompositeViewImplementation {
        func compose() -> SDGInterface.EmptyView {
          return EmptyView()
        }
      }
      if #available(tvOS 13, iOS 13, *) {
        testViewConformance(of: TestView(), testBody: false)
      }
    #endif
  }

  func testContentMode() {
    for mode in SDGInterface.ContentMode.allCases {
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
          let swiftUI = SwiftUI.ContentMode(mode)
          let roundTrip = SDGInterface.ContentMode(swiftUI)
          XCTAssertEqual(roundTrip, mode)
        }
      #endif
    }
  }

  func testContextMenu() {
    #if canImport(UIKit) && !os(tvOS) && !os(watchOS)
      for localization in SDGInterfaceLocalizations.InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          _ = ContextMenu().cocoa()
        }
      }
    #endif
  }

  func testDemonstrations() {
    #if canImport(AppKit)
      MenuBarTarget.shared.demonstrateFullscreenWindow()
    #endif
  }

  func testDivider() {
    #if canImport(AppKit) || (canImport(UIKit) && !os(tvOS) && !os(watchOS))
      _ = Divider().cocoa()
    #endif
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(tvOS 13, iOS 13, *) {
        _ = Divider().swiftUI()
      }
    #endif
  }

  func testEdge() {
    for edge in SDGInterface.Edge.allCases {
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
          let swiftUI = SwiftUI.Edge(edge)
          let roundTrip = SDGInterface.Edge(swiftUI)
          XCTAssertEqual(roundTrip, edge)
        }
      #endif
    }
  }

  func testEdgeSet() {
    let horizontal = SDGInterface.Edge.Set.horizontal
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        let swiftUIHorizontal = SwiftUI.Edge.Set(horizontal)
        let roundTrip = SDGInterface.Edge.Set(swiftUIHorizontal)
        XCTAssertEqual(roundTrip, horizontal)
        for edge in SDGInterface.Edge.allCases {
          let swiftUIEdge = SwiftUI.Edge(edge)
          let entry = SDGInterface.Edge.Set(edge)
          let swiftUIEntry = SwiftUI.Edge.Set(swiftUIEdge)
          XCTAssertEqual(horizontal.contains(entry), swiftUIHorizontal.contains(swiftUIEntry))
        }
      }
    #endif
    for edge in SDGInterface.Edge.allCases {
      let set = SDGInterface.Edge.Set(edge)
      XCTAssert(set.contains(SDGInterface.Edge.Set(edge)))
      for other in SDGInterface.Edge.allCases where other ≠ edge {
        XCTAssertFalse(set.contains(SDGInterface.Edge.Set(other)))
      }
    }
  }

  func testEmptyMenuComponents() {
    let empty = EmptyMenuComponents()
    #if canImport(AppKit) || (canImport(UIKit) && !os(tvOS) && !os(watchOS))
      _ = empty.cocoa()
    #endif
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(tvOS 13, iOS 13, *) {
        _ = empty.swiftUI()
      }
    #endif
  }

  func testEmptyView() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        _ = EmptyView().swiftUI()
      }
    #endif
  }

  func testFetchResult() {
    #if canImport(UIKit)
      for result in FetchResult.allCases {
        let cocoa = result.cocoa
        XCTAssertEqual(result, FetchResult(cocoa))
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

  func testFramed() {
    _ = SDGInterface.EmptyView().frame(minWidth: 10, minHeight: 10)
  }

  func testHorizontalStack() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *) {
        testViewConformance(
          of: HorizontalStack(spacing: 0, content: [AnyView(CocoaView())]),
          testBody: false
        )
        testViewConformance(
          of: HorizontalStack(alignment: .top, spacing: 1, content: [AnyView(CocoaView())]),
          testBody: false
        )
        testViewConformance(
          of: HorizontalStack(alignment: .bottom, spacing: 2, content: [AnyView(CocoaView())]),
          testBody: false
        )
      }
    #endif
  }

  func testImage() {
    #if canImport(AppKit) || canImport(UIKit)
      MenuBarTarget.shared.demonstrateImage()

      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          let swiftUI = SwiftUI.Image(CocoaImage())
          let image = Image(swiftUI)
          _ = image.swiftUI()
          _ = image.cocoaImage()
        }
      #endif
    #endif
  }

  func testKeyModifiers() {
    let modifiers: KeyModifiers = [.command, .shift, .option, .control, .function, .capsLock]
    #if canImport(AppKit)
      XCTAssertEqual(KeyModifiers(modifiers.cocoa()), modifiers)
    #endif
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = modifiers.swiftUI()
      }
    #endif
  }

  func testLabel() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      MenuBarTarget.shared.demonstrateLabel()
    #endif
    let label = SDGInterface.Label<SDGInterfaceSample.InterfaceLocalization>(
      UserFacing({ _ in "..." }),
      colour: .black
    )
    if #available(macOS 10.15, tvOS 13, iOS 13, *) {
      let testBody: Bool
      // #workaround(Swift 5.3.2, SwiftUI would be a step backward from AppKit or UIKit without the ability to interact properly with menus such as “Copy”.)
      #if !canImport(AppKit) && !canImport(UIKit)
        testBody = true
      #else
        testBody = false
      #endif
      testViewConformance(of: label, testBody: testBody)
    }
  }

  func testLayered() {
    _ = SDGInterface.EmptyView().background(EmptyView())
  }

  func testLayoutConstraintPriority() {
    #if canImport(AppKit) || canImport(UIKit)
      _ = LayoutConstraintPriority(rawValue: 500)
    #endif
  }

  func testLegacyView() {
    class Legacy: LegacyView {
      #if canImport(AppKit) || canImport(UIKit)
        func cocoa() -> CocoaView {
          return EmptyView().cocoa()
        }
      #endif
    }
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
        _ = Legacy().swiftUIAnyView()
      }
    #endif
    let combined = SDGInterface.EmptyView().popOver(
      isPresented: Shared(false),
      content: { SDGInterface.EmptyView() }
    )
    if #available(macOS 10.15, tvOS 13, iOS 13, *) {
      let testBody: Bool
      #if os(tvOS)
        testBody = false
      #else
        testBody = true
      #endif
      testViewConformance(of: combined, testBody: testBody)
    }
  }

  func testLetterbox() {
    if #available(tvOS 13, iOS 13, *) {
      testViewConformance(
        of: SDGInterface.EmptyView().letterbox(aspectRatio: 1, background: EmptyView()),
        testBody: false
      )
    }
  }

  func testLog() {
    #if canImport(AppKit) || canImport(UIKit)
      MenuBarTarget.shared.demonstrateLog()
      if #available(macOS 10.12, tvOS 10, iOS 10, *) {
        let waited = expectation(description: "Waited for log to scroll.")
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in waited.fulfill() }
        waitForExpectations(timeout: 5, handler: nil)
      }
    #endif
  }

  func testMenu() {
    let entry = MenuEntry(
      label: UserFacing<StrictString, APILocalization>({ _ in "..." }),
      action: {}
    )
    let menuLabel = UserFacing<StrictString, APILocalization>({ _ in "initial" })
    let menu = SDGInterface.Menu(label: menuLabel, entries: { entry })
    #if canImport(AppKit) || (canImport(UIKit) && !os(tvOS))
      _ = menu.cocoa()
    #endif
    _ = menu.menuComponents()
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 11, tvOS 13, iOS 14, *) {
        _ = menu.swiftUI().body
        #if !os(tvOS)
          _ = menu.swiftUICommands().body
        #endif
      }
    #endif
  }

  func testMenuBar() {
    #if canImport(AppKit)
      let menuBar = MenuBar(applicationSpecificSubmenus: { EmptyCommands() })
      XCTAssertNotNil(menuBar)
      let submenu = menuBar.cocoa().items.first(where: { $0.submenu ≠ nil })
      XCTAssertNotNil(submenu)

      let previous = ProcessInfo.applicationName
      func testAllLocalizations() {
        defer {
          ProcessInfo.applicationName = previous
        }
        for localization in MenuBarLocalization.allCases {
          LocalizationSetting(orderOfPrecedence: [localization.code]).do {
            _ = TextContextMenu.contextMenu.menu
            _ = menuBar.cocoa()
          }
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

      _ = MenuBar(applicationSpecificSubmenus: { EmptyCommands() }).cocoa()
      if #available(macOS 11, *) {
        _ = MenuBar(applicationSpecificSubmenus: { EmptyCommands() }).swiftUI()
      }
    #endif
  }

  func testMenuComponentsBuilder() {
    _ = MenuComponentsBuilder.buildBlock()
    _ = MenuComponentsBuilder.buildBlock(EmptyMenuComponents())
    _ = MenuComponentsBuilder.buildBlock(
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents(),
      EmptyMenuComponents()
    )
  }

  func testMenuComponentsConcatenation() {
    let concatenation = MenuComponentsBuilder.buildBlock(
      EmptyMenuComponents(),
      EmptyMenuComponents()
    )
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 11, tvOS 13, iOS 14, *) {
        _ = concatenation.swiftUI()
      }
    #endif
  }

  func testMenuEntry() {
    if #available(tvOS 13, *) {
      let menuLabel = Shared<StrictString>("initial")
      let entry = MenuEntry<APILocalization>(
        label: UserFacing<StrictString, APILocalization>({ _ in "" }),
        action: {}
      )
      menuLabel.value = "changed"
      menuLabel.value = "unrelated"
      #if canImport(AppKit) || (canImport(UIKit) && !os(tvOS))
        _ = entry.cocoa()
      #endif
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 11, iOS 14, *) {
          _ = entry.swiftUI().body
        }
      #endif
      let withHotKey = MenuEntry<APILocalization>(
        label: UserFacing<StrictString, APILocalization>({ _ in "" }),
        hotKeyModifiers: [.command],
        hotKey: "a",
        action: {}
      )
      #if canImport(AppKit) || (canImport(UIKit) && !os(tvOS))
        _ = withHotKey.cocoa()
      #endif
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 11, iOS 14, *) {
          _ = withHotKey.swiftUI().body
        }
      #endif
      let hidden = MenuEntry<APILocalization>(
        label: UserFacing<StrictString, APILocalization>({ _ in "" }),
        action: {},
        isHidden: Shared(true)
      )
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 11, iOS 14, *) {
          _ = hidden.swiftUI().body
        }
      #endif
      #if canImport(UIKit)
        let withSelector = MenuEntry<APILocalization>(
          label: UserFacing<StrictString, APILocalization>({ _ in "" }),
          selector: #selector(NSObject.copy)
        )
        #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
          if #available(iOS 14, *) {
            _ = withSelector.swiftUI().body
          }
        #else
          _ = withSelector
        #endif
      #endif
    }
  }

  func testNotification() {
    _ = SystemNotification()
  }

  func testNSRectEdge() {
    #if canImport(AppKit)
      var converted: Set<NSRectEdge> = []
      for edge in SDGInterface.Edge.allCases {
        converted.insert(NSRectEdge(edge))
      }
      XCTAssertEqual(converted.count, 4)
    #endif
  }

  func testPadded() {
    _ = SDGInterface.EmptyView().padding()
  }

  func testPoint() {
    #if canImport(CoreGraphics)
      XCTAssertEqual(Point(CGPoint(x: 0, y: 0)), Point(0, 0))
      XCTAssertEqual(CGPoint(Point(0, 0)).x, 0)
    #endif
  }

  func testPopOver() {
    #if canImport(AppKit) || canImport(UIKit)
      let window = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
        content: EmptyView().cocoa()
      ).cocoa()
      window.content?.displayPopOver(EmptyView())
      #if canImport(UIKit)
        CocoaView().displayPopOver(EmptyView())
      #endif
    #endif
  }

  func testPopOverAttachmentAnchor() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        var shimmed = AttachmentAnchor.point(Point(0, 0))
        _ = PopoverAttachmentAnchor(shimmed)
        shimmed = AttachmentAnchor.rectangle(.rectangle(SDGInterface.Rectangle()))
        _ = PopoverAttachmentAnchor(shimmed)
      }
    #endif
  }

  func testProportioned() {
    _ = SDGInterface.EmptyView().aspectRatio(contentMode: .fill)
  }

  func testQuickActionDetails() {
    #if canImport(UIKit) && !os(tvOS) && !os(watchOS)
      var details = QuickActionDetails()
      let shortcutItem = UIApplicationShortcutItem(type: "", localizedTitle: "")
      details.shortcutItem = shortcutItem
      XCTAssertEqual(details.shortcutItem, shortcutItem)
    #endif
  }

  func testRectangle() {
    XCTAssertEqual(Rectangle(origin: Point(1, 2), size: Size(width: 3, height: 4)).size.height, 4)
    #if canImport(CoreGraphics)
      XCTAssertEqual(
        CGRect(Rectangle(origin: Point(1, 2), size: Size(width: 3, height: 4))).width,
        3
      )
      XCTAssertEqual(
        Rectangle(CGRect(x: 1, y: 2, width: 3, height: 4)),
        Rectangle(origin: Point(1, 2), size: Size(width: 3, height: 4))
      )
    #endif
  }

  func testRichText() throws {
    #if !os(Windows)  // #workaround(Swift 5.3.2, Segmentation fault.)
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
      // #workaround(Swift 5.3.2, Hashing appears broken on Windows.)
      #if !(os(Windows) || os(WASI))
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
      #else
        _ = doubled
        _ = doubledSeparately
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
      #else
        _ = nothingConcatenated
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
    #endif
  }

  func testSegmentedControl() {
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      MenuBarTarget.shared.demonstrateSegmentedControl()

      enum Enumeration: CaseIterable {
        case a, b
      }
      let segmentedControl = SegmentedControl(
        labels: { _ in
          UserFacing<ButtonLabel, SDGInterfaceLocalizations.InterfaceLocalization>({ _ in
            .text("label")
          })
        },
        selection: Shared(Enumeration.a)
      )
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        testViewConformance(of: segmentedControl)
      }
    #endif
  }

  func testSize() {
    XCTAssertEqual(Size(), Size(width: 0, height: 0))
    #if canImport(CoreGraphics)
      XCTAssertEqual(Size(CGSize(width: 0, height: 0)), Size(width: 0, height: 0))
    #endif
  }

  func testSwiftUIViewImplementation() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {  // @exempt(from: unicode)
        let view = SwiftUIViewExample()
        _ = view.swiftUI()
        #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
          _ = view.cocoa()
        #endif
      }
    #endif
  }

  func testSystemInterface() {
    class Interface: SystemInterface, Error {
      func finishLaunching(_ details: LaunchDetails) -> Bool {
        return true
      }
    }
    let interface = Interface()
    _ = interface.prepareToLaunch(LaunchDetails())
    _ = interface.finishLaunching(LaunchDetails())
    interface.prepareToAcquireFocus(nil)
    interface.finishAcquiringFocus(nil)
    interface.prepareToResignFocus(nil)
    interface.finishResigningFocus(nil)
    _ = interface.terminate()
    _ = interface.remainsRunningWithNoWindows
    interface.prepareToTerminate(nil)
    interface.prepareToHide(nil)
    interface.finishHiding(nil)
    interface.prepareToUnhide(nil)
    interface.finishUnhiding(nil)
    interface.prepareToUpdateInterface(nil)
    interface.finishUpdatingInterface(nil)
    _ = interface.reopen(hasVisibleWindows: nil)
    _ = interface.dockMenu
    _ = interface.preprocessErrorForDisplay(interface)
    interface.updateAccordingToScreenChange(nil)
    interface.finishGainingAccessToProtectedData()
    interface.prepareToLoseAccessToProtectedData()
    _ = interface.notifyHandoffBegan("")
    _ = interface.accept(handoff: Handoff(), details: HandoffAcceptanceDetails())
    _ = interface.notifyHandoffFailed("", error: interface)
    interface.preprocess(handoff: Handoff())
    interface.finishRegistrationForRemoteNotifications(deviceToken: Data())
    interface.reportFailedRegistrationForRemoteNotifications(error: interface)
    _ = interface.acceptRemoteNotification(details: RemoteNotificationDetails())
    _ = interface.open(files: [], details: OpeningDetails())
    _ = interface.shouldCreateNewBlankFile()
    _ = interface.createNewBlankFile()
    _ = interface.print(files: [], details: PrintingDetails())
    _ = interface.shouldEncodeRestorableState(coder: NSCoder())
    interface.prepareToEncodeRestorableState(coder: NSCoder())
    _ = interface.shouldRestorePreviousState(coder: NSCoder())
    interface.finishRestoring(coder: NSCoder())
    _ = interface.viewController(forRestorationIdentifierPath: [], coder: NSCoder())
    interface.updateAccordingToOcclusionChange(nil)
    interface.purgeUnnecessaryMemory()
    interface.updateAccordingToTimeChange()
    interface.handleEventsForBackgroundURLSession("")
    _ = interface.performQuickAction(details: QuickActionDetails())
    _ = interface.handleWatchRequest(userInformation: nil)
    interface.requestHealthAuthorization()
    _ = interface.shouldAllowExtension(details: ExtensionDetails())

    for response in PrintingResponse.allCases {
      #if canImport(AppKit)
        let cocoa = response.cocoa
        XCTAssertEqual(PrintingResponse(cocoa), response)
      #endif
    }
    for response in TerminationResponse.allCases {
      #if canImport(AppKit)
        let cocoa = response.cocoa
        XCTAssertEqual(TerminationResponse(cocoa), response)
      #endif
    }
    _ = interface.menuBar
  }

  func testTable() {
    #if canImport(AppKit) || canImport(UIKit)
      let data = Shared([0])
      let table = Table<Int>(
        data: data,
        columns: [
          { integer in
            let view = CocoaView()
            view.fill(
              with: SDGInterface.Label<SDGInterfaceLocalizations.InterfaceLocalization>(
                UserFacing({ _ in "\(integer.inDigits())" })
              )
              .cocoa()
            )
            return AnyView(view)
          }
        ],
        sort: { $0 < $1 }
      )
      let cocoa = table.cocoa()
      data.value = [2, 1]
      let window = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
        content: cocoa
      )
      window.display()
      #if canImport(UIKit)
        data.value = [2, 1]
        let uiTableView = table.cocoa().native as! UITableView
        uiTableView.dataSource?.tableView(
          uiTableView,
          cellForRowAt: IndexPath(row: 0, section: 0)
        )
        uiTableView.dataSource?.tableView(
          uiTableView,
          cellForRowAt: IndexPath(row: 0, section: 0)
        )
      #endif
    #endif
  }

  func testTextEditor() {
    #if (canImport(AppKit) || canImport(UIKit)) && !os(tvOS)
      MenuBarTarget.shared.demonstrateTextEditor()
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
      textView.showCharacterInformation(nil)

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
      textView.resetCasing(nil)
      textView.selectAll(nil)
      textView.makeUpperCase(nil)
      textView.selectAll(nil)
      textView.makeSmallCaps(nil)
      textView.selectAll(nil)
      textView.makeLowerCase(nil)

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
        XCTAssert(
          textView.canPerformAction(
            #selector(TextDisplayResponder.showCharacterInformation(_:)),
            withSender: nil
          )
        )
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
        XCTAssertFalse(
          textView.canPerformAction(
            #selector(TextDisplayResponder.showCharacterInformation(_:)),
            withSender: nil
          )
        )
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
      MenuBarTarget.shared.demonstrateTextField()
      forEachWindow { window in
        _ = TextField(contents: Shared(StrictString()))
      }
      MenuBarTarget.shared.demonstrateLabelledTextField()
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
        // #workaround(Swift 5.3.2, SwiftUI would be a step backward from AppKit or UIKit without the ability to get the selected text for menu items like “Show Character Information”.)
        #if !canImport(AppKit) && !canImport(UIKit)
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
      cocoaTextView.showCharacterInformation(nil)
      cocoaTextView.makeSuperscript(nil)
      cocoaTextView.makeSubscript(nil)
      cocoaTextView.resetBaseline(nil)
      cocoaTextView.makeUpperCase(nil)
      cocoaTextView.makeSmallCaps(nil)
      cocoaTextView.makeLowerCase(nil)
      cocoaTextView.resetCasing(nil)
      cocoaTextView.normalizeText(nil)
      #if canImport(UIKit)
        XCTAssertFalse(
          cocoaTextView.canPerformAction(
            #selector(RichTextEditingResponder.makeSubscript),
            withSender: nil
          )
        )
        cocoaTextView.selectedRange = NSRange(location: NSNotFound, length: NSNotFound)
        XCTAssertFalse(
          cocoaTextView.canPerformAction(
            #selector(TextDisplayResponder.showCharacterInformation),
            withSender: nil
          )
        )
        XCTAssertTrue(
          cocoaTextView.canPerformAction(#selector(UITextView.selectAll(_:)), withSender: nil)
        )
      #endif
    #endif
  }

  func testUIPopOverArrowDirection() {
    #if canImport(UIKit) && !(os(iOS) && arch(arm)) && !os(watchOS)
      var set: Set<UIPopoverArrowDirection.RawValue> = []
      for edge in SDGInterface.Edge.allCases {
        set.insert(UIPopoverArrowDirection(edge).rawValue)
      }
      XCTAssertEqual(set.count, SDGInterface.Edge.allCases.count)
    #endif
  }

  func testUnitPoint() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      let point = Point(1, 2)
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        let converted = UnitPoint(point)
        XCTAssertEqual(converted.x, 1)
        XCTAssertEqual(converted.y, 2)
        XCTAssertEqual(Point(converted), point)
      }
    #endif
  }

  func testView() {
    #if canImport(AppKit) || canImport(UIKit)
      func newView() -> CocoaView {
        #if canImport(AppKit)
          let native = NSView()
        #elseif canImport(UIKit)
          let native = UIView()
        #endif
        return CocoaView(native)
      }
      newView().fill(with: EmptyView().cocoa())
      newView().constrain(.width, toBe: .greaterThanOrEqual, 10)
      newView().position(
        subviews: [EmptyView().cocoa(), EmptyView().cocoa()],
        inSequenceAlong: .vertical
      )
      newView().centre(subview: EmptyView().cocoa())
      newView().equalize(.width, amongSubviews: [EmptyView().cocoa(), EmptyView().cocoa()])
      newView().equalize(.height, amongSubviews: [EmptyView().cocoa(), EmptyView().cocoa()])
      newView().constrain(
        .width,
        toBe: .equal,
        .width,
        ofSubviews: [EmptyView().cocoa(), EmptyView().cocoa()]
      )
      newView().constrain(
        .height,
        toBe: .equal,
        .height,
        ofSubviews: [EmptyView().cocoa(), EmptyView().cocoa()]
      )
      newView().alignCentres(
        ofSubviews: [EmptyView().cocoa(), EmptyView().cocoa()],
        on: .horizontal
      )
      newView().alignCentres(
        ofSubviews: [EmptyView().cocoa(), EmptyView().cocoa()],
        on: .vertical
      )
      newView().alignLastBaselines(ofSubviews: [
        EmptyView().cocoa(), EmptyView().cocoa(),
      ])
      _ = newView().aspectRatio(1, contentMode: .fit).cocoa()
      newView().position(
        subviews: [EmptyView().cocoa(), EmptyView().cocoa()],
        inSequenceAlong: .horizontal,
        padding: 0,
        leadingMargin: 0,
        trailingMargin: nil
      )

      #if !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          let swiftUI = newView().swiftUI()
          let window = Window(
            type: .primary(nil),
            name: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
            content: SwiftUI.AnyView(swiftUI).cocoa()
          ).cocoa()
          window.display()
          window.close()
        }
      #endif

      forAllLegacyModes {
        #if canImport(AppKit)
          typealias Superclass = NSView
        #else
          typealias Superclass = UIView
        #endif
        class IntrinsicSize: Superclass, CocoaViewImplementation {
          init(_ size: CGSize) {
            self.size = size
            super.init(frame: CGRect(origin: CGPoint(0, 0), size: size))
          }
          required init?(coder: NSCoder) {
            fatalError()
          }
          let size: CGSize
          override var intrinsicContentSize: CGSize {
            return size
          }
        }
        _ =
          IntrinsicSize(CGSize(width: 0, height: 1)).aspectRatio(nil, contentMode: .fill).cocoa()
        _ =
          IntrinsicSize(CGSize(width: 1, height: 0)).aspectRatio(nil, contentMode: .fill).cocoa()
        _ =
          IntrinsicSize(CGSize(width: 1, height: 1)).aspectRatio(nil, contentMode: .fill).cocoa()
      }

      forAllLegacyModes {
        _ = newView().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .centre).cocoa()
      }
    #endif
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        testViewConformance(of: SwiftUIViewExample())
      }
    #endif
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        struct SomeView: SwiftUI.View {
          var body: some SwiftUI.View {
            return SwiftUI.EmptyView()
          }
        }
        testViewConformance(of: SomeView())
      }
    #endif
  }

  func testWindow() {
    let window = Window(
      type: .primary(nil),
      name: UserFacing<StrictString, AnyLocalization>({ _ in "Title" }),
      content: EmptyView()
    )
    #if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
      let cocoaWindow = window.cocoa()
      #if canImport(AppKit)  // UIKit raises an exception during tests.
        cocoaWindow.display()
        cocoaWindow.location = Point(100, 200)
        cocoaWindow.size = Size(width: 300, height: 400)
      #endif
      defer { cocoaWindow.close() }

      #if canImport(AppKit)
        cocoaWindow.isFullscreen = true
        _ = cocoaWindow.isFullscreen
        let fullscreenWindow = Window(
          type: .fullscreen,
          name: UserFacing<StrictString, AnyLocalization>({ _ in "Fullscreen" }),
          content: EmptyView().cocoa()
        ).cocoa()
        fullscreenWindow.isFullscreen = true
        fullscreenWindow.display()
        defer { fullscreenWindow.close() }
      #endif
      RunLoop.main.run(until: Date() + 3)

      let neverOnscreen = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "Fullscreen" }),
        content: EmptyView().cocoa()
      ).cocoa()
      neverOnscreen.centreInScreen()

      #if canImport(UIKit)
        _ = Window(
          type: .primary(nil),
          name: UserFacing<StrictString, AnyLocalization>({ _ in "Title" }),
          content: EmptyView().cocoa()
        )
      #endif

      let primary = Window(
        type: .primary(nil),
        name: UserFacing<StrictString, AnyLocalization>({ _ in "..." }),
        content: EmptyView().cocoa()
      ).cocoa()
      _ = primary.size
      _ = primary.location
      #if canImport(AppKit)
        XCTAssert(primary.isPrimary)
        primary.isPrimary = false
        XCTAssertFalse(primary.isFullscreen)
        primary.isFullscreen = false
      #endif

      #if canImport(AppKit)
        let auxiliary = Window(
          type: .auxiliary(nil),
          name: UserFacing<StrictString, AnyLocalization>({ _ in "..." }),
          content: EmptyView().cocoa()
        ).cocoa()
        XCTAssert(auxiliary.isAuxiliary)
        primary.isAuxiliary = false
      #endif

      _ = cocoaWindow.isVisible
      cocoaWindow.location = Point(0, 0)

      if #available(macOS 11, tvOS 14, iOS 14, *) {
        #if !(canImport(UIKit) && (os(iOS) && arch(arm)))
          _ =
            Window(
              type: .primary(Size(width: 100, height: 100)),
              name: UserFacing<StrictString, AnyLocalization>({ _ in "Title" }),
              content: EmptyView()
            ).swiftUI().body.body
          #if canImport(AppKit)
            _ =
              Window(
                type: .fullscreen,
                name: UserFacing<StrictString, AnyLocalization>({ _ in "Title" }),
                content: EmptyView()
              ).swiftUI().body.body
          #endif
        #endif
      }
    #endif
  }
}
