/*
 PaddingPreviews.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGInterfaceBasics

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct PaddingPreviews: SwiftUI.View {

    internal var body: some SwiftUI.View {

      func square() -> AnyView {
        return AnyView(
          Rectangle()
            .fill(Color.red)
        )
      }

      return Group {

        previewBothModes(
          square()
            .padding()
            .swiftUIView
            .background(Color.blue),
          name: "Default"
        )
      }
    }
  }
#endif