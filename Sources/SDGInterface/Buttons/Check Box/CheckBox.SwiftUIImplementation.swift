/*
 CheckBox.SwiftUIImplementation.swift

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

#if canImport(SwiftUI) && !(os(tvOS) || os(iOS) || os(watchOS))
  extension CheckBox {

    @available(macOS 10.15, *)
    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      internal let label: UserFacing<StrictString, L>
      @ObservedObject internal var isChecked: Shared<Bool>
      @ObservedObject internal var localization: Shared<LocalizationSetting>

      // MARK: - View

      internal var body: some SwiftUI.View {
        return Toggle(
          isOn: $isChecked.value,
          label: {
            Text(verbatim: String(label.resolved(for: localization.value.resolved())))
          }
        ).toggleStyle(CheckboxToggleStyle())
      }
    }
  }
#endif
