/*
 BackgroundPreviews.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGMathematics

  import SDGInterface

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct BackgroundPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      func circle(radius: CGFloat) -> SwiftUI.AnyView {
        let diameter = radius × 2
        return SwiftUI.AnyView(
          Ellipse()
            .fill(Color.black)
            .frame(width: diameter, height: diameter)
            .border(Color.green)
        )
      }

      return Group {

        previewBothModes(
          circle(radius: 16)
            .background(
              SwiftUI.AnyView(
                Color.red
                  .frame(width: 48, height: 48)
              )
            )
            .adjustForLegacyMode()
            .border(Color.blue)
            .frame(width: 128, height: 64),
          name: "red"
        )

        previewBothModes(
          circle(radius: 16)
            .background(
              SwiftUI.AnyView(
                Color.red
                  .frame(width: 48, height: 48)
              ),
              alignment: .topLeading
            )
            .adjustForLegacyMode()
            .border(Color.blue)
            .frame(width: 128, height: 64),
          name: "red, .topLeading"
        )

        previewBothModes(
          circle(radius: 16)
            .background(
              SwiftUI.AnyView(
                Color.red
                  .frame(width: 48, height: 48)
              ),
              alignment: .bottomTrailing
            )
            .adjustForLegacyMode()
            .border(Color.blue)
            .frame(width: 128, height: 64),
          name: "red, .bottomTrailing"
        )

        previewBothModes(
          SwiftUI.AnyView(
            Ellipse()
              .aspectRatio(1, contentMode: .fit)
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .centre)
              .background(Colour.red)
              .adjustForLegacyMode()
          )
          .frame(width: 128, height: 64)
          .padding(1)
          .border(Color.gray, width: 1),
          name: "Behind Filling Frame"
        )
      }
    }
  }
#endif
