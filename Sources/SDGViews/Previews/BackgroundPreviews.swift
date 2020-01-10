/*
 BackgroundPreviews.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGMathematics

  import SDGInterfaceBasics

  @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
  internal struct BackgroundPreviews: SwiftUI.View {

    internal var body: some SwiftUI.View {

      func circle(radius: CGFloat) -> AnyView {
        let diameter = radius × 2
        return AnyView(
          Ellipse()
            .fill(Color.black)
            .frame(width: diameter, height: diameter)
            .border(Color.green)
        )
      }

      return Group {

        previewBothModes(
          circle(radius: 16)
            .shimmedBackground(
              AnyView(
                Colour.red.swiftUIView
                  .frame(width: 48, height: 48)
              )
            )
            .swiftUIView
            .border(Color.blue)
            .frame(width: 128, height: 64),
          name: "red"
        )

        previewBothModes(
          circle(radius: 16)
            .shimmedBackground(
              AnyView(
                Colour.red.swiftUIView
                  .frame(width: 48, height: 48)
              ),
              alignment: .topLeading
            )
            .swiftUIView
            .border(Color.blue)
            .frame(width: 128, height: 64),
          name: "red, .topLeading"
        )

        previewBothModes(
          circle(radius: 16)
            .shimmedBackground(
              AnyView(
                Colour.red.swiftUIView
                  .frame(width: 48, height: 48)
              ),
              alignment: .bottomTrailing
            )
            .swiftUIView
            .border(Color.blue)
            .frame(width: 128, height: 64),
          name: "red, .bottomTrailing"
        )
      }
    }
  }
#endif
