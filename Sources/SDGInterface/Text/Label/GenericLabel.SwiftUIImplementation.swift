/*
 GenericLabel.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

// #workaround(Swift 5.3.2, SwiftUI would be a step backward from AppKit or UIKit without the ability to interact properly with menus such as “Copy”.)
#if canImport(SwiftUI) && !canImport(AppKit) && !(canImport(UIKit) && !os(watchOS))
  @available(watchOS 6, *)
  extension GenericLabel {

    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      @ObservedObject internal var text: Shared<UserFacing<S, L>>
      internal let colour: SwiftUI.Color
      @ObservedObject internal var localization: Shared<LocalizationSetting>

      // MARK: - View

      internal var body: some SwiftUI.View {
        return Text(verbatim: String(text.value.resolved(for: localization.value.resolved())))
          .foregroundColor(colour)
      }
    }
  }
#endif
