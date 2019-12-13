/*
 PreviewTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
  final class PreviewTests: ApplicationTestCase {

    func simulateUse<V>(of view: V) where V: SwiftUI.View {
      _ = view.body
      _ = Window<InterfaceLocalization>.primaryWindow(
        name: .binding(Shared("")),
        view: AnyView(view)
      )
    }

    func testAspectRatioPreviews() {
      simulateUse(of: AspectRatioPreviews())
    }

    func testLetterboxPreviews() {
      simulateUse(of: LetterboxPreviews())
    }
  }
#endif
