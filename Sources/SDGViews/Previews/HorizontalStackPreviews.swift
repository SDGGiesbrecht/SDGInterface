/*
 HorizontalStackPreviews.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct HorizontalStackPreviews: SwiftUI.View {

    internal var body: some SwiftUI.View {

      func circle(colour: Color) -> AnyView {
        return AnyView(
          Ellipse()
            .fill(colour)
            .frame(width: 16, height: 16)
        )
      }

      return Group {

        previewBothModes(
          HorizontalStack(content: [
            circle(colour: .red),
            circle(colour: .green),
            circle(colour: .blue)
          ]).swiftUIView
            .frame(width: 128, height: nil, alignment: .center),
          name: "Red, Green, Blue"
        )

        previewBothModes(
          HorizontalStack(content: [
            circle(colour: .black)
          ]).swiftUIView
            .frame(width: 128, height: 32, alignment: .top),
          name: "Top"
        )

        previewBothModes(
          HorizontalStack(content: [
            circle(colour: .black)
          ]).swiftUIView
            .frame(width: 128, height: 32, alignment: .bottom),
          name: "Top"
        )
      }
    }
  }
#endif
