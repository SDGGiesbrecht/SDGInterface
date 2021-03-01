/*
 MenuEntry.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI

  import SDGText
  import SDGLocalization

  extension MenuEntry {

    @available(macOS 10.15, *)
    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      let label: UserFacing<StrictString, L>
      let action: () -> Void
      let isDisabled: () -> Bool

      // MARK: - View

      var body: some SwiftUI.View {
        return Button(
          label: label,
          action: action
        ).swiftUI()
          .disabled(isDisabled())
      }
    }
  }
#endif
