/*
 PreviewTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGControlFlow

  @testable import SDGViews
  import SDGWindows

  import SDGInterfaceSample

  import SDGApplicationTestUtilities

  final class PreviewTests: ApplicationTestCase {

    @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
    func simulateUse<V>(of view: V) where V: SwiftUI.View {
      _ = view.body
      _ = Window<InterfaceLocalization>.primaryWindow(
        name: .binding(Shared("")),
        view: AnyView(SwiftUI.AnyView(view))
      )
    }

    func testAspectRatioPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        simulateUse(of: AspectRatioPreviews())
      }
    }

    func testBackgroundPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        simulateUse(of: BackgroundPreviews())
      }
    }

    func testFramePreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        simulateUse(of: FramePreviews())
      }
    }

    func testHorizontalStackPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        simulateUse(of: HorizontalStackPreviews())
      }
    }

    func testLetterboxPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        simulateUse(of: LetterboxPreviews())
      }
    }

    func testPaddingPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        simulateUse(of: PaddingPreviews())
      }
    }
  }
#endif
