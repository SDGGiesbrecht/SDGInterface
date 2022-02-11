/*
 SegmentedControl.SwiftUIImplementation.swift

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

#if canImport(SwiftUI) && !(os(iOS) && arch(arm)) && !os(watchOS)
  extension SegmentedControl {

    @available(macOS 10.15, tvOS 13, iOS 13, *)
    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      internal let labels: (_ option: Option) -> UserFacing<ButtonLabel, L>
      @ObservedObject internal var selection: Shared<Option>
      @ObservedObject internal var localization: Shared<LocalizationSetting>

      // MARK: - View

      private var content: some SwiftUI.View {
        let content = ForEach(Array(Option.allCases), id: \.self) { option in
          return self.labels(option).resolved().swiftUI()
        }
        #if DEBUG
          for entry in Option.allCases {
            _ = content.content(entry)  // Eager execution to simplify testing.
          }
        #endif
        return content
      }

      internal var body: some SwiftUI.View {
        return Picker(
          selection: $selection.value,
          label: SwiftUI.EmptyView(),
          content: { content }
        ).pickerStyle(SegmentedPickerStyle())
      }
    }
  }
#endif
