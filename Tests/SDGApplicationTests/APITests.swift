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

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGText
import SDGLocalization

import SDGInterface
import SDGTextDisplay
import SDGMenuBar
import SDGApplication

import SDGInterfaceLocalizations

import XCTest

import SDGLogicTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGApplicationTestUtilities

import SDGInterfaceSample

final class APITests: ApplicationTestCase {

  func testApplication() {
    struct ExampleApplication: Application {
      // #workaround(Swift 5.3.2, Web lacks ProcessInfo.)
      #if !os(WASI)
        var applicationName: ProcessInfo.ApplicationNameResolver {
          return { _ in "..." }
        }
        var applicationIdentifier: String {
          return "com.example.identifier"
        }
      #endif
      func finishLaunching(_ details: LaunchDetails) -> Bool {
        return true
      }
    }
    XCTAssertNil(ExampleApplication().preferenceManager)
  }

  func testDemonstrations() {
    #if canImport(AppKit)
      MenuBarTarget.shared.demonstrateFullscreenWindow()
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

  func testNotification() {
    _ = SystemNotification()
  }

  func testQuickActionDetails() {
    #if canImport(UIKit) && !os(tvOS) && !os(watchOS)
      var details = QuickActionDetails()
      let shortcutItem = UIApplicationShortcutItem(type: "", localizedTitle: "")
      details.shortcutItem = shortcutItem
      XCTAssertEqual(details.shortcutItem, shortcutItem)
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
    #if canImport(AppKit)
      _ = interface.dockMenu
    #endif
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
    #if canImport(AppKit)
      _ = interface.menuBar
    #endif
  }
}
