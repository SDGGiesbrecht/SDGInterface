/*
 GenericLabel.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

// #workaround(Swift 5.2.4, Would be a step backward on other platforms without the ability to interact properly with menus.)
#if os(watchOS)
  @available(watchOS 6, *)
  extension GenericLabel {

    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      internal let text: UserFacing<S, L>
      internal let colour: SwiftUI.Color
      @ObservedObject internal var localization: Shared<LocalizationSetting>

      // MARK: - View

      internal var body: some SwiftUI.View {
        return Text(verbatim: String(text.resolved(for: localization.value.resolved())))
          .foregroundColor(colour)
      }
    }
  }
#endif
