/*
 SegmentedControl.SwiftUIImplementation.swift

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

import SDGInterfaceBasics

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(watchOS 6, *)
  extension SegmentedControl {

    @available(macOS 10.15, tvOS 13, iOS 13, *)
    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      internal let labels: (_ option: Option) -> UserFacing<ButtonLabel, L>
      @ObservedObject internal var selection: Shared<Option>
      @ObservedObject internal var localization: Shared<LocalizationSetting>

      // MARK: - View

      internal var body: some SwiftUI.View {
        #warning("Not implemented yet.")
        return SwiftUI.EmptyView()
      }
    }
  }
#endif
