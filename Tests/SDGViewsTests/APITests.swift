/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGImageDisplay
import SDGApplication

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests : ApplicationTestCase {

    func testView() {
        #if canImport(AppKit) || canImport(UIKit)
        func newView() -> AnyNativeView {
            #if canImport(AppKit)
            let native = NSView()
            #elseif canImport(UIKit)
            let native = UIView()
            #endif
            return AnyNativeView(native)
        }
        newView().fill(with: EmptyView().native)
        newView().setMinimumSize(size: 10, axis: .horizontal)
        newView().position(subviews: [EmptyView().native, EmptyView().native], inSequenceAlong: .vertical)
        newView().centre(subview: EmptyView().native)
        newView().equalizeSize(amongSubviews: [EmptyView().native, EmptyView().native], on: .horizontal)
        newView().equalizeSize(amongSubviews: [EmptyView().native, EmptyView().native], on: .vertical)
        newView().lockSizeRatio(toSubviews: [EmptyView().native, EmptyView().native], coefficient: 1, axis: .horizontal)
        newView().lockSizeRatio(toSubviews: [EmptyView().native, EmptyView().native], coefficient: 1, axis: .vertical)
        newView().alignCentres(ofSubviews: [EmptyView().native, EmptyView().native], on: .horizontal)
        newView().alignCentres(ofSubviews: [EmptyView().native, EmptyView().native], on: .vertical)
        newView().alignFirstBaselines(ofSubviews: [EmptyView().native, EmptyView().native])
        newView().lockAspectRatio(to: 1)
        newView().position(subviews: [EmptyView().native, EmptyView().native], inSequenceAlong: .horizontal, padding: .specific(0), leadingMargin: .specific(8), trailingMargin: .automatic)
        #endif
    }
}
