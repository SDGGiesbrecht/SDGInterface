/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

import SDGInterfaceBasics
import SDGViews
import SDGTextDisplay
import SDGTables
import SDGWindows
import SDGMenus
import SDGContextMenu
import SDGInterfaceElements
import SDGMenuBar
import SDGApplication

import SDGInterfaceLocalizations

import XCTest

import SDGLogicTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGApplicationTestUtilities

import SDGInterfaceSample

final class APITests : ApplicationTestCase {

    func testButton() {
        #if canImport(AppKit) || canImport(UIKit)
        Application.shared.demonstrateButton()
        let label = Shared(UserFacing<StrictString, APILocalization>({ _ in "Button" }))
        let button = Button(label: label)
        label.value = UserFacing<StrictString, APILocalization>({ _ in "Changed" })
        #if canImport(AppKit)
        XCTAssertEqual(button.title, "Changed")
        #else
        XCTAssertEqual(button.titleLabel?.text, "Changed")
        #endif
        button.label = Shared(UserFacing<StrictString, APILocalization>({ _ in "Changed again." }))
        #endif
    }

    func testButtonSet() {
        #if canImport(AppKit) || canImport(UIKit)
        Application.shared.demonstrateButtonSet()
        #endif
    }

    func testCheckBox() {
        #if canImport(AppKit) || canImport(UIKit)
        Application.shared.demonstrateCheckBox()
        #if canImport(AppKit)
        let label = Shared(UserFacing<StrictString, APILocalization>({ _ in "Check Box" }))
        let checkBox = CheckBox(label: label)
        label.value = UserFacing<StrictString, APILocalization>({ _ in "Changed" })
        XCTAssertEqual(checkBox.title, "Changed")
        checkBox.label = Shared(UserFacing<StrictString, APILocalization>({ _ in "Changed again." }))
        #endif
        #endif
    }

    func testDemonstrations() {
        #if canImport(AppKit)
        Application.shared.demonstrateFullscreenWindow()
        #endif
    }

    func testFetchResult() {
        #if canImport(UIKit)
        for result in FetchResult.allCases {
            let native = result.native
            XCTAssertEqual(result, FetchResult(native))
        }
        #endif
    }

    func testLetterbox() {
        #if canImport(AppKit) || canImport(UIKit)
        Application.shared.demonstrateLetterbox()
        let letterbox = Letterbox(content: EmptyView().native, aspectRatio: 1)
        letterbox.colour = .red
        XCTAssertEqual(letterbox.colour?.opacity, 1)
        #endif
    }

    func testKeyModifiers() {
        let modifiers: KeyModifiers = [.command, .shift, .option, .control, .function, .capsLock]
        #if canImport(AppKit)
        XCTAssertEqual(KeyModifiers(modifiers.native), modifiers)
        #endif
    }

    func testNotification() {
        _ = SystemNotification()
    }

    func testPreferences() {
        Application.shared.preferenceManager?.openPreferences()
    }

    func testSystemMediator() {
        class Mediator : SystemMediator, Error {
            func finishLaunching(_ details: LaunchDetails) -> Bool {
                return true
            }
        }
        let mediator = Mediator()
        _ = mediator.prepareToLaunch(LaunchDetails())
        _ = mediator.finishLaunching(LaunchDetails())
        mediator.prepareToAcquireFocus(nil)
        mediator.finishAcquiringFocus(nil)
        mediator.prepareToResignFocus(nil)
        mediator.finishResigningFocus(nil)
        _ = mediator.terminate()
        _ = mediator.remainsRunningWithNoWindows
        mediator.prepareToTerminate(nil)
        mediator.prepareToHide(nil)
        mediator.finishHiding(nil)
        mediator.prepareToUnhide(nil)
        mediator.finishUnhiding(nil)
        mediator.prepareToUpdateInterface(nil)
        mediator.finishUpdatingInterface(nil)
        _ = mediator.reopen(hasVisibleWindows: nil)
        #if canImport(AppKit)
        _ = mediator.dockMenu
        #endif
        _ = mediator.preprocessErrorForDisplay(mediator)
        mediator.updateAccordingToScreenChange(nil)
        mediator.finishGainingAccessToProtectedData()
        mediator.prepareToLoseAccessToProtectedData()
        _ = mediator.notifyHandoffBegan("")
        _ = mediator.accept(handoff: Handoff(), details: HandoffAcceptanceDetails())
        _ = mediator.notifyHandoffFailed("", error: mediator)
        mediator.preprocess(handoff: Handoff())
        mediator.finishRegistrationForRemoteNotifications(deviceToken: Data())
        mediator.reportFailedRegistrationForRemoteNotifications(error: mediator)
        _ = mediator.acceptRemoteNotification(details: RemoteNotificationDetails())
        _ = mediator.open(files: [], details: OpeningDetails())
        _ = mediator.shouldCreateNewBlankFile()
        _ = mediator.createNewBlankFile()
        _ = mediator.print(files: [], details: PrintingDetails())
        _ = mediator.shouldEncodeRestorableState(coder: NSCoder())
        mediator.prepareToEncodeRestorableState(coder: NSCoder())
        _ = mediator.shouldRestorePreviousState(coder: NSCoder())
        mediator.finishRestoring(coder: NSCoder())
        _ = mediator.viewController(forRestorationIdentifierPath: [], coder: NSCoder())
        mediator.updateAccordingToOcclusionChange(nil)
        mediator.purgeUnnecessaryMemory()
        mediator.updateAccordingToTimeChange()
        mediator.handleEventsForBackgroundURLSession("")
        _ = mediator.performQuickAction(details: QuickActionDetails())
        _ = mediator.handleWatchRequest(userInformation: nil)
        mediator.requestHealthAuthorization()
        _ = mediator.shouldAllowExtension(details: ExtensionDetails())

        for response in PrintingResponse.allCases {
            #if canImport(AppKit)
            let native = response.native
            XCTAssertEqual(PrintingResponse(native), response)
            #endif
        }
        for response in TerminationResponse.allCases {
            #if canImport(AppKit)
            let native = response.native
            XCTAssertEqual(TerminationResponse(native), response)
            #endif
        }
    }
}
