/*
 LetterboxPreviews.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct LetterboxPreviews: SwiftUI.View {

    internal var body: some SwiftUI.View {

      func letterbox() -> AnyView {
        return AnyView(
          Ellipse().letterboxed(aspectRatio: 1, background: Color.red).swiftUIView
        )
      }

      return Group {

        previewBothModes(
          letterbox()
            .frame(width: 128, height: 64)
            .padding(1)
            .border(Color.gray, width: 1),
          name: "Pillarbox"
        )

        previewBothModes(
          letterbox()
            .frame(width: 64, height: 128)
            .padding(1)
            .border(Color.gray, width: 1),
          name: "Letterbox"
        )
      }
    }
  }
#endif
