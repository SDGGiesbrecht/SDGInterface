/*
 APITests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
import SwiftUI
#endif

import SDGViews
import SDGApplication

import SDGInterfaceSample

import XCTest

import SDGXCTestUtilities

import SDGApplicationTestUtilities

final class APITests : ApplicationTestCase {

    func testLetterbox() {
        #if canImport(AppKit) || canImport(UIKit)
        Application.shared.demonstrateLetterbox()
        let letterbox = Letterbox(content: EmptyView(), aspectRatio: 1)
        letterbox.colour = .red
        XCTAssertEqual(letterbox.colour?.opacity, 1)
        #endif
    }

    func testRowView() {
        #if canImport(AppKit) || canImport(UIKit)
        if #available(iOS 9, *) { // @exempt(from: unicode)
            let row = RowView(views: [AnyNativeView()])
            row.views = [AnyNativeView()]
            _ = RowView(views: [AnyNativeView(), AnyNativeView()], spacing: .specific(0))
        }
        #endif
    }

    func testSwiftUIView() {
        #if !os(iOS) // #workaround(xcodebuild -version 11.1, @availability checks are broken for iOS.) @exempt(from: unicode)
        #if (canImport(AppKit) || canImport(UIKit)) && canImport(SwiftUI)
        if #available(macOS 10.15, iOS 13, tvOS 13, *) { // @exempt(from: unicode)
            struct SwiftUIViewType : SwiftUI.View {
                var body: some SwiftUI.View {
                    return Text(verbatim: "...")
                }
            }
            _ = SwiftUIView(SwiftUIViewType())
        }
        #endif
        #endif
    }

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
        newView().fill(with: EmptyView())
        newView().setMinimumSize(size: 10, axis: .horizontal)
        newView().position(subviews: [EmptyView(), EmptyView()], inSequenceAlong: .vertical)
        newView().centre(subview: EmptyView())
        newView().equalizeSize(amongSubviews: [EmptyView(), EmptyView()], on: .horizontal)
        newView().equalizeSize(amongSubviews: [EmptyView(), EmptyView()], on: .vertical)
        newView().lockSizeRatio(toSubviews: [EmptyView(), EmptyView()], coefficient: 1, axis: .horizontal)
        newView().lockSizeRatio(toSubviews: [EmptyView(), EmptyView()], coefficient: 1, axis: .vertical)
        newView().alignCentres(ofSubviews: [EmptyView(), EmptyView()], on: .horizontal)
        newView().alignCentres(ofSubviews: [EmptyView(), EmptyView()], on: .vertical)
        newView().alignLastBaselines(ofSubviews: [EmptyView(), EmptyView()])
        newView().lockAspectRatio(to: 1)
        newView().position(subviews: [EmptyView(), EmptyView()], inSequenceAlong: .horizontal, padding: .specific(0), leadingMargin: .specific(8), trailingMargin: .automatic)
        #endif
    }
}
