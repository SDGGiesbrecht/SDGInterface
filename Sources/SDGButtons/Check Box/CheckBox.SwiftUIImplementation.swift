/*
 CheckBox.SwiftUIImplementation.swift

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

import SDGText
import SDGLocalization

import SDGInterfaceBasics

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(tvOS 13, iOS 13, watchOS 6, *)
  extension CheckBox {

    @available(macOS 10.15, *)
    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      internal let label: UserFacing<StrictString, L>
      @ObservedObject internal var localization: _Observable<LocalizationSetting>

      // MARK: - View

      internal var body: some SwiftUI.View {
        #warning("Not implemented yet.")
        return EmptyView()
      }
    }
  }
#endif
