/*
 ViewWithAlert.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGControlFlow

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension ViewWithAlert where V: View {

    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      internal let view: V
      internal let alert: Alert<L, M, N>
      @ObservedObject internal var isPresented: Shared<Bool>

      // MARK: - View

      internal var body: some SwiftUI.View {
        return view.swiftUI()
          .alert(
            isPresented: $isPresented.value
          ) {  // @exempt(from: tests) Would hang indefinitely.
            self.alert.swiftUI()
          }
      }
    }
  }
#endif
