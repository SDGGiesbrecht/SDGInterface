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
#if canImport(SwiftUI) && !(os(iOS) && arch(arm)) && !os(watchOS)
  import SwiftUI

  @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
  internal struct LetterboxPreviews: SwiftUI.View {

    /// Previews in one mode.
    func preview(width: CGFloat, height: CGFloat, legacyMode: Bool) -> some SwiftUI.View {
      let anyView: AnyView
      if legacyMode {
        let letterbox = Letterbox(content: Ellipse(), aspectRatio: 1)
        letterbox.colour = .red
        anyView = AnyView(letterbox.swiftUIView)
      } else {
        let letterbox = Ellipse()
          .aspectRatio(1 as Double, contentMode: .fit)
          .swiftUIView
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
          .background(Color.red)
        anyView = AnyView(letterbox)
      }
      return
        anyView
        .frame(width: width, height: height)
        .padding(1)
        .border(Color.gray, width: 1)
    }

    /// Previews in both modes side‐by‐side.
    func preview(width: CGFloat, height: CGFloat, name: String) -> some SwiftUI.View {
      let stack = HStack(spacing: 8) {
        preview(width: width, height: height, legacyMode: false)
        preview(width: width, height: height, legacyMode: true)
      }
      return
        stack
        .previewDisplayName(name)
    }

    internal var body: some SwiftUI.View {
      return Group {
        preview(width: 128, height: 64, name: "Pillarbox")
        preview(width: 64, height: 128, name: "Letterbox")
      }
    }
  }
#endif
