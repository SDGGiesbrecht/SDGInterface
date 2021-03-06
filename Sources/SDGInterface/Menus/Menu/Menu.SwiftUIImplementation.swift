/*
 Menu.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  extension Menu {

    @available(macOS 11, *)
    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      internal let label: UserFacing<StrictString, L>
      internal let entries: [MenuComponent]
      @ObservedObject internal var localization: Shared<LocalizationSetting>

      // MARK: - View

      private func entryView(index: Array<MenuComponent>.Index) -> some SwiftUI.View {
        let entry = entries[index]
        return entry.swiftUI()
      }
      internal var body: some SwiftUI.View {
        return SwiftUI.Menu(String(label.resolved(for: localization.value.resolved()))) {
          ForEach(entries.indices) { entryView(index: $0) }
        }
      }
    }
  }
#endif
