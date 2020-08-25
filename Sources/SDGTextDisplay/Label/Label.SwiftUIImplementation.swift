/*
 Label.SwiftUIImplementation.swift

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

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(watchOS 6, *)
  extension Label {

    @available(macOS 10.15, tvOS 13, iOS 13, *)
    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      internal let compatibilityText: UserFacing<String, L>
      internal let colour: SwiftUI.Color
      @ObservedObject internal var localization: Shared<LocalizationSetting>

      // MARK: - View

      internal var body: some SwiftUI.View {
        #warning("Verify appearance.")
        return Text(verbatim: compatibilityText.resolved(for: localization.value.resolved()))
          .foregroundColor(colour)
      }
    }
  }
#endif
