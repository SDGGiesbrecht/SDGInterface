/*
 GenericLabel.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGControlFlow
import SDGText
import SDGLocalization

#if canImport(SwiftUI)
  @available(watchOS 6, *)
  extension GenericLabel {

    @available(macOS 12, tvOS 13, iOS 13, watchOS 6, *)
    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      @ObservedObject internal var text: Shared<UserFacing<S, L>>
      internal let colour: SwiftUI.Color
      @ObservedObject internal var localization: Shared<LocalizationSetting>

      // MARK: - View

      @ViewBuilder internal var body: some SwiftUI.View {  // @exempt(from: tests)
        let base = Text(verbatim: String(text.value.resolved(for: localization.value.resolved())))
          .foregroundColor(colour)
        #if os(tvOS) || os(watchOS)
          base
        #else
          if #available(iOS 15, *) {
            base
              .textSelection(.enabled)
          } else {
            // @exempt(from: tests)
            base
          }
        #endif
      }
    }
  }
#endif
