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

      func circle(colour: Color, big: Bool = false) -> SDGViews.AnyView {
        let diameter: CGFloat = big ? 32 : 16
        return AnyView(
          SwiftUI.AnyView(
            Ellipse()
              .fill(colour)
              .frame(width: diameter, height: diameter)
          )
        )
      }

      return Group {

        previewBothModes(
          HorizontalStack(content: [
            circle(colour: .red),
            circle(colour: .green),
            circle(colour: .blue),
          ]).adjustForLegacyMode()
            .frame(width: 128, height: 32, alignment: .center),
          name: "Red, Green, Blue"
        )

        previewBothModes(
          HorizontalStack(
            alignment: .top,
            content: [
              circle(colour: .black),
              circle(colour: .black, big: true),
            ]
          ).adjustForLegacyMode()
            .frame(width: 128, height: 32, alignment: .center),
          name: "Top"
        )

        previewBothModes(
          HorizontalStack(
            alignment: .bottom,
            content: [
              circle(colour: .black),
              circle(colour: .black, big: true),
            ]
          ).adjustForLegacyMode()
            .frame(width: 128, height: 32, alignment: .center),
          name: "Bottom"
        )
      }
    }
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  struct HorizontalStack_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
      return HorizontalStackPreviews()
    }
  }
#endif
