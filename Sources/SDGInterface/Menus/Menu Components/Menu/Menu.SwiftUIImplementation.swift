/*
 Menu.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  @available(macOS 11, tvOS 13, iOS 14, watchOS 6, *)
  extension Menu where Components: MenuComponents {

    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      internal let label: UserFacing<StrictString, L>
      internal let entries: Components
      @ObservedObject internal var localization: Shared<LocalizationSetting>

      // MARK: - View

      internal var body: some SwiftUI.View {
        #if os(tvOS) || os(watchOS)
          return VStack {
            entries.swiftUI()
          }
        #else
          return SwiftUI.Menu(String(label.resolved(for: localization.value.resolved()))) {
            entries.swiftUI()
          }
        #endif
      }
    }
  }
#endif
