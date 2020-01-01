/*
 LetterboxPreviews.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(watchOS disabled only until Letterbox is converted to SwiftUI.)
#if canImport(SwiftUI) && !(os(iOS) && arch(arm)) && !os(watchOS) && !NO_PREVIEWS
  import SwiftUI

  @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
  internal struct LetterboxPreviews: SwiftUI.View {

    internal var body: some SwiftUI.View {
      func makeView() -> Letterbox<Ellipse> {
        return Letterbox(content: Ellipse(), aspectRatio: 1)
      }
      return Group {

        makeView().swiftUIView
          .previewLayout(.fixed(width: 128, height: 64))
          .previewDisplayName("Pillarbox")

        makeView().swiftUIView
          .previewLayout(.fixed(width: 64, height: 128))
          .previewDisplayName("Letterbox")
      }
    }
  }
#endif
