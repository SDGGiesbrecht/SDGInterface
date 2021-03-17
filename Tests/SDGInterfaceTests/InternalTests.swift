/*
 InternalTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

import SDGControlFlow
import SDGLogic
import SDGText
import SDGLocalization

@testable import SDGInterface

import SDGInterfaceLocalizations

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities
import SDGInterfaceTestUtilities
import SDGInterfaceInternalTestUtilities

final class InternalTests: ApplicationTestCase {

  func testApplicationName() {
    // #workaround(Swift 5.3.2, Web lacks ProcessInfo.)
    #if !os(WASI)
      let previous = ProcessInfo.applicationName
      func testAllLocalizations() {
        defer {
          ProcessInfo.applicationName = previous
        }
        let isolated = ApplicationNameForm.localizedIsolatedForm
        for localization in MenuBarLocalization.allCases {
          LocalizationSetting(orderOfPrecedence: [localization.code]).do {
            _ = isolated.resolved()
          }
        }
      }
      testAllLocalizations()

      ProcessInfo.applicationName = { form in
        switch form {
        case .english(.canada):
          return "..."
        default:
          return nil
        }
      }
      testAllLocalizations()
    #endif
  }

  func testButtonCocoaImplementation() {
    #if canImport(AppKit) || canImport(UIKit)
      let button = Button(
        label: UserFacing<StrictString, InterfaceLocalization>({ _ in "Button" }),
        action: {}
      )
      legacyMode = true
      defer { legacyMode = false }
      let cocoa = button.cocoa().native as! Button.Superclass
      #if canImport(AppKit)
        cocoa.sendAction(cocoa.action, to: cocoa.target)
      #else
        _ = cocoa
      #endif
    #endif
  }

  func testButtonLabel() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        _ = ButtonLabel.text("text").swiftUI()
        _ = ButtonLabel.symbol(Image.empty).swiftUI()
      }
    #endif
  }

  func testCheckBoxCocoaImplementation() {
    #if canImport(AppKit)
      let isChecked = Shared(false)
      let label = UserFacing<StrictString, SDGInterfaceLocalizations.InterfaceLocalization>(
        { _ in
          "Check Box"
        })
      let checkBox = CheckBox(label: label, isChecked: isChecked)
      legacyMode = true
      defer { legacyMode = false }
      let cocoa = checkBox.cocoa().native as! NSButton
      cocoa.state = .on
      XCTAssert(isChecked.value)
      isChecked.value = false
      XCTAssertEqual(cocoa.state, .off)
    #endif
  }

  func testImage() {
    #if canImport(AppKit)
      XCTAssertNil(Image(systemIdentifier: "no such image"))
    #endif
  }

  func testLegacyView() {
    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      forAllLegacyModes {
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          let combined = SDGInterface.EmptyView().popOver(
            isPresented: Shared(false),
            content: { SDGInterface.EmptyView() }
          ).adjustForLegacyMode()
          testViewConformance(of: combined, testBody: false)
        }
      }
    #endif
  }

  func testMenuEntry() {
    #if canImport(AppKit)
      let entry = MenuEntry<APILocalization>(
        label: UserFacing<StrictString, APILocalization>({ _ in "" }),
        action: {}
      ).cocoa().first!
      let selector = entry.target as? ClosureSelector
      selector?.send()
      _ = selector?.validateMenuItem(entry)
    #endif
  }

  func testNSApplicationDelegate() {
    struct Error: Swift.Error {}
    struct TestApplication: LegacyApplication {
      init() {
        self.init(preferenceManager: nil)
      }
      init(preferenceManager: PreferenceManager?) {
        self.preferenceManager = preferenceManager
      }
      let preferenceManager: PreferenceManager?
      // #workaround(Swift 5.3.2, Web lacks ProcessInfo.)
      #if !os(WASI)
        var applicationName: ProcessInfo.ApplicationNameResolver {
          return { _ in "Test Application" }
        }
        var applicationIdentifier: String {
          return "com.example.identifier"
        }
      #endif
      func finishLaunching(_ details: LaunchDetails) -> Bool {
        return true
      }
    }
    struct TestPreferenceManager: PreferenceManager {
      func openPreferences() {}
    }
    #if canImport(AppKit)
      var delegate = SDGInterface.NSApplicationDelegate(
        application: TestApplication(preferenceManager: TestPreferenceManager())
      )
      func testSystemInteraction() {
        let notification = Notification(name: Notification.Name(""))
        delegate.applicationWillFinishLaunching(notification)
        delegate.applicationDidFinishLaunching(notification)
        delegate.applicationWillBecomeActive(notification)
        delegate.applicationDidBecomeActive(notification)
        delegate.applicationWillResignActive(notification)
        delegate.applicationDidResignActive(notification)
        _ = delegate.applicationShouldTerminate(NSApplication.shared)
        _ = delegate.applicationShouldTerminateAfterLastWindowClosed(NSApplication.shared)
        delegate.applicationWillTerminate(notification)
        delegate.applicationWillHide(notification)
        delegate.applicationDidHide(notification)
        delegate.applicationWillUnhide(notification)
        delegate.applicationDidUnhide(notification)
        delegate.applicationWillUpdate(notification)
        delegate.applicationDidUpdate(notification)
        _ = delegate.applicationShouldHandleReopen(NSApplication.shared, hasVisibleWindows: false)
        _ = delegate.applicationDockMenu(NSApplication.shared)
        _ = delegate.application(NSApplication.shared, willPresentError: Error())
        delegate.applicationDidChangeScreenParameters(notification)
        _ = delegate.application(NSApplication.shared, willContinueUserActivityWithType: "")
        _ = delegate.application(
          NSApplication.shared,
          continue: NSUserActivity(activityType: " "),
          restorationHandler: { _ in }
        )
        delegate.application(NSApplication.shared, didUpdate: NSUserActivity(activityType: " "))
        delegate.application(
          NSApplication.shared,
          didRegisterForRemoteNotificationsWithDeviceToken: Data()
        )
        delegate.application(
          NSApplication.shared,
          didFailToRegisterForRemoteNotificationsWithError: Error()
        )
        delegate.application(NSApplication.shared, didReceiveRemoteNotification: [:])
        delegate.application(NSApplication.shared, open: [])
        _ = delegate.application(NSApplication.shared, openFileWithoutUI: "")
        _ = delegate.application(NSApplication.shared, openTempFile: "")
        _ = delegate.applicationOpenUntitledFile(NSApplication.shared)
        _ = delegate.applicationShouldOpenUntitledFile(NSApplication.shared)
        _ = delegate.application(
          NSApplication.shared,
          printFiles: [""],
          withSettings: [:],
          showPrintPanels: false
        )
        delegate.application(NSApplication.shared, didDecodeRestorableState: NSCoder())
        delegate.application(NSApplication.shared, willEncodeRestorableState: NSCoder())
        delegate.applicationDidChangeOcclusionState(notification)
        delegate.openPreferences(nil)
        _ = delegate.validateMenuItem(
          NSMenuItem(
            title: "",
            action: #selector(NSApplicationDelegateProtocol.openPreferences(_:)),
            keyEquivalent: ""
          )
        )
      }
      testSystemInteraction()

      delegate = SDGInterface.NSApplicationDelegate(
        application: TestApplication(preferenceManager: nil)
      )
      delegate = SDGInterface.NSApplicationDelegate(
        application: TestApplication(preferenceManager: TestPreferenceManager())
      )
      XCTAssert(
        delegate.validateMenuItem(
          NSMenuItem(
            title: "",
            action: #selector(NSApplicationDelegateProtocol.openPreferences(_:)),
            keyEquivalent: ""
          )
        )
      )
      XCTAssertFalse(
        delegate.validateMenuItem(NSMenuItem(title: "", action: nil, keyEquivalent: ""))
      )
    #endif
  }

  func testPopOverCocoaImplementation() {
    withLegacyMode {
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        let isPresented = Shared(false)
        if #available(macOS 10.15, tvOS 13, iOS 13, *) {
          let combined = SDGInterface.EmptyView().popOver(
            isPresented: isPresented,
            content: { SDGInterface.EmptyView() }
          ).adjustForLegacyMode()
          let window = Window(
            type: .primary(nil),
            name: UserFacing<StrictString, AnyLocalization>({ _ in "" }),
            content: combined
          )
          window.display()
          isPresented.value = true
        }
      #endif
    }
  }

  func testPreferenceManager() {
    // #workaround(Swift 5.3.2, Web lacks ProcessInfo.)
    #if !os(WASI)
      SampleApplication().preferenceManager?.openPreferences()
    #endif
  }

  func testProportionedView() {
    #if canImport(AppKit) || canImport(UIKit)
      _ = Proportioned(content: CocoaView(), aspectRatio: 1, contentMode: .fill).cocoa()
      _ = Proportioned(content: CocoaView(), aspectRatio: 1, contentMode: .fit).cocoa()
    #endif
  }

  func testSegmentedControlCocoaImplementation() {
    #if canImport(AppKit) || canImport(UIKit)
      enum Enumeration: CaseIterable {
        case a, b
      }
      let segmentedControl = SegmentedControl(
        labels: { _ in UserFacing<ButtonLabel, InterfaceLocalization>({ _ in .text("label") }) },
        selection: Shared(Enumeration.a)
      )
      legacyMode = true
      defer { legacyMode = false }
      let cocoa = segmentedControl.cocoa().native as! SegmentedControl.Superclass
      #if canImport(AppKit)
        cocoa.selectSegment(withTag: 1)
      #else
        cocoa.selectedSegmentIndex = 1
      #endif
    #endif
  }

  func testStrictString() {
    var string = StrictString()
    string.compatibility = "..."
    _ = string.compatibility
  }

  func testUIApplicationDelegate() {
    struct Error: Swift.Error {}
    struct TestApplication: LegacyApplication {
      init() {
        self.init(preferenceManager: nil)
      }
      init(preferenceManager: PreferenceManager?) {
        self.preferenceManager = preferenceManager
      }
      let preferenceManager: PreferenceManager?
      // #workaround(Swift 5.3.2, Web lacks ProcessInfo.)
      #if !os(WASI)
        var applicationName: ProcessInfo.ApplicationNameResolver {
          return { _ in "Test Application" }
        }
        var applicationIdentifier: String {
          return "com.example.identifier"
        }
      #endif
      func finishLaunching(_ details: LaunchDetails) -> Bool {
        return true
      }
    }
    struct TestPreferenceManager: PreferenceManager {
      func openPreferences() {}
    }
    #if canImport(UIKit)
      let delegate = SDGInterface.UIApplicationDelegate(
        application: TestApplication(preferenceManager: TestPreferenceManager())
      )
      func testSystemInteraction() {
        _ = delegate.application(UIApplication.shared, willFinishLaunchingWithOptions: nil)
        _ = delegate.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        delegate.applicationDidBecomeActive(UIApplication.shared)
        delegate.applicationWillResignActive(UIApplication.shared)
        delegate.applicationDidEnterBackground(UIApplication.shared)
        delegate.applicationWillEnterForeground(UIApplication.shared)
        delegate.applicationWillTerminate(UIApplication.shared)
        delegate.applicationProtectedDataDidBecomeAvailable(UIApplication.shared)
        delegate.applicationProtectedDataWillBecomeUnavailable(UIApplication.shared)
        delegate.applicationDidReceiveMemoryWarning(UIApplication.shared)
        delegate.applicationSignificantTimeChange(UIApplication.shared)
        _ = delegate.application(UIApplication.shared, shouldSaveApplicationState: NSCoder())
        _ = delegate.application(UIApplication.shared, shouldRestoreApplicationState: NSCoder())
        _ = delegate.application(
          UIApplication.shared,
          viewControllerWithRestorationIdentifierPath: [],
          coder: NSCoder()
        )
        delegate.application(UIApplication.shared, willEncodeRestorableStateWith: NSCoder())
        delegate.application(UIApplication.shared, didDecodeRestorableStateWith: NSCoder())
        delegate.application(
          UIApplication.shared,
          handleEventsForBackgroundURLSession: "",
          completionHandler: {}
        )
        delegate.application(
          UIApplication.shared,
          didRegisterForRemoteNotificationsWithDeviceToken: Data()
        )
        delegate.application(
          UIApplication.shared,
          didFailToRegisterForRemoteNotificationsWithError: Error()
        )
        delegate.application(
          UIApplication.shared,
          didReceiveRemoteNotification: [:],
          fetchCompletionHandler: { _ in }
        )
        _ = delegate.application(UIApplication.shared, willContinueUserActivityWithType: "")
        _ = delegate.application(
          UIApplication.shared,
          continue: NSUserActivity(activityType: " "),
          restorationHandler: { _ in }
        )
        delegate.application(UIApplication.shared, didUpdate: NSUserActivity(activityType: " "))
        #if !os(tvOS)
          delegate.application(
            UIApplication.shared,
            performActionFor: UIApplicationShortcutItem(type: "", localizedTitle: ""),
            completionHandler: { _ in }
          )
        #endif
        delegate.application(
          UIApplication.shared,
          handleWatchKitExtensionRequest: nil,
          reply: { _ in }
        )
        delegate.applicationShouldRequestHealthAuthorization(UIApplication.shared)
        _ = delegate.application(UIApplication.shared, open: URL(fileURLWithPath: ""))
        _ = delegate.application(
          UIApplication.shared,
          shouldAllowExtensionPointIdentifier: UIApplication.ExtensionPointIdentifier(rawValue: "")
        )
      }
      testSystemInteraction()
    #endif
  }

  func testUIResponder() {
    #if canImport(UIKit) && !os(tvOS)
      let executed = expectation(description: "Action executed.")
      let menuEntry = MenuEntry(
        label: UserFacing<StrictString, SDGInterfaceLocalizations.InterfaceLocalization>(
          { _ in
            "Menu Item"
          }),
        action: { executed.fulfill() }
      )
      UILabel().executeClosureAction(menuEntry.cocoa().first)
      wait(for: [executed], timeout: 1)
    #endif
  }
}
