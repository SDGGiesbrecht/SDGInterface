/*
 PaddingPreviews.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct PaddingPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      func square() -> SwiftUI.AnyView {
        return SwiftUI.AnyView(
          SwiftUI.Rectangle()
            .fill(Color.red)
            .frame(width: 32, height: 32)
        )
      }

      return Group {

        previewBothModes(
          square()
            .padding()
            .adjustForLegacyMode()
            .background(Color.blue),
          name: "Default"
        )

        previewBothModes(
          square()
            .padding(.horizontal, 16)
            .adjustForLegacyMode()
            .background(Color.blue),
          name: "Horizontal, 16"
        )
      }
    }
  }
#endif
