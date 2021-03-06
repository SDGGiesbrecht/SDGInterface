/*
 MenuComponent.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGText
  import SDGLocalization

  extension MenuComponent {

    @available(macOS 11, *)
    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      internal let component: MenuComponent

      // MARK: - View

      @ViewBuilder internal var body: some SwiftUI.View {
        switch component {
        case .entry(let entry):
          #warning("Placeholder.")
          SwiftUI.EmptyView()
        //entry.swiftUI()
        case .submenu(let submenu):
          SwiftUI.Group {}
          #warning("Placeholder")
        //submenu.swiftUI()
        case .separator:
          SwiftUI.AnyView(SwiftUI.EmptyView())
          #warning("Placeholder")
        }
      }
    }
  }
#endif
