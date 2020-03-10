/*
 FramePreviews.swift

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

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct FramePreviews: SwiftUI.View {

    internal var body: some SwiftUI.View {

      func circle(radius: CGFloat) -> SwiftUI.AnyView {
        let diameter = radius × 2
        return SwiftUI.AnyView(
          Ellipse()
            .fill(Color.black)
            .frame(width: diameter, height: diameter)
        )
      }

      return Group {

        previewBothModes(
          circle(radius: 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .adjustForLegacyMode()
            .background(Color.red)
            .frame(width: 128, height: 64),
          name: "(≤ ∞) × (≤ ∞)"
        )

        previewBothModes(
          circle(radius: 16)
            .frame(idealWidth: 48, idealHeight: 48, alignment: .topLeading)
            .adjustForLegacyMode()
            .background(Color.red)
            .frame(width: 128, height: 64),
          name: "48 × 48, ↖"
        )

        previewBothModes(
          circle(radius: 16)
            .frame(minWidth: 48, minHeight: 48, alignment: .bottomTrailing)
            .adjustForLegacyMode()
            .background(Color.red)
            .frame(width: 128, height: 64),
          name: "(≥ 48) × (≥ 48), ↘"
        )

        previewBothModes(
          circle(radius: 16)
            .frame()
            .adjustForLegacyMode()
            .background(Color.red)
            .frame(width: 128, height: 64),
          name: "∅"
        )

        previewBothModes(
          SwiftUI.AnyView(
            SwiftUI.AnyView(Ellipse())
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .centre)
              .adjustForLegacyMode()
              .frame(width: 128, height: 64)
          ),
          name: "(≤ ∞) × (≤ ∞), no internal frame"
        )
      }
    }
  }
#endif
