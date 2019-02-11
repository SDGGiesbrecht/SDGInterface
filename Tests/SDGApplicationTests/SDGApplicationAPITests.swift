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
import SDGXCTestUtilities

import SDGInterface
import SDGInterfaceLocalizations
import SDGInterfaceSample

final class SDGApplicationAPITests : ApplicationTestCase {

    func testApplicationName() {
        XCTAssertEqual(ProcessInfo.applicationName(.español(.de)), "del Ejemplar")
        XCTAssertEqual(ProcessInfo.applicationName(.deutsch(.akkusativ)), "Beispiel")
        XCTAssertEqual(ProcessInfo.applicationName(.deutsch(.dativ)), "Beispiel")
        XCTAssertEqual(ProcessInfo.applicationName(.français(.de)), "de l’Exemple")
        XCTAssertEqual(ProcessInfo.applicationName(.ελληνικά(.αιτιατική)), "το Παράδειγμα")
        XCTAssertEqual(ProcessInfo.applicationName(.ελληνικά(.γενική)), "του Παραδείγματος")
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

    func testMenu() {
        #if !os(tvOS)

        _ = LocalizedMenuItem(label: Shared(UserFacing<StrictString, APILocalization>({ _ in "..." })))

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

    func testPreferences() {
        ApplicationDelegate().openPreferences(nil)
        SampleApplicationDelegate().openPreferences(nil)
    }

    func testWindow() {
        let window = Window(title: "Title", size: CGSize(width: 700, height: 300))
        #if canImport(AppKit) // UIKit raises an exception during tests.
        window.makeKeyAndOrderFront(nil)
        #endif
        defer { window.close() }

        window.isFullscreen = true
        let fullscreenWindow = Window(title: "Fullscreen", size: CGSize(width: 700, height: 300))
        fullscreenWindow.isFullscreen = true
        #if canImport(AppKit) // UIKit raises an exception during tests.
        fullscreenWindow.makeKeyAndOrderFront(nil)
        #endif
        defer { fullscreenWindow.close() }
        RunLoop.main.run(until: Date() + 3)

        #if canImport(AppKit)
        XCTAssert((window as NSWindowDelegate).windowWillReturnFieldEditor?(window, to: nil) is NSTextView)
        #endif

        let neverOnscreen = Window(title: "Never Onscreen", size: CGSize.zero)
        neverOnscreen.centreInScreen()
    }
}
