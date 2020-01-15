/*
 AspectRatioPreviews.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGMathematics

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct AspectRatioPreviews: SwiftUI.View {

    internal var body: some SwiftUI.View {

      let circle = AnyView(
        Ellipse()
          .fill(Color.black)
      )

      return Group {

        previewBothModes(
          circle
            .aspectRatio(nil, contentMode: .fill).swiftUIView
            .frame(width: 124, height: 64),
          name: "nil + .fill"
        )

        previewBothModes(
          circle
            .aspectRatio(nil, contentMode: .fit).swiftUIView
            .frame(width: 124, height: 64),
          name: "nil + .fit"
        )

        previewBothModes(
          circle
            .aspectRatio(1 ÷ 2, contentMode: .fill).swiftUIView
            .frame(width: 124, height: 64),
          name: "(1 ÷ 2) + .fill"
        )

        previewBothModes(
          circle
            .aspectRatio(1 ÷ 2, contentMode: .fit).swiftUIView
            .frame(width: 124, height: 64),
          name: "(1 ÷ 2) + .fit"
        )
      }
    }
  }
#endif
